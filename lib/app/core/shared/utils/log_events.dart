import 'dart:convert';
import 'dart:io';
import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/modules/log/data/model/log_model.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:intl/intl.dart';

Future<bool> deleteLog() async {
  final file = await getFile();
  await file.writeAsString('');
  return true;
}

Future getFile() async {
  if (kIsWeb) {
    String path = "/assets/db";
    final file = File('$path/app_logs.json');
    return file;
  } else {
    Directory dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/app_logs.json');
    return file;
  }
}

Future<void> setLog({required LogModel params}) async {
  params.tmRecord = "";
  //DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  final file = await getFile();
  String content = '';
  if (await file.exists()) {
    content = await file.readAsString();
  }

  // Abre o arquivo no modo de appender
  final sink = file.openWrite(mode: FileMode.append);
  // Escreve o conteúdo no arquivo
  if (content.isEmpty) {
    sink.write(json.encode(params.toJson()));
  } else {
    sink.write(',${json.encode(params.toJson())}');
  }
  // Fecha o arquivo
  await sink.close();
}

Future<String> getJson() async {
  final file = await getFile();
  if (!await file.exists()) return '';
  final jsonString = await file.readAsString();
  return jsonString;
}

Future<String> getJsonPathFile() async {
  if (kIsWeb) {
    String path = "/assets/db";
    final file = '$path/app_logs.json';
    return file;
  } else {
    Directory dir = await getApplicationDocumentsDirectory();
    final file = '${dir.path}/app_logs.json';
    return file;
  }
}

Future<List<LogModel>> getLog({required LogModel params}) async {
  try {
    List<LogModel> list = [];
    /*
    final jsonString = await getJson();
    if (jsonString.isNotEmpty) {
      final jsonList = '[$jsonString]';
      developer.log(jsonList);
      final jsonData = json.decode(jsonList);
      if (jsonData.isNotEmpty) {
        list = (jsonData as List).map((json) {
          return LogModel.fromJson(json);
        }).toList();
      }
    }
    */
    return list;
  } catch (e, s) {
    FirebaseCrashlytics.instance.recordError(e, s);
    throw LocalException(message: e.toString());
  }
}
