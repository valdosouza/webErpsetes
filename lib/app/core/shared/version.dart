import 'package:flutter/services.dart';

Future<String> getVersion() async {
  String version = await rootBundle.loadString('../../../../pubspec.yaml');
  return version;
}
