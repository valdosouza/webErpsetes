import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/dashboard/presentation/menu/dashboard_menu_main.dart';
import 'package:appweb/app/modules/drawer/presentation/drawer_page_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PageDesktop extends StatelessWidget {
  const PageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title: const Text("Sistema Gestão - Setes - Dashboard"),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: const Row(
          children: [
            DrawerPageMain(),
            DashboardMenuMain(),
            Expanded(
              flex: 5,
              child: RouterOutlet(),
            ),
          ],
        ),
      ),
    );
  }
}
