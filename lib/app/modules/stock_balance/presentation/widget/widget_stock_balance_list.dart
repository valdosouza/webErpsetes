import 'package:appweb/app/core/shared/widgets/custom_search_filter.dart';
import 'package:appweb/app/modules/Core/data/model/stock_balance_model.dart';
import 'package:appweb/app/modules/stock_balance/domain/usecase/get_stock_balance_list.dart';
import 'package:appweb/app/modules/stock_balance/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/stock_balance/presentation/bloc/event.dart';
import 'package:appweb/app/modules/stock_balance/presentation/bloc/state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb/app/core/shared/theme.dart';

class WidgetStockBalanceList extends StatefulWidget {
  final List<StockBalanceItemsModel> stockBalanceList;
  const WidgetStockBalanceList({
    Key? key,
    required this.stockBalanceList,
  }) : super(key: key);

  @override
  State<WidgetStockBalanceList> createState() => WidgetStockBalanceListtState();
}

class WidgetStockBalanceListtState extends State<WidgetStockBalanceList> {
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
        GetStockBalanceListEvent(
          params: ParamsStockBalanceList(
            tbInstitutionId: 0,
            page: bloc.pageStockList,
            tbSalesmanId: 0,
            tbStockListId: bloc.tbStockListId,
            id: 0,
            nameMerchandise: bloc.searchMerchandise,
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
        title: Text(
            'Saldo de Estoque (${widget.stockBalanceList.length.toString()})'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (kIsWeb) {
              bloc.add(GetStockListReturnEvent());
            } else {
              Modular.to.navigate('/stock/mobile/');
            }
          },
        ),
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
                    SearchStockBalanceEvent(
                      params: ParamsStockBalanceList(
                        tbInstitutionId: 0,
                        page: 0,
                        id: 0,
                        tbSalesmanId: 0,
                        tbStockListId: bloc.tbStockListId,
                        nameMerchandise: bloc.searchMerchandise,
                      ),
                    ),
                  ),
                }),
            onChange: ((value) => {
                  bloc.searchMerchandise = value,
                  bloc.add(FilterStockBalanceEvent()),
                }),
          ),
          const SizedBox(height: 5.0),
          Expanded(
            child: widget.stockBalanceList.isEmpty
                ? const Center(
                    child:
                        Text("Não encontramos nenhum registro em nossa base."))
                : ListView.separated(
                    controller: _scrollController,
                    key: const PageStorageKey<String>('page'),
                    itemCount: widget.stockBalanceList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {},
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: (Colors.black),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AutoSizeText(widget
                                .stockBalanceList[index].tbMerchandiseId
                                .toString()),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                widget.stockBalanceList[index].nameMerchandise),
                          ],
                        ),
                        trailing: Text(widget.stockBalanceList[index].quantity
                            .toStringAsFixed(0)),
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
