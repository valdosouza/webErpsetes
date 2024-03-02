import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/dashboard_sales/presentation/components/bar_chart_week_sales_info.dart';
import 'package:flutter/material.dart';

class BarChartWeekSales extends StatelessWidget {
  const BarChartWeekSales({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      //width: double.infinity,
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: kBoxDecorationBarChart,
      child: const Expanded(
        child: BarChartWeekSalesInfo(),
      ),
    );
  }
}
