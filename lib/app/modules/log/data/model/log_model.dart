import 'package:appweb/app/modules/log/domain/entity/log_entity.dart';

class LogModel extends LogEntity {
  LogModel({
    super.tmRecord,
    required super.interfaceName,
    required super.operation,
    required super.reference,
    required super.note,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      tmRecord: json['tm_record'],
      interfaceName: json['interface_name'],
      operation: json['operation'],
      reference: json['reference'],
      note: json['note'],
    );
  }

  factory LogModel.empty() {
    return LogModel(
      tmRecord: '',
      interfaceName: '',
      operation: '',
      reference: '',
      note: '',
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['tm_record'] = tmRecord;
    json['interface_name'] = interfaceName;
    json['operation'] = operation;
    json['reference'] = reference;
    json['note'] = note;
    return json;
  }
}
