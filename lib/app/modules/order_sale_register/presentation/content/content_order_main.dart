import 'package:appweb/app/core/shared/utils/toast.dart';
import 'package:appweb/app/core/shared/widgets/custom_imput_button.dart';
import 'package:appweb/app/core/shared/widgets/custom_input.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/items_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_customer_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_payment_types_list.dart';
import 'package:appweb/app/modules/order_sale_register/order_sale_register_module.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb/app/core/shared/theme.dart';

class ContentOrderMain extends StatefulWidget {
  final int tbOrderId;
  const ContentOrderMain({
    Key? key,
    this.tbOrderId = 0,
  }) : super(key: key);

  @override
  State<ContentOrderMain> createState() => _ContentOrderMainState();
}

class _ContentOrderMainState extends State<ContentOrderMain>
    with SingleTickerProviderStateMixin {
  late final OrderSaleRegisterBloc bloc;
  late MaskedTextController controllerDate;
  bool selectPaymentTime = false;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<OrderSaleRegisterBloc>();
    Future.delayed(const Duration(milliseconds: 100)).then((_) async {
      await Modular.isModuleReady<OrderSaleRegisterModule>();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
            ),
            title: Text(
              "Pedido ${bloc.orderMain.order.number}",
              style: kHintTextStyle.copyWith(fontSize: 20.0),
            ),
          ),
          body: SingleChildScrollView(
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
                  _itemsList(),
                  const SizedBox(height: 8.0),
                  _paymentTypes(),
                  const SizedBox(height: 8.0),
                  //_timePayments(),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _totalOrder(),
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
          floatingActionButton: (bloc.orderMain.order.status != "F")
              ? FloatingActionButton(
                  onPressed: () async {},
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.save),
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
        initialValue: bloc.orderMain.order.number.toString(),
        keyboardType: TextInputType.number,
        inputAction: TextInputAction.go,
        onChanged: (value) => {bloc.orderMain.order.number = int.parse(value)});
  }

  _customer() {
    return CustomInputButton(
      readOnly: (bloc.orderMain.order.status != "F"),
      initialValue: bloc.orderMain.order.nameCustomer,
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
                    page: bloc.pageCustomer,
                    id: 0,
                    nameCustomer: bloc.searchOrder,
                  )))
                : null
          }),
    );
  }

  _itemsList() {
    return CustomInputButton(
      initialValue: (bloc.orderMain.items.isEmpty)
          ? "Selecione os itens do pedido"
          : "Selectionado(s) ${bloc.orderMain.items.length.toString()}",
      title: "Lista de Itens do Pedido",
      onAction: (() => {
            bloc.add(GetItemsListEvent(
                params: ParamsItemsList(tbOrderId: bloc.orderMain.order.id))),
          }),
    );
  }

  _totalOrder() {
    double total = 0;
    for (ItemsModel item in bloc.orderMain.items) {
      total += (item.quantity * item.unitValue);
    }
    return CustomInput(
      readOnly: true,
      title: "Valor do Pedido",
      initialValue: total.toStringAsFixed(2),
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.go,
      onChanged: null,
    );
  }

  _paymentTypes() {
    return CustomInputButton(
      initialValue: bloc.orderMain.order.namePaymentTypes,
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
                      bloc.orderMain.order.plots -= 1;
                      if (bloc.orderMain.order.plots < 0) {
                        bloc.orderMain.order.plots = 0;
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
                    bloc.orderMain.order.plots.toString(),
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
                      bloc.orderMain.order.plots += 1;
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
        initialValue: bloc.orderMain.order.deadline,
        keyboardType: TextInputType.text,
        inputAction: TextInputAction.go,
        onChanged: (value) => {bloc.orderMain.order.deadline = value});
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
