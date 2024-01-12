import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/dashboard_sales/presentation/components/analytic_cards.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ContentDesktop extends StatelessWidget {
  const ContentDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        primary: true,
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              "Resutados Diário",
              maxLines: 1,
              maxFontSize: 22,
              minFontSize: 18,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: kContentColorBlack,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            AnalyticCards(),
            SizedBox(height: kDefaultPadding),
            AutoSizeText(
              "Vendas por Forma de Pagamento",
              maxLines: 1,
              maxFontSize: 22,
              minFontSize: 18,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: kContentColorBlack,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            //PieChartSalesByPaymentType(),
            SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}
