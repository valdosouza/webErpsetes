import 'package:appweb/app/core/shared/widgets/custom_search_filter.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/payment_types_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_payment_types_list.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/bloc/state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb/app/core/shared/theme.dart';

class WidgetPaymentTypesList extends StatefulWidget {
  final List<PaymentTypesListModel> paymentTypesList;
  const WidgetPaymentTypesList({
    super.key,
    required this.paymentTypesList,
  });

  @override
  State<WidgetPaymentTypesList> createState() => WidgetPaymentTypesListtState();
}

class WidgetPaymentTypesListtState extends State<WidgetPaymentTypesList> {
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
        GetPaymentTypesListEvent(
          params: ParamsPaymentList(
            tbInstitutionId: 0,
            page: bloc.pagePaymentTypes,
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
        return _orderStockAdjustEntitiesList(state);
      },
    );
  }

  _orderStockAdjustEntitiesList(OrderSaleRegisterState state) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title: AutoSizeText(
            'Lista de Forma de Pagamentos (${widget.paymentTypesList.length.toString()})',
            maxLines: 1,
            maxFontSize: 18),
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
            onAction: null,
            onChange: ((value) => {
                  bloc.searchPaymentType = value,
                  bloc.add(FilterPaymentTypeEvent()),
                }),
          ),
          const SizedBox(height: 5.0),
          Expanded(
            child: widget.paymentTypesList.isEmpty
                ? const Center(
                    child:
                        Text("Não encontramos nenhum registro em nossa base."))
                : ListView.separated(
                    controller: _scrollController,
                    key: const PageStorageKey<String>('page'),
                    itemCount: widget.paymentTypesList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        bloc.orderMain.orderBilling.namePayment =
                            widget.paymentTypesList[index].description;
                        bloc.orderMain.orderBilling.tbPaymentTypesId =
                            widget.paymentTypesList[index].id;
                        bloc.add(
                            FormOrderEvent(tbOrderId: bloc.orderMain.order.id));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: (Colors.black),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AutoSizeText(
                              widget.paymentTypesList[index].id.toString(),
                              style: kCircleAvatarTextStyle,
                            ),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.paymentTypesList[index].description),
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
