// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_Session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletedSessionModel _$CompletedSessionModelFromJson(
    Map<String, dynamic> json) {
  return CompletedSessionModel(
    from: json['from'] as String,
    to: json['to'] as String,
    problemId: json['problemId'] as String,
    problemTitle: json['problemTitle'] as String,
    description: json['description'] as String,
    dateCompleted: json['dateCompleted'] as String,
    applicatantViews: json['applicatantViews'] as String,
  );
}

Map<String, dynamic> _$CompletedSessionModelToJson(
        CompletedSessionModel instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'problemId': instance.problemId,
      'problemTitle': instance.problemTitle,
      'description': instance.description,
      'dateCompleted': instance.dateCompleted,
      'applicatantViews': instance.applicatantViews,
    };
