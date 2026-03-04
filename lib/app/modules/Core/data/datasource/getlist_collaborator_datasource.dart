import 'dart:convert';
import 'package:appweb/app/core/gateway.dart';
import 'package:appweb/app/modules/Core/data/model/collaborator_list_model.dart';
import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/shared/constants.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

abstract class GetlistCollaboratorDatasource extends Gateway {
  GetlistCollaboratorDatasource({required super.httpClient});

  Future<List<CollaboratorListModel>> getlistCollaborator();
}

class GetlistCollaboratorDatasourceImpl extends GetlistCollaboratorDatasource {
  List<CollaboratorListModel> list = [];

  GetlistCollaboratorDatasourceImpl({required super.httpClient});

  @override
  Future<List<CollaboratorListModel>> getlistCollaborator() async {
    try {
      String tbInstitutionId = '1';
      await getInstitutionId().then((value) {
        tbInstitutionId = value.toString();
      });

      final uri =
          Uri.parse('${baseApiUrl}collaborator/getlist/$tbInstitutionId');
      final response = await httpClient.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        list = (data as List).map((json) {
          return CollaboratorListModel.fromJson(json);
        }).toList();

        return list;
      } else {
        throw ServerException();
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      throw ServerException();
    }
  }
}
