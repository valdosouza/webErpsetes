import 'package:flutter_test/flutter_test.dart';

/// Call from [setUpAll] in suites that need binding or shared init.
void configureTestEnvironment() {
  TestWidgetsFlutterBinding.ensureInitialized();
}
