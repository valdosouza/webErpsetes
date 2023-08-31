import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/core/shared/utils/custom_date.dart';
import 'package:appweb/app/core/shared/widgets/custom_search_filter.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_sale_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/closure.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/delete.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/reopen.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/event.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContentOrderList extends StatefulWidget {
  final List<OrderSaleListModel> orderlist;
  const ContentOrderList({
    super.key,
    required this.orderlist,
  });

  @override
  State<ContentOrderList> createState() => _ContentOrderListState();
}

class _ContentOrderListState extends State<ContentOrderList> {
  late final OrderSaleRegisterBloc bloc;
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    bloc = Modular.get<OrderSaleRegisterBloc>();
  }

  infiniteScrolling() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      bloc.add(
        GetOrderListEvent(
          params: ParamsOrderList(
            tbInstitutionId: 0,
            tbSalesmanId: 0,
            page: bloc.pageOrder,
            number: 0,
            nickTrade: bloc.searchOrder,
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
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title: const Text('Lista de Pedidos de Venda'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Modular.to.navigate('/home/');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildSearchInput(),
            const SizedBox(height: 10.0),
            buildListView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.add(NewFormOrderEvent());
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }

  buildSearchInput() {
    return CustomSearchFilter(
      title: "Pesquisa ou Filtre aqui",
      readOnly: false,
      initialValue: bloc.searchOrder,
      suffixIcon: const Icon(
        Icons.search,
        size: 20.0,
        color: Colors.white,
      ),
      onAction: (() => {
            bloc.add(
              SearchOrderEvent(
                params: ParamsOrderList(
                  tbInstitutionId: 0,
                  tbSalesmanId: 0,
                  page: 0,
                  number: 0,
                  nickTrade: bloc.searchOrder,
                ),
              ),
            ),
          }),
      onChange: ((value) => {
            bloc.searchOrder = value,
            bloc.add(FilterOrderEvent()),
          }),
    );
  }

  buildListView() {
    return Expanded(
      child: widget.orderlist.isEmpty
          ? const Center(
              child: Text("Não encontramos nenhum registro em nossa base."))
          : ListView.separated(
              controller: _scrollController,
              itemCount: widget.orderlist.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  bloc.add(
                      GetOrderMainEvent(tbOrderId: widget.orderlist[index].id));
                },
                child: ListTile(
                  title: SizedBox(
                    height: 83,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Número",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 5.0),
                                  Text(widget.orderlist[index].number
                                      .toString()),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Data",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 5.0),
                                  Text(widget.orderlist[index].dtRecord),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Situação",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 5.0),
                                  Text((widget.orderlist[index].status != "F")
                                      ? "Aberta"
                                      : "Fechada"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Nome do Cliente",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            AutoSizeText(
                              widget.orderlist[index].nameCustomer,
                              maxFontSize: 14,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      (widget.orderlist[index].status == "F")
                          ? PopupMenuItem(
                              onTap: (() => bloc.add(
                                    ReopenOrderEvent(
                                      params: ParamsReopenOrder(
                                        tbInstitutionId: 0,
                                        tbUserId: 0,
                                        tbOrderId: widget.orderlist[index].id,
                                        dtRecord: CustomDate.newDate(),
                                      ),
                                    ),
                                  )),
                              value: 0,
                              child: const Text("Reabrir"),
                            )
                          : PopupMenuItem(
                              onTap: (() => bloc.add(
                                    ClosureOrderEvent(
                                      params: ParamsClosureOrder(
                                        tbInstitutionId: 0,
                                        tbUserId: 0,
                                        tbOrderId: widget.orderlist[index].id,
                                        dtRecord: CustomDate.newDate(),
                                      ),
                                    ),
                                  )),
                              value: 0,
                              child: const Text("Fechar"),
                            ),
                      PopupMenuItem(
                        onTap: (() => bloc.add(
                              DeleteOrderEvent(
                                params: ParamsDeleteOrder(
                                  tbInstitutionId: 0,
                                  tbUserId: 0,
                                  tbOrderId: widget.orderlist[index].id,
                                ),
                              ),
                            )),
                        value: 0,
                        child: const Text("Excluir"),
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (_, __) =>
                  const Divider(height: 3, color: kPrimaryColor),
            ),
    );
  }
}
