import 'package:appweb/app/core/shared/widgets/custom_imput_button.dart';
import 'package:appweb/app/core/shared/widgets/custom_input.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_adjust_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/bloc/event.dart';

class ContentItemEdit extends StatefulWidget {
  final OrderStockAdjustItemModel itemEdit;

  const ContentItemEdit({
    super.key,
    required this.itemEdit,
  });

  @override
  State<ContentItemEdit> createState() => _ContentItemEditState();
}

class _ContentItemEditState extends State<ContentItemEdit> {
  late final OrderStockAdjustRegisterBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<OrderStockAdjustRegisterBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title: const Text('Edição do item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _productNameField(),
            const SizedBox(height: 10.0),
            _productQuantityField(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.add(SetItemUpdateEvent(item: widget.itemEdit));
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.save,
          color: kSecondaryColor,
        ),
      ),
    );
  }

  _productNameField() {
    return CustomInputButton(
      enabled: true,
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.go,
      readOnly: true,
      initialValue:
          '${widget.itemEdit.tbProductId} - ${widget.itemEdit.nameProduct}',
      title: "Descrição do Produto",
    );
  }

  _productQuantityField() {
    return CustomInput(
      title: 'Quantidade',
      initialValue: widget.itemEdit.quantity.toStringAsFixed(2),
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.next,
      onChanged: (value) {
        if (value.isNotEmpty) {
          widget.itemEdit.quantity = double.parse(value);
        } else {
          widget.itemEdit.quantity = 0;
        }
      },
    );
  }
}
