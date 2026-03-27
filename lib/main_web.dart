import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> init() async {
  setUrlStrategy(PathUrlStrategy());
}
