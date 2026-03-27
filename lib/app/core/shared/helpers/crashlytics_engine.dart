import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsEngine {
  static final _instance = FirebaseCrashlytics.instance;

  static Future<void> init() async {
    debugPrint(
      '[Firebase Crashlytics] handlers registered — debug console output enabled from here',
    );

    // Non-async exceptions: keep IDE / flutter run console output, then Crashlytics
    FlutterError.onError = (errorDetails) {
      FlutterError.presentError(errorDetails);
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    // Async exceptions: mirror to debug console, then Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      debugPrint('[Firebase Crashlytics] async zone error: $error');
      debugPrint(stack.toString());
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  static void logCrash({required String message}) async {
    await _instance.log(message);
  }
}
