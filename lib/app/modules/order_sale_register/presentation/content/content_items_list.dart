import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/core/shared/utils/toast.dart';
import 'package:appweb/app/modules/Core/data/model/order_sale_item_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/event.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContentItemsList extends StatefulWidget {
  final List<OrderSaleItemModel> itemslist;
  const ContentItemsList({
    super.key,
    required this.itemslist,
  });

  @override
  State<ContentItemsList> createState() => _ContentItemsListState();
}

class _ContentItemsListState extends State<ContentItemsList> {
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
        title: const Text('Itens do Pedidos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            bloc.add(FormOrderEvent(tbOrderId: bloc.orderMain.order.id));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildListView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }

  buildSearchInput() {
    return Container(
      decoration: kBoxDecorationStyle,
      child: TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        onChanged: (value) {
          bloc.searchItem = value;
          bloc.add(SearchOrderEvent());
        },
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 10.0),
          hintText: "Pesquise por número",
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  buildListView() {
    return Expanded(
      child: widget.itemslist.isEmpty
          ? const Center(child: Text("Pedidos sem Itens."))
          : ListView.separated(
              itemCount: widget.itemslist.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 120,
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: (Colors.black),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AutoSizeText((index + 1).toString()),
                          ),
                        ),
                        title: SizedBox(
                          height: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Produto",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5.0),
                              AutoSizeText(
                                widget.itemslist[index].nameProduct,
                                maxFontSize: 12,
                              ),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            CustomToast.showToast(
                                "Funcionalidade em desenvolvimento.");
                          },
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 5.0),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 50,
                              child: Column(
                                children: [
                                  const Text(
                                    "Quantidade",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    (widget.itemslist[index].quantity
                                        .toStringAsFixed(0)),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 50,
                              child: Column(
                                children: [
                                  const Text(
                                    "Unitário",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    (widget.itemslist[index].unitValue
                                        .toStringAsFixed(2)),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 50,
                              child: Column(
                                children: [
                                  const Text(
                                    "Subtotal",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    ((widget.itemslist[index].quantity *
                                            widget.itemslist[index].unitValue)
                                        .toStringAsFixed(2)),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (_, __) => const Divider(),
            ),
    );
  }
}
