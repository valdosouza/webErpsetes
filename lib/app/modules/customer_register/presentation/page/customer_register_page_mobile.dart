import 'package:appweb/app/modules/order_sale_register/presentation/widget/widget_customer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:appweb/app/core/shared/widgets/custom_circular_progress_indicator.dart';
import 'package:appweb/app/modules/customer_register/customer_register_module.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/state.dart';
import 'package:appweb/app/modules/customer_register/presentation/content/content_customer_register.dart';
import 'package:appweb/app/modules/customer_register/presentation/content/content_customer_register_mobile.dart';
import 'package:appweb/app/modules/customer_register/presentation/widget/customer_register_city_list_widget.dart';
import 'package:appweb/app/modules/customer_register/presentation/widget/customer_register_state_list_widget.dart';

class CustomerRegisterPageMobile extends StatefulWidget {
  final int tbCustomerId;
  final String routeCallBack;
  const CustomerRegisterPageMobile({
    Key? key,
    required this.tbCustomerId,
    required this.routeCallBack,
  }) : super(key: key);

  @override
  State<CustomerRegisterPageMobile> createState() =>
      _CustomerRegisterPageMobileState();
}

class _CustomerRegisterPageMobileState
    extends State<CustomerRegisterPageMobile> {
  late final CustomerRegisterBloc bloc;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((_) async {
      await Modular.isModuleReady<CustomerRegisterModule>();
    });

    bloc = Modular.get<CustomerRegisterBloc>();
    if (widget.tbCustomerId == 0) {
      bloc.add(MobileNewEvent());
    } else {
      bloc.add(MobileEditEvent(tbCustomerId: widget.tbCustomerId));
    }
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

        if (state is PostByMobileSuccessState) {
          if (widget.routeCallBack != '') {
            Modular.to.navigate(widget.routeCallBack);
          } else {
            return WidgetCustomerList(customerList: state.customerList);
          }
        }
        if (state is ErrorState) {
          return ContentCustomerRegisterMobile(
            customer: bloc.customer,
            tabIndex: bloc.tabIndex,
          );
        }
        if (state is InfoPageState) {
          return ContentCustomerRegisterMobile(
            customer: state.model,
            tabIndex: state.tabIndex,
          );
        }

        return Container();
      },
    );
  }
}
