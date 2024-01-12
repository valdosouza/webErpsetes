import 'dart:convert';

import 'package:appweb/app/core/shared/utils/toast.dart';
import 'package:appweb/app/core/shared/widgets/custom_imput_button.dart';
import 'package:appweb/app/core/shared/widgets/custom_input.dart';
import 'package:appweb/app/modules/Core/data/model/order_sale_item_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_customer_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_payment_types_list.dart';
import 'package:appweb/app/modules/order_sale_register/order_sale_register_module.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/state.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/core/shared/helpers/local_storage.dart';
import 'package:appweb/app/core/shared/local_storage_key.dart';

class ContentOrderMain extends StatefulWidget {
  const ContentOrderMain({
    Key? key,
  }) : super(key: key);

  @override
  State<ContentOrderMain> createState() => _ContentOrderMainState();
}

class _ContentOrderMainState extends State<ContentOrderMain>
    with SingleTickerProviderStateMixin {
  late final OrderSaleRegisterBloc bloc;
  late MaskedTextController controllerDate;
  bool selectPaymentTime = false;
  final _formKey = GlobalKey<FormState>();
  BluetoothDevice? _device;
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<OrderSaleRegisterBloc>();
    Future.delayed(const Duration(milliseconds: 100)).then((_) async {
      await Modular.isModuleReady<OrderSaleRegisterModule>();
    });
    getPrinter();
  }

  getPrinter() async {
    var strPrinter = await LocalStorageService.instance
        .get(key: LocalStorageKey.blthPrinter, defaultValue: '');

    if (strPrinter.isNotEmpty) {
      Map<String, dynamic> jsonPrinter = json.decode(strPrinter);
      _device = BluetoothDevice.fromJson(jsonPrinter);
    }
  }

  printerOder() async {
    Map<String, dynamic> config = {};
    int nrColums = 32;
    int columsString = 0;

    config['width'] = 40;
    config['height'] = 70;
    config['gap'] = 2;
    List<LineText> list = [];

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '================================',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '======= Estabelecimento =========',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '================================',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "N. PEDIDO : ${bloc.orderMain.order.id}",
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "DATA      : ${bloc.orderMain.order.dtRecord}",
        weight: 1,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '================================',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    columsString = bloc.orderMain.orderSale.nameCustomer.length;
    if (columsString < nrColums) {
      nrColums = columsString;
    }

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content:
            'CLIENTE   : ${bloc.orderMain.orderSale.nameCustomer.substring(1, nrColums)}',
        weight: 1,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    nrColums = 32;

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '================================',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));

    columsString = bloc.orderMain.orderSale.nameSalesman.length;
    if (columsString < nrColums) {
      nrColums = columsString;
    }

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content:
            'VENDEDOR  : ${bloc.orderMain.orderSale.nameSalesman.substring(1, nrColums)}',
        weight: 1,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    nrColums = 32;

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '================================',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Descricao dos Produtos  ',
        weight: 1,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Qte  X   VL.Unit =     Sub-Total',
        weight: 1,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '================================',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));

    // Imprime itens do pedido...
    double subtotal = 0.0;
    double qttyItens = 0;
    for (int i = 0; i < bloc.orderMain.items.length; i++) {
      columsString = bloc.orderMain.items[i].nameProduct.length;
      if (columsString < nrColums) {
        nrColums = columsString;
      }

      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: bloc.orderMain.items[i].nameProduct.substring(1, nrColums),
          weight: 1,
          align: LineText.ALIGN_LEFT,
          linefeed: 1));
      nrColums = 32;

      subtotal =
          bloc.orderMain.items[i].quantity * bloc.orderMain.items[i].unitValue;

      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content:
              '${bloc.orderMain.items[i].quantity.toStringAsFixed(2)} X ${bloc.orderMain.items[i].unitValue.toStringAsFixed(2)} = ${subtotal.toStringAsFixed(2)}',
          weight: 1,
          align: LineText.ALIGN_LEFT,
          linefeed: 1));

      qttyItens += bloc.orderMain.items[i].quantity;

      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: '================================',
          weight: 1,
          align: LineText.ALIGN_CENTER,
          linefeed: 1));
    }
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'TOTAL ITENS : ${qttyItens.toStringAsFixed(2)}',
        weight: 1,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '================================',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));

    if (bloc.orderMain.orderTotalizer.discountValue > 0) {
      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content:
              'Subtotal    : ${bloc.orderMain.orderTotalizer.productValue.toStringAsFixed(2)}',
          weight: 1,
          align: LineText.ALIGN_LEFT,
          linefeed: 1));

      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content:
              'Desconto    : ${bloc.orderMain.orderTotalizer.discountValue.toStringAsFixed(2)}',
          weight: 1,
          align: LineText.ALIGN_LEFT,
          linefeed: 1));
    }

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content:
            'Valor total : ${bloc.orderMain.orderTotalizer.totalValue.toStringAsFixed(2)}',
        weight: 1,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));

    if (!kIsWeb) {
      bool? connect = await bluetoothPrint.isConnected;
      if (!connect!) {
        await bluetoothPrint.connect(_device!);
      }
      await bluetoothPrint.printReceipt(config, list);
      //await bluetoothPrint.disconnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<OrderSaleItemModel> itemslistEnabled =
        bloc.orderMain.items.where((i) => i.updateStatus != "D").toList();
    return BlocConsumer<OrderSaleRegisterBloc, OrderSaleRegisterState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is ErrorState) {
          CustomToast.showToast("Erro: ${state.message}");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: kBoxDecorationflexibleSpace,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                bloc.add(ReturnToOrderMainEvent());
              },
            ),
            title: Text(
              "Pedido ${bloc.orderMain.orderSale.number}",
              style: kHintTextStyle.copyWith(fontSize: 20.0),
            ),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: (() async {
                      await printerOder();
                    }),
                    value: 0,
                    child: const Text("Imprimir"),
                  ),
                ],
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: _date(),
                        ),
                        const SizedBox(width: 5.0),
                        Expanded(
                          flex: 1,
                          child: _number(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    _customer(),
                    const SizedBox(height: 8.0),
                    _itemsList(itemslistEnabled),
                    const SizedBox(height: 8.0),
                    _paymentTypes(),
                    const SizedBox(height: 8.0),
                    //_timePayments(),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: _totalOrder(itemslistEnabled),
                        ),
                        const SizedBox(width: 5.0),
                        Expanded(
                          flex: 1,
                          child: _plots(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8.0),
                    _deadline(),
                    const SizedBox(height: 8.0),
                    _observation(),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: (bloc.orderMain.order.status != "F")
              ? FloatingActionButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (bloc.orderMain.order.id == 0) {
                        bloc.add(PostOrderEvent());
                      } else {
                        bloc.add(PutOrderEvent());
                      }
                    }
                  },
                  backgroundColor: Colors.black,
                  child: const Icon(
                    Icons.save,
                    color: kSecondaryColor,
                  ),
                )
              : null,
        );
      },
    );
  }

  _date() {
    return CustomInput(
      title: "Data",
      controller: MaskedTextController(
          mask: '00/00/0000', text: bloc.orderMain.order.dtRecord),
      keyboardType: TextInputType.datetime,
      inputAction: TextInputAction.go,
      onChanged: null,
      readOnly: true,
    );
  }

  _number() {
    return CustomInput(
        readOnly: (bloc.orderMain.order.status == "F"),
        title: "Número",
        initialValue: bloc.orderMain.orderSale.number.toString(),
        keyboardType: TextInputType.number,
        inputAction: TextInputAction.go,
        onChanged: (value) =>
            {bloc.orderMain.orderSale.number = int.parse(value)});
  }

  _customer() {
    return CustomInputButton(
      readOnly: (bloc.orderMain.order.status != "F"),
      enabled: true,
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.go,
      initialValue: bloc.orderMain.orderSale.nameCustomer,
      title: "Descrição da Cliente",
      suffixIcon: const Icon(
        Icons.search,
        size: 20.0,
        color: Colors.white,
      ),
      onAction: (() => {
            (bloc.orderMain.order.status != "F")
                ? bloc.add(GetCustomerListEvent(
                    params: ParamsCustomerList(
                    tbInstitutionId: 0,
                    tbSalesmanId: 0,
                    page: 0,
                    id: 0,
                    nameCustomer: bloc.searchCustomer,
                  )))
                : null
          }),
      validator: (value) {
        if ((value == null) || (value.isEmpty)) {
          return "Campo cliente obrigatório";
        }
        return null;
      },
    );
  }

  _itemsList(List<OrderSaleItemModel> items) {
    return CustomInputButton(
      enabled: true,
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.go,
      initialValue: (items.isEmpty)
          ? "Selecione os itens do pedido"
          : "Selectionado(s) ${items.length.toString()}",
      title: "Lista de Itens do Pedido",
      onAction: (() => {
            bloc.add(GetItemsListEvent(
                params: ParamsItemsList(tbOrderId: bloc.orderMain.order.id))),
          }),
      validator: (value) {
        if ((items.isEmpty)) {
          return "Ordem sem items, Verifique!";
        }
        return null;
      },
    );
  }

  _totalOrder(List<OrderSaleItemModel> items) {
    double productValue = 0;
    double productQtde = 0;
    double itemsQtde = 0;
    for (OrderSaleItemModel item in items) {
      productValue += (item.quantity * item.unitValue);
      productQtde += 1;
      itemsQtde += item.quantity;
    }
    bloc.orderMain.orderTotalizer.productValue = productValue;
    bloc.orderMain.orderTotalizer.productQtde = productQtde;
    bloc.orderMain.orderTotalizer.itemsQtde = itemsQtde;
    bloc.orderMain.orderTotalizer.totalValue = productValue;
    return CustomInput(
      readOnly: true,
      title: "Valor do Pedido",
      initialValue: productValue.toStringAsFixed(2),
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.go,
      onChanged: null,
    );
  }

  _paymentTypes() {
    return CustomInputButton(
      enabled: true,
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.go,
      initialValue: bloc.orderMain.orderBilling.namePayment,
      title: "Descrição do Forma de Pagamento",
      onAction: (() => {
            (bloc.orderMain.order.status != "F")
                ? bloc.add(GetPaymentTypesListEvent(
                    params: ParamsPaymentList(
                    tbInstitutionId: 0,
                    page: bloc.pagePaymentTypes,
                  )))
                : null
          }),
      validator: (value) {
        if ((value == null) || (value.isEmpty)) {
          return "Campo forma de pagamento obrigatório";
        }
        return null;
      },
    );
  }

  _plots() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        const Text("Parcelas", style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          width: 200,
          height: 50,
          child: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      bloc.orderMain.orderBilling.plots -= 1;
                      if (bloc.orderMain.orderBilling.plots < 0) {
                        bloc.orderMain.orderBilling.plots = 0;
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.remove,
                    size: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    bloc.orderMain.orderBilling.plots.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      bloc.orderMain.orderBilling.plots += 1;
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _deadline() {
    return CustomInput(
      readOnly: false,
      title: "Parcelamento em dias ex: 028/056",
      initialValue: bloc.orderMain.orderBilling.deadline,
      keyboardType: TextInputType.text,
      inputAction: TextInputAction.go,
      onChanged: (value) => {bloc.orderMain.orderBilling.deadline = value},
      validator: (value) {
        if (bloc.orderMain.orderBilling.plots > 0) {
          if ((value == null) || (value.isEmpty)) {
            return "Parcelas acima de 0(zero) campo obrigatório";
          }
        }
        return null;
      },
    );
  }

  _observation() {
    return CustomInput(
        readOnly: (bloc.orderMain.order.status == "F"),
        title: "Observações",
        maxLines: 10,
        initialValue: bloc.orderMain.order.note,
        keyboardType: TextInputType.multiline,
        inputAction: TextInputAction.go,
        onChanged: (value) => bloc.orderMain.order.note = value);
  }
}
