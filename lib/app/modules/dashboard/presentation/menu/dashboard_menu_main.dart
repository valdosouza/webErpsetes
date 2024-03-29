import 'package:appweb/app/core/shared/widgets/item_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashboardMenuMain extends StatelessWidget {
  const DashboardMenuMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          itemMenuDraw(
            Icons.home,
            'Vendas',
            () async => Modular.to.navigate('/dashboard/sales/'),
          ),
        ],
      ),
    );
  }
}
