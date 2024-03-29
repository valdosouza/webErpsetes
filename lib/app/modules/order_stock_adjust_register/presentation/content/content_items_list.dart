import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_adjust_item_model.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/bloc/event.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContentItemsList extends StatefulWidget {
  final List<OrderStockAdjustItemModel> itemslist;
  const ContentItemsList({
    super.key,
    required this.itemslist,
  });

  @override
  State<ContentItemsList> createState() => _ContentItemsListState();
}

class _ContentItemsListState extends State<ContentItemsList> {
  late final OrderStockAdjustRegisterBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<OrderStockAdjustRegisterBloc>();
  }

  Future<bool?> showConfirmationDeleteItem() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Deletar o item?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            OutlinedButton(
              onPressed: () {
                bloc.add(DeleteItemEvent(
                  item: bloc.elementItemDelete,
                ));
                Navigator.pop(context, false);
              },
              child: const Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title: const Text('Itens do Pedido'),
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
      floatingActionButton: (bloc.orderMain.order.status != "F")
          ? FloatingActionButton(
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
              child: const Icon(
                Icons.add,
                color: kSecondaryColor,
              ),
            )
          : null,
    );
  }

  buildListView() {
    final List<OrderStockAdjustItemModel> itemslistEnabled =
        widget.itemslist.where((i) => i.updateStatus != "D").toList();
    return Expanded(
      child: itemslistEnabled.isEmpty
          ? const Center(child: Text("Pedidos sem Itens."))
          : ListView.separated(
              itemCount: itemslistEnabled.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 126,
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: (Colors.black),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AutoSizeText(
                              (index + 1).toString(),
                              style: kCircleAvatarTextStyle,
                            ),
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
                                itemslistEnabled[index].nameProduct,
                                maxFontSize: 12,
                              ),
                            ],
                          ),
                        ),
                        trailing: (bloc.orderMain.order.status != "F")
                            ? IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  bloc.elementItemDelete =
                                      itemslistEnabled[index];
                                  showConfirmationDeleteItem();
                                },
                              )
                            : null,
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
                                    (itemslistEnabled[index]
                                        .quantity
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
                                    (itemslistEnabled[index]
                                        .unitValue
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
                                    ((itemslistEnabled[index].quantity *
                                            itemslistEnabled[index].unitValue)
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
