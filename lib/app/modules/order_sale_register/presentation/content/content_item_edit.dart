import 'package:appweb/app/core/shared/widgets/custom_imput_button.dart';
import 'package:appweb/app/core/shared/widgets/custom_input.dart';
import 'package:appweb/app/modules/Core/data/model/order_sale_item_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_items_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/event.dart';

class ContentItemEdit extends StatefulWidget {
  final OrderSaleItemModel itemEdit;

  const ContentItemEdit({
    super.key,
    required this.itemEdit,
  });

  @override
  State<ContentItemEdit> createState() => _ContentItemEditState();
}

class _ContentItemEditState extends State<ContentItemEdit> {
  late final OrderSaleRegisterBloc bloc;
  var txtQuantity = TextEditingController();
  var txtUnitValue = TextEditingController();
  var txtSubtotal = TextEditingController();
  var txtDiscountAliq = TextEditingController();
  var txtDiscountValue = TextEditingController();
  bool calcByAliq = false;
  bool calcByValue = false;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<OrderSaleRegisterBloc>();
    //Inciia o valor nos campos
    txtUnitValue.text = widget.itemEdit.unitValue.toStringAsFixed(2);
    txtQuantity.text = widget.itemEdit.quantity.toStringAsFixed(0);
    txtDiscountAliq.text = widget.itemEdit.discountAliquot.toStringAsFixed(2);
    txtDiscountValue.text = widget.itemEdit.discountValue.toStringAsFixed(2);
    txtSubtotal.text = widget.itemEdit.subtotal.toStringAsFixed(2);

    txtUnitValue.addListener(calcSubtotal);
    txtQuantity.addListener(calcSubtotal);

    txtDiscountAliq.addListener(() {
      syncByAliqDiscount();
    });
    txtDiscountAliq.addListener(calcSubtotal);

    txtDiscountValue.addListener(() {
      syncByValueDiscount();
    });
    txtDiscountValue.addListener(calcSubtotal);
  }

