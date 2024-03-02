import 'package:appweb/app/core/shared/widgets/custom_imput_button.dart';
import 'package:appweb/app/modules/Core/data/model/order_sale_item_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/product_prices_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/event.dart';

class WidgetProductPrices extends StatefulWidget {
  final ProductPricesModel productPrices;

  const WidgetProductPrices({
    super.key,
    required this.productPrices,
  });

  @override
  State<WidgetProductPrices> createState() => _WidgetProductPricesState();
}

class _WidgetProductPricesState extends State<WidgetProductPrices> {
  late final OrderSaleRegisterBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<OrderSaleRegisterBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title: const Text('Preços Disponiveis'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (bloc.productList.isEmpty) {
              bloc.add(
                GetProductListEvent(
                  params: ParamsProductList(
                    id: 0,
                    nameProduct: "",
                    page: 0,
                    tbInstitutionId: 0,
                  ),
                ),
              );
            } else {
              bloc.add(GetFormProductListEvent());
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _productField(),
            const SizedBox(height: 10.0),
            gradeListView(),
          ],
        ),
      ),
    );
  }

  gradeListView() {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height - 180,
      child: GridView.count(
        crossAxisCount: 3,
        // Gera 100 Widgets que exibem o seu índice
        children: List.generate(
          widget.productPrices.items.length,
          (index) {
            return Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(110, 80),
                  elevation: 30,
                  maximumSize: const Size(110, 80),
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () {
                  bloc.add(
                    GetItemToEditEvent(
                      item: OrderSaleItemModel(
                        id: 0,
                        tbProductId: widget.productPrices.id,
                        nameProduct: widget.productPrices.nameProduct,
                        quantity: 1,
                        unitValue: widget.productPrices.items[index].priceTag,
                        updateStatus: 'I',
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SizedBox(
                        height: 30,
                        child: AutoSizeText(
                          widget.productPrices.items[index].namePriceList,
                          minFontSize: 8,
                          maxFontSize: 12,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(
                      widget.productPrices.items[index].priceTag
                          .toStringAsFixed(2),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _productField() {
    return CustomInputButton(
      enabled: true,
      keyboardType: TextInputType.number,
      inputAction: TextInputAction.go,
      readOnly: true,
      initialValue:
          '${widget.productPrices.id} - ${widget.productPrices.nameProduct}',
      title: "Descrição do Produto",
    );
  }
}
