import 'package:flutter/services.dart';

getVersion() async {
  String version = await rootBundle.loadString('../../../../pubspec.yaml');
  return version;
}
