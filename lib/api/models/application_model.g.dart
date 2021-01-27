// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationModel _$ApplicationModelFromJson(Map<String, dynamic> json) {
  return ApplicationModel(
    applicantViews: json['applicantViews'] as String,
    problemId: json['problemId'] as String,
    from: json['from'] as String,
  );
}

Map<String, dynamic> _$ApplicationModelToJson(ApplicationModel instance) =>
    <String, dynamic>{
      'applicantViews': instance.applicantViews,
      'problemId': instance.problemId,
      'from': instance.from,
    };
