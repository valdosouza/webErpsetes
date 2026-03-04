import 'dart:io';
import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/shared/utils/log_events.dart';
import 'package:appweb/app/modules/log/data/model/log_model.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:developer' as developer;

abstract class Datasource {
  Datasource();

  Future<String> set({required LogModel params});
  Future<List<LogModel>> get({required LogModel params});
  Future<bool> delete({required LogModel params});
  Future<bool> send({required String params});
}

class DatasourceImpl extends Datasource {
  DatasourceImpl();
  //List<HomeSalesPaymentTypeModel> homeSalesPaymentTypesModel = [];
  @override
  Future<String> set({required LogModel params}) async {
    setLog(params: params);
    return "Log Gravado";
  }

  @override
  Future<List<LogModel>> get({required LogModel params}) async {
    try {
      return await getLog(params: params);
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      throw ServerException();
    }
  }

  @override
  Future<bool> delete({required LogModel params}) async {
    try {
      return await deleteLog();
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      throw ServerException();
    }
  }

  @override
  Future<bool> send({required String params}) async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      final file = XFile('${dir.path}/app_logs.json');
      await SharePlus.instance.share(
          ShareParams(files: [file], text: "Arquivo de Log"));

      return true;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      developer.log(e.toString());
      throw LocalException(message: e.toString());
    }
  }
}
