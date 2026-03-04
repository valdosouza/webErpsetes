import 'package:appweb/app/modules/log/data/model/log_model.dart';

abstract class LogEvent {}

class SetLogEvent extends LogEvent {
  final LogModel params;

  SetLogEvent({required this.params});
}

class GetLogEvent extends LogEvent {}

class DeleteLogEvent extends LogEvent {}

class SendLogEvent extends LogEvent {}
