import 'package:appweb/app/core/shared/helpers/responsive.dart';
import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/dashboard_sales/presentation/components/my_fields.dart';
import 'package:flutter/material.dart';
import 'package:appweb/app/modules/dashboard_sales/presentation/components/header.dart';
import 'package:appweb/app/modules/dashboard_sales/presentation/components/recent_files.dart';
import 'package:appweb/app/modules/dashboard_sales/presentation/components/storage_details.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: kDefaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      const MyFiles(),
                      const SizedBox(height: kDefaultPadding),
                      const RecentFiles(),
                      if (Responsive.isMobile(context))
                        const SizedBox(height: kDefaultPadding),
                      if (Responsive.isMobile(context)) const StarageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: kDefaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  const Expanded(
                    flex: 2,
                    child: StarageDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
