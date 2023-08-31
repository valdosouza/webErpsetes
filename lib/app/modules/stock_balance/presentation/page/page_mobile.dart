import 'package:appweb/app/core/shared/theme.dart';
import 'package:flutter/material.dart';

class PageMobile extends StatefulWidget {
  const PageMobile({super.key});

  @override
  State<PageMobile> createState() => PageMobileState();
}

class PageMobileState extends State<PageMobile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title: const Text("StockBalance - Mobile"),
      ),
    );
  }
}
