import 'package:appweb/app/core/shared/utils/log_events.dart';
import 'package:appweb/app/modules/log/data/model/log_model.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class ServerException implements Exception {}

class ServerLog {
  final String message;

  ServerLog({required this.message}) {
    setLog(
        params: LogModel(
            interfaceName: 'ServerLog',
            operation: 'Error',
            reference: 'Exception',
            note: message));
    FirebaseCrashlytics.instance.log(message);
  }
}

class LocalException implements Exception {
  final String message;

  LocalException({required this.message});

  @override
  String toString() => 'LocalException: $message';
}
