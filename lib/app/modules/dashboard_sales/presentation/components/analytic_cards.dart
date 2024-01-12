import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/dashboard_sales/data/data.dart';
import 'package:flutter/material.dart';

import 'analytic_info_card.dart';

class AnalyticCards extends StatelessWidget {
  const AnalyticCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AnalyticInfoCardGridView(
      childAspectRatio: size.width < 1400 ? 1.8 : 1.7,
    );
  }
}

class AnalyticInfoCardGridView extends StatelessWidget {
  const AnalyticInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1.8,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: analyticData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: kDefaultPadding,
        mainAxisSpacing: kDefaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => AnalyticInfoCard(
        info: analyticData[index],
      ),
    );
  }
}
