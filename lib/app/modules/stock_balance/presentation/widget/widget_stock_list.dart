import 'package:appweb/app/core/shared/widgets/custom_search_filter.dart';
import 'package:appweb/app/modules/Core/data/model/stock_list_model.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_balance_list.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_list.dart';
import 'package:appweb/app/modules/stock_balance/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/stock_balance/presentation/bloc/event.dart';
import 'package:appweb/app/modules/stock_balance/presentation/bloc/state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb/app/core/shared/theme.dart';

class WidgetStockList extends StatefulWidget {
  final List<StockListModel> stockList;
  const WidgetStockList({
    super.key,
    required this.stockList,
  });

  @override
  State<WidgetStockList> createState() => WidgetStockListtState();
}

class WidgetStockListtState extends State<WidgetStockList> {
  late final StockBalanceBloc bloc;
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    bloc = Modular.get<StockBalanceBloc>();
  }

  infiniteScrolling() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      bloc.add(
        GetStockListEvent(
          params: ParamsStockList(
            tbInstitutionId: 0,
            page: bloc.pageStockList,
            id: 0,
            description: bloc.searchStockList,
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
    return BlocBuilder<StockBalanceBloc, StockBalanceState>(
      bloc: bloc,
      builder: (context, state) {
        return _stockList(state);
      },
    );
  }

  _stockList(StockBalanceState state) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title:
            Text('Lista de Estoques (${widget.stockList.length.toString()})'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomSearchFilter(
            title: "Pesquisa ou Filtre aqui",
            readOnly: false,
            initialValue: bloc.searchStockList,
            suffixIcon: const Icon(
              Icons.search,
              size: 20.0,
              color: Colors.white,
            ),
            onAction: (() => {
                  bloc.add(
                    SearchStockEvent(
                      params: ParamsStockList(
                        tbInstitutionId: 0,
                        page: 0,
                        id: 0,
                        description: bloc.searchStockList,
                      ),
                    ),
                  ),
                }),
            onChange: ((value) => {
                  bloc.searchStockList = value,
                  bloc.add(FilterStockEvent()),
                }),
          ),
          const SizedBox(height: 5.0),
          Expanded(
            child: widget.stockList.isEmpty
                ? const Center(
                    child:
                        Text("Não encontramos nenhum registro em nossa base."))
                : ListView.separated(
                    controller: _scrollController,
                    key: const PageStorageKey<String>('page'),
                    itemCount: widget.stockList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {},
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: (Colors.black),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AutoSizeText(
                              widget.stockList[index].id.toString(),
                              style: kCircleAvatarTextStyle,
                            ),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.stockList[index].description),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            bloc.add(
                              GetStockBalanceListEvent(
                                params: ParamsStockBalanceList(
                                  tbInstitutionId: 0,
                                  page: 0,
                                  id: 0,
                                  tbSalesmanId: 0,
                                  tbStockListId: widget.stockList[index].id,
                                  nameMerchandise: "",
                                ),
                              ),
                            );
                          },
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
