import 'package:appweb/app/core/shared/helpers/responsive.dart';
import 'package:appweb/app/modules/stock_balance/presentation/page/page_desktop.dart';
import 'package:appweb/app/modules/stock_balance/presentation/page/page_mobile.dart';
import 'package:appweb/app/modules/stock_balance/presentation/page/page_tablet.dart';
import 'package:flutter/material.dart';

class PageStockBalance extends StatelessWidget {
  const PageStockBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: PageMobile(),
      tablet: PageTablet(),
      desktop: PageDesktop(),
    );
  }
}
