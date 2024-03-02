import 'package:flutter/material.dart';

import 'package:appweb/app/core/shared/helpers/responsive.dart';
import 'package:appweb/app/modules/customer_register/presentation/page/customer_register_page_desktop.dart';
import 'package:appweb/app/modules/customer_register/presentation/page/customer_register_page_mobile.dart';
import 'package:appweb/app/modules/customer_register/presentation/page/customer_register_page_tablet.dart';

class CustomerRegisterPage extends StatefulWidget {
  final int tbCustomerId;
  final String routeCallBack;
  const CustomerRegisterPage({
    super.key,
    required this.tbCustomerId,
    required this.routeCallBack,
  });

  @override
  State<CustomerRegisterPage> createState() => _CustomerRegisterPageState();
}

class _CustomerRegisterPageState extends State<CustomerRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: CustomerRegisterPageMobile(
          tbCustomerId: widget.tbCustomerId,
          routeCallBack: widget.routeCallBack),
      tablet: const CustomerRegisterPageTablet(),
      desktop: CustomerRegisterPageDesktop(tbCustomerId: widget.tbCustomerId),
    );
  }
}
