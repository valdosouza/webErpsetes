import 'package:appweb/app/core/shared/utils/log_events.dart';
import 'package:appweb/app/modules/log/data/model/log_model.dart';
import 'package:appweb/app/modules/log/domain/usecase/delete_log.dart';
import 'package:appweb/app/modules/log/domain/usecase/get_log.dart';
import 'package:appweb/app/modules/log/domain/usecase/send_log.dart';
import 'package:appweb/app/modules/log/domain/usecase/set_log.dart';
import 'package:appweb/app/modules/log/presentation/bloc/event.dart';
import 'package:appweb/app/modules/log/presentation/bloc/state.dart';
import 'package:bloc/bloc.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  final GetLog getLog;
  final SetLog setLog;
  final DeleteLog deleteLog;
  final SendLog sendLog;

  List<LogModel> logList = [];

  LogBloc({
    required this.getLog,
    required this.setLog,
    required this.deleteLog,
    required this.sendLog,
  }) : super(Initial()) {
    _setLog();
    _getLog();
    _deleteLog();
    _sendLog();
  }

  void _setLog() {
    on<SetLogEvent>((event, emit) async {
      emit(LoadingState());
      var response = await setLog.call(event.params);

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        emit(Initial());
      });
    });
  }

  void _getLog() {
    on<GetLogEvent>((event, emit) async {
      emit(LoadingState());
      var response = await getLog.call(LogModel.empty());

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        logList = r;
        emit(LoadedState(list: logList));
      });
    });
  }

  void _deleteLog() {
    on<DeleteLogEvent>((event, emit) async {
      emit(LoadingState());
      var response = await deleteLog.call(LogModel.empty());

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        logList.clear();
        emit(LoadedState(list: logList));
      });
    });
  }

  void _sendLog() {
    on<SendLogEvent>((event, emit) async {
      emit(LoadingState());
      var response = await sendLog.call(await getJsonPathFile());

      response.fold((l) => emit(ErrorState(message: l.toString())), (r) {
        logList.clear();
        emit(LoadedState(list: logList));
      });
    });
  }
}
