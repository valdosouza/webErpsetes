import 'package:appweb/app/core/shared/widgets/custom_search_filter.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_transfer_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/presentation/bloc/state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb/app/core/shared/theme.dart';

class WidgetProductList extends StatefulWidget {
  final List<ProductListModel> productList;
  const WidgetProductList({
    Key? key,
    required this.productList,
  }) : super(key: key);

  @override
  State<WidgetProductList> createState() => WidgetProductListtState();
}

class WidgetProductListtState extends State<WidgetProductList> {
  late final OrderStockTransferRegisterBloc bloc;
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    bloc = Modular.get<OrderStockTransferRegisterBloc>();
  }

  infiniteScrolling() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      bloc.add(
        GetProductListEvent(
          params: ParamsProductList(
            id: 0,
            nameProduct: bloc.searchProduct,
            page: bloc.pageProduct,
            tbInstitutionId: 0,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderStockTransferRegisterBloc,
        OrderStockTransferRegisterState>(
      bloc: bloc,
      builder: (context, state) {
        return _orderStockAdjustEntitiesList(state);
      },
    );
  }

  _orderStockAdjustEntitiesList(OrderStockTransferRegisterState state) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title:
            Text('Lista de Produtos (${widget.productList.length.toString()})'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            bloc.add(GetItemsListEvent(
                params: ParamsItemsList(tbOrderId: bloc.orderMain.order.id)));
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomSearchFilter(
            title: "Pesquisa ou Filtre aqui",
            readOnly: false,
            initialValue: bloc.searchProduct,
            suffixIcon: const Icon(
              Icons.search,
              size: 20.0,
              color: Colors.white,
            ),
            onAction: (() => {
                  bloc.add(
                    SearchProductEvent(
                      params: ParamsProductList(
                        tbInstitutionId: 0,
                        page: 0,
                        id: 0,
                        nameProduct: bloc.searchProduct,
                      ),
                    ),
                  ),
                }),
            onChange: ((value) => {
                  bloc.searchProduct = value,
                  bloc.add(FilterProductEvent()),
                }),
          ),
          const SizedBox(height: 5.0),
          Expanded(
            child: widget.productList.isEmpty
                ? const Center(
                    child:
                        Text("Não encontramos nenhum registro em nossa base."))
                : ListView.separated(
                    controller: _scrollController,
                    key: const PageStorageKey<String>('page'),
                    itemCount: widget.productList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        bloc.add(GetItemToEditEvent(
                            item: OrderStockTransferItemModel(
                          id: 0,
                          tbProductId: widget.productList[index].id,
                          nameProduct: widget.productList[index].description,
                          quantity: 1,
                          unitValue: 0,
                          updateStatus: 'I',
                        )));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: (Colors.black),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AutoSizeText(
                                widget.productList[index].id.toString()),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.productList[index].description),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (_, __) => const Divider(),
                  ),
          ),
        ],
      ),
    );
  }
}
