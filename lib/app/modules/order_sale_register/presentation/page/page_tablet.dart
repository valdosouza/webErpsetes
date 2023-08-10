import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/order_sale_register/order_sale_register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PageTablet extends StatefulWidget {
  const PageTablet({super.key});

  @override
  State<PageTablet> createState() => _PageTabletState();
}

class _PageTabletState extends State<PageTablet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((_) async {
      await Modular.isModuleReady<OrderSaleRegisterModule>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title: const Text("Ordem de Transferência de estoque"),
      ),
    );
  }
}
