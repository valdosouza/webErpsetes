import 'package:appweb/app/core/shared/helpers/responsive.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/page/order_sale_register_page_desktop.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/page/order_sale_register_page_mobile.dart';
import 'package:appweb/app/modules/order_sale_register/presentation/page/order_sale_register_page_tablet.dart';
import 'package:flutter/material.dart';

class OrderSaleRegisterPage extends StatelessWidget {
  const OrderSaleRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: OrderSaleRegisterPageMobile(),
      tablet: OrderSaleRegisterPageTablet(),
      desktop: OrderSaleRegisterPageDesktop(),
    );
  }
}
