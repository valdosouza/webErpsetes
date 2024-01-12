import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/core/shared/widgets/custom_circular_progress_indicator.dart';

import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/customer_register/customer_register_module.dart';
import 'package:appweb/app/modules/customer_register/data/model/customer_main_model.dart';
import 'package:appweb/app/modules/customer_register/domain/usecase/get_list.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/state.dart';
import 'package:appweb/app/modules/customer_register/presentation/content/content_customer_register.dart';
import 'package:appweb/app/modules/customer_register/presentation/content/content_customer_register_desktop.dart';
import 'package:appweb/app/modules/customer_register/presentation/widget/customer_register_city_list_widget.dart';
import 'package:appweb/app/modules/customer_register/presentation/widget/customer_register_state_list_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomerRegisterListWidget extends StatefulWidget {
  const CustomerRegisterListWidget({super.key});

  @override
  State<CustomerRegisterListWidget> createState() =>
      CustomerRegisterListWidgetState();
}

class CustomerRegisterListWidgetState
    extends State<CustomerRegisterListWidget> {
  late final CustomerRegisterBloc bloc;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((_) async {
      await Modular.isModuleReady<CustomerRegisterModule>();
    });
    bloc = Modular.get<CustomerRegisterBloc>();
    bloc.add(
      GetListEvent(
        params: ParamsList(
          page: 1,
          tbInstitutionId: 0,
          tbSalesmanId: 0,
          id: 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerRegisterBloc, CustomerRegisterState>(
      bloc: bloc,
      listener: (context, state) {
        statesCustomer(state);
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CustomCircularProgressIndicator(),
          );
        }

        if (state is GetStatesSuccessState) {
          return const CustomerRegisterStateListWidget();
        }

        if (state is GetCitySuccessState) {
          return const CustomerRegisterCityListWidget();
        }

        if (state is InfoPageState) {
          return ContentCustomerRegisterDesktop(
            customer: state.model,
            tabIndex: state.tabIndex,
          );
        }

        final customers = state.customerList;
        return _listaCustomer(customers);
      },
    );
  }

  _listaCustomer(List<CustomerListModel> customers) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title: const AutoSizeText(
          'Lista de Clientes',
          style: kTitleAppBarStyle,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add, color: kSecondaryColor),
            onPressed: () {
              bloc.customer = CustomerMainModel.empty();
              bloc.add(DesktopEvent());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildSearchInput(bloc),
              const SizedBox(height: 30.0),
              buildListView(bloc, customers),
            ],
          ),
        ),
      ),
    );
  }
}