// Método para sincronizar aliq_desconto e valor_desconto
  void syncByAliqDiscount() {
    if (calcByAliq) {
      txtDiscountValue.text = '';
      double discountAliq = double.tryParse(txtDiscountAliq.text) ?? 0;
      if (discountAliq > 0) {
        double unitValue = double.tryParse(txtUnitValue.text) ?? 0.0;

        double quantity = double.tryParse(txtQuantity.text) ?? 0.0;

        double productSubtotal = unitValue * quantity;

        double discountValue = (productSubtotal * discountAliq) / 100;

        txtDiscountValue.text = discountValue.toStringAsFixed(2);
      }
    }
  }

  void syncByValueDiscount() {
    if (calcByValue) {
      double discountValue = double.tryParse(txtDiscountValue.text) ?? 0.0;
      txtDiscountAliq.text = '';
      if (discountValue > 0) {
        double unitValue = double.tryParse(txtUnitValue.text) ?? 0.0;

        double quantity = double.tryParse(txtQuantity.text) ?? 0.0;

        double productSubtotal = unitValue * quantity;

        double discountAliq = (discountValue / productSubtotal) * 100;
        discountAliq = double.parse(discountAliq.toStringAsFixed(2));
        if ((discountAliq < 0) || (discountAliq >= 100)) discountAliq = 0;

        widget.itemEdit.discountValue = discountValue;

        txtDiscountAliq.text = discountAliq.toStringAsFixed(2);
      }
    }
  }

  void calcSubtotal() {
    double unitValue = double.tryParse(txtUnitValue.text) ?? 0.0;
    //aqui garente a atualização do model, mesmo sem o submit no campo
    widget.itemEdit.unitValue = unitValue;

    double quantity = double.tryParse(txtQuantity.text) ?? 0.0;
    widget.itemEdit.quantity = quantity;

    double productSubtotal = unitValue * quantity;

    double discountValue = double.tryParse(txtDiscountValue.text) ?? 0.0;
    widget.itemEdit.discountValue = discountValue;

    double discountAliq = (discountValue / productSubtotal) * 100;
    discountAliq = double.parse(discountAliq.toStringAsFixed(2));
    if ((discountAliq < 0) || (discountAliq >= 100)) discountAliq = 0;
    widget.itemEdit.discountAliquot = discountAliq;

    widget.itemEdit.subtotal = productSubtotal - discountValue;
    txtSubtotal.text = widget.itemEdit.subtotal.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title: const Text('Edição do item'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            bloc.add(GetItemsListEvent(
                params: ParamsItemsList(tbOrderId: bloc.orderMain.order.id)));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _productNameField(),
                const SizedBox(height: 3.0),
                _productValueField(),
                const SizedBox(height: 3.0),
                _productQuantityField(),
                const SizedBox(height: 3.0),
                _productDiscountAliq(),
                const SizedBox(height: 3.0),
                _productDiscountValue(),
                const SizedBox(height: 3.0),
                _productSubtotal(),
              ],
            ),
          ),
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
      initialValue:
          '${widget.itemEdit.tbProductId} - ${widget.itemEdit.nameProduct}',
      title: "Descrição do Produto",
      maxLines: 3,
    );
  }

  _productValueField() {
    double valor = 0;
    String valorStr = "";
    return CustomInput(
      title: 'Valor Unitário',
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.next,
      controller: txtUnitValue,
      onChanged: (value) {
        calcByAliq = false;
        calcByValue = false;

        if (value.isNotEmpty) {
          valorStr = value.replaceAll('.', '');
          valor = double.parse(valorStr);
          txtUnitValue.text = "";
          if (valor > 0) {
            valor = valor / 100;
            txtUnitValue.text = valor.toStringAsFixed(2);
          }
        }
        txtUnitValue.selection = TextSelection.fromPosition(
            TextPosition(offset: txtUnitValue.text.length));
      },
      onFieldSubmitted: (value) {
        if (value.isNotEmpty) {
          widget.itemEdit.unitValue = double.parse(value);
        } else {
          widget.itemEdit.unitValue = 0.0;
        }
      },
    );
  }

  _productQuantityField() {
    return CustomInput(
      title: 'Quantidade',
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.next,
      controller: txtQuantity,
      onChanged: (value) {
        calcByAliq = false;
        calcByValue = false;
      },
      onFieldSubmitted: (value) {
        if (value.isNotEmpty) {
          widget.itemEdit.quantity = double.parse(value);
        } else {
          widget.itemEdit.quantity = 0.0;
        }
      },
    );
  }

  _productDiscountAliq() {
    double valor = 0;
    String valorStr = "";
    return CustomInput(
      title: 'Aliq. Desconto',
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.next,
      controller: txtDiscountAliq,
      onChanged: (value) {
        calcByAliq = true;
        calcByValue = false;
        if (value.isNotEmpty) {
          valorStr = value.replaceAll('.', '');
          valor = double.parse(valorStr);
          txtDiscountAliq.text = "";
          if (valor > 0) {
            valor = valor / 100;
            txtDiscountAliq.text = valor.toStringAsFixed(2);
          }
        }
        txtDiscountAliq.selection = TextSelection.fromPosition(
            TextPosition(offset: txtDiscountAliq.text.length));
      },
      onFieldSubmitted: (value) {
        if (value.isNotEmpty) {
          widget.itemEdit.discountAliquot = double.parse(value);
        } else {
          widget.itemEdit.discountAliquot = 0.0;
        }
      },
    );
  }

  _productDiscountValue() {
    double valor = 0;
    String valorStr = "";
    return CustomInput(
      title: 'Valor Desconto',
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.next,
      controller: txtDiscountValue,
      onChanged: (value) {
        calcByAliq = false;
        calcByValue = true;
        if (value.isNotEmpty) {
          valorStr = value.replaceAll('.', '');
          valor = double.parse(valorStr);
          txtDiscountValue.text = "";
          if (valor > 0) {
            valor = valor / 100;
            txtDiscountValue.text = valor.toStringAsFixed(2);
          }
        }
        txtDiscountValue.selection = TextSelection.fromPosition(
            TextPosition(offset: txtDiscountValue.text.length));
      },
      onFieldSubmitted: (value) {
        if (value.isNotEmpty) {
          widget.itemEdit.discountValue = double.parse(value);
        } else {
          widget.itemEdit.discountValue = 0.0;
        }
      },
    );
  }

  _productSubtotal() {
    return CustomInput(
      title: 'Subtotal',
      readOnly: true,
      controller: txtSubtotal,
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.next,
      onChanged: null,
    );
  }
}
