import 'package:appweb/app/core/shared/theme.dart';

import 'package:appweb/app/modules/drawer/presentation/drawer_page_mobile.dart';
import 'package:appweb/app/modules/log/presentation/page/page_mobile.dart';
import 'package:flutter/material.dart';

class PageTablet extends StatelessWidget {
  const PageTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title: const Text('Log do sistema'),
      ),
      drawer: const DrawerPageMobile(),
      body: const PageMobile(),
    );
  }
}
