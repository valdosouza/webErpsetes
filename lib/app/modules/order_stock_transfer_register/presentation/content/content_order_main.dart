import 'package:appweb/app/core/shared/utils/toast.dart';
import 'package:appweb/app/core/shared/widgets/custom_imput_button.dart';
import 'package:appweb/app/core/shared/widgets/custom_input.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_transfer_item_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/order_stock_transfer_register_module.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/presentation/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb/app/core/shared/theme.dart';

class ContentOrderMain extends StatefulWidget {
  const ContentOrderMain({
    Key? key,
  }) : super(key: key);

  @override
  State<ContentOrderMain> createState() => _ContentOrderMainState();
}

class _ContentOrderMainState extends State<ContentOrderMain>
    with SingleTickerProviderStateMixin {
  late final OrderStockTransferRegisterBloc bloc;
  late MaskedTextController controllerDate;
  bool selectPaymentTime = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    bloc = Modular.get<OrderStockTransferRegisterBloc>();
    Future.delayed(const Duration(milliseconds: 100)).then((_) async {
      await Modular.isModuleReady<OrderStockTransferRegisterModule>();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<OrderStockTransferItemModel> itemslistEnabled =
        bloc.orderMain.items.where((i) => i.updateStatus != "D").toList();
    return BlocConsumer<OrderStockTransferRegisterBloc,
        OrderStockTransferRegisterState>(
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
              "Pedido ${bloc.orderMain.orderStockTransfer.number}",
              style: kHintTextStyle.copyWith(fontSize: 20.0),
            ),
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
                    _itemsList(itemslistEnabled),
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
        initialValue: bloc.orderMain.orderStockTransfer.number.toString(),
        keyboardType: TextInputType.number,
        inputAction: TextInputAction.go,
        onChanged: (value) =>
            {bloc.orderMain.orderStockTransfer.number = int.parse(value)});
  }

  _itemsList(List<OrderStockTransferItemModel> items) {
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
