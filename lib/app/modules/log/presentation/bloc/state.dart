import 'package:appweb/app/modules/log/data/model/log_model.dart';

abstract class LogState {}

class Initial extends LogState {}

class LoadingState extends LogState {}

class ErrorState extends LogState {
  final String message;

  ErrorState({required this.message});
}

class LoadedState extends LogState {
  final List<LogModel> list;

  LoadedState({required this.list});
}
