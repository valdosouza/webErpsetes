import 'package:appweb/app/core/shared/widgets/custom_search_filter.dart';
import 'package:appweb/app/modules/order_bonus_register/domain/usecase/get_customer_list.dart';
import 'package:appweb/app/modules/order_bonus_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_bonus_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/order_bonus_register/presentation/bloc/state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';

class WidgetCustomerList extends StatefulWidget {
  final List<CustomerListModel> customerList;
  const WidgetCustomerList({
    super.key,
    required this.customerList,
  });

  @override
  State<WidgetCustomerList> createState() => WidgetCustomerListtState();
}

class WidgetCustomerListtState extends State<WidgetCustomerList> {
  late final OrderBonusRegisterBloc bloc;
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    bloc = Modular.get<OrderBonusRegisterBloc>();
  }

  infiniteScrolling() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      bloc.add(
        GetCustomerListEvent(
          params: ParamsCustomerList(
            tbInstitutionId: 0,
            tbSalesmanId: 0,
            page: bloc.pageCustomer,
            id: 0,
            nameCustomer: bloc.searchCustomer,
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
    return BlocBuilder<OrderBonusRegisterBloc, OrderBonusRegisterState>(
      bloc: bloc,
      builder: (context, state) {
        return _orderStockAdjustEntitiesList(state);
      },
    );
  }

  _orderStockAdjustEntitiesList(OrderBonusRegisterState state) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title: Text(
            'Lista de Clientes (${widget.customerList.length.toString()})'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            bloc.add(FormOrderEvent(tbOrderId: bloc.orderMain.order.id));
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomSearchFilter(
            title: "Pesquisa ou Filtre aqui",
            readOnly: false,
            initialValue: bloc.searchCustomer,
            suffixIcon: const Icon(
              Icons.search,
              size: 20.0,
              color: Colors.white,
            ),
            onAction: (() => {
                  bloc.add(
                    SearchCustomerEvent(
                      params: ParamsCustomerList(
                        tbInstitutionId: 0,
                        tbSalesmanId: 0,
                        page: 0,
                        id: 0,
                        nameCustomer: bloc.searchCustomer,
                      ),
                    ),
                  ),
                }),
            onChange: ((value) => {
                  bloc.searchCustomer = value,
                  bloc.add(FilterCustomerEvent()),
                }),
          ),
          const SizedBox(height: 5.0),
          Expanded(
            child: widget.customerList.isEmpty
                ? const Center(
                    child:
                        Text("Não encontramos nenhum registro em nossa base."))
                : ListView.separated(
                    controller: _scrollController,
                    key: const PageStorageKey<String>('page'),
                    itemCount: widget.customerList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        bloc.orderMain.orderBonus.nameCustomer =
                            widget.customerList[index].nickTrade;
                        bloc.orderMain.orderBonus.tbCustomerId =
                            widget.customerList[index].id;
                        bloc.add(
                            FormOrderEvent(tbOrderId: bloc.orderMain.order.id));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: (Colors.black),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AutoSizeText(
                              minFontSize: 8,
                              maxLines: 1,
                              widget.customerList[index].id.toString(),
                              style: kCircleAvatarTextStyle,
                            ),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.customerList[index].nickTrade),
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
