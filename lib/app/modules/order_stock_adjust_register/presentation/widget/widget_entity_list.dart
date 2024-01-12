import 'package:appweb/app/core/shared/widgets/custom_search_filter.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_entity_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/presentation/bloc/state.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/data/model/entity_list_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb/app/core/shared/theme.dart';

class WidgetEntityList extends StatefulWidget {
  final List<EntityListModel> entityList;
  const WidgetEntityList({
    Key? key,
    required this.entityList,
  }) : super(key: key);

  @override
  State<WidgetEntityList> createState() => WidgetEntityListtState();
}

class WidgetEntityListtState extends State<WidgetEntityList> {
  late final OrderStockAdjustRegisterBloc bloc;
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    bloc = Modular.get<OrderStockAdjustRegisterBloc>();
  }

  infiniteScrolling() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      bloc.add(
        GetEntityListEvent(
          params: ParamsEntityList(
            tbInstitutionId: 0,
            tbUserId: 0,
            page: bloc.pageEntity,
            id: 0,
            nameEntity: bloc.searchEntity,
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
    return BlocBuilder<OrderStockAdjustRegisterBloc,
        OrderStockAdjustRegisterState>(
      bloc: bloc,
      builder: (context, state) {
        return _orderStockAdjustEntitiesList(state);
      },
    );
  }

  _orderStockAdjustEntitiesList(OrderStockAdjustRegisterState state) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title:
            Text('Lista de Entidades (${widget.entityList.length.toString()})'),
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
            initialValue: bloc.searchEntity,
            suffixIcon: const Icon(
              Icons.search,
              size: 20.0,
              color: Colors.white,
            ),
            onAction: (() => {
                  bloc.add(
                    SearchEntityEvent(
                      params: ParamsEntityList(
                        tbInstitutionId: 0,
                        tbUserId: 0,
                        page: 0,
                        id: 0,
                        nameEntity: bloc.searchEntity,
                      ),
                    ),
                  ),
                }),
            onChange: ((value) => {
                  bloc.searchEntity = value,
                  bloc.add(FilterEntityEvent()),
                }),
          ),
          const SizedBox(height: 5.0),
          Expanded(
            child: widget.entityList.isEmpty
                ? const Center(
                    child:
                        Text("Não encontramos nenhum registro em nossa base."))
                : ListView.separated(
                    controller: _scrollController,
                    key: const PageStorageKey<String>('page'),
                    itemCount: widget.entityList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        bloc.orderMain.orderStockAdjust.nameEntity =
                            widget.entityList[index].nickTrade;
                        bloc.orderMain.orderStockAdjust.tbEntityId =
                            widget.entityList[index].id;
                        bloc.add(
                            FormOrderEvent(tbOrderId: bloc.orderMain.order.id));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: (Colors.black),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AutoSizeText(
                              widget.entityList[index].id.toString(),
                              style: kCircleAvatarTextStyle,
                            ),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.entityList[index].nickTrade),
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
