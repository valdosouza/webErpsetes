import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_customer_list.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/customer_list_model.dart';

class WidgetCustomerList extends StatefulWidget {
  final List<CustomerListModel> customerList;
  const WidgetCustomerList({
    Key? key,
    required this.customerList,
  }) : super(key: key);

  @override
  State<WidgetCustomerList> createState() => WidgetCustomerListtState();
}

class WidgetCustomerListtState extends State<WidgetCustomerList> {
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
    return BlocBuilder<OrderSaleRegisterBloc, OrderSaleRegisterState>(
      bloc: bloc,
      builder: (context, state) {
        return _orderStockAdjustmentEntitiesList(state);
      },
    );
  }

  _orderStockAdjustmentEntitiesList(OrderSaleRegisterState state) {
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
          Container(
            decoration: kBoxDecorationStyle,
            child: TextFormField(
              keyboardType: TextInputType.text,
              autofocus: false,
              onChanged: (value) {
                bloc.searchCustomer = value;
                bloc.add(SearchCustomerEvent());
              },
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 4.0),
                hintText: "Pesquise aqui",
                hintStyle: kHintTextStyle,
              ),
            ),
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
                        bloc.orderMain.orderSale.nameCustomer =
                            widget.customerList[index].nickTrade;
                        bloc.orderMain.orderSale.tbCustomerId =
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
                                widget.customerList[index].id.toString()),
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
