// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProblemModel _$ProblemModelFromJson(Map<String, dynamic> json) {
  return ProblemModel(
    userId: json['userId'] as String,
    problemId: json['problemId'] as String,
    problemTitle: json['problemTitle'] as String,
    problemDescription: json['problemDescription'] as String,
    datePosted: json['datePosted'] as String,
    status: json['status'] as bool,
    tag: _$enumDecodeNullable(_$TagsEnumMap, json['tag']),
  );
}

Map<String, dynamic> _$ProblemModelToJson(ProblemModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'problemId': instance.problemId,
      'problemTitle': instance.problemTitle,
      'problemDescription': instance.problemDescription,
      'datePosted': instance.datePosted,
      'status': instance.status,
      'tag': _$TagsEnumMap[instance.tag],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TagsEnumMap = {
  Tags.timemanagement: 'timemanagement',
  Tags.coding: 'coding',
  Tags.interview: 'interview',
  Tags.internship: 'internship',
  Tags.projects: 'projects',
  Tags.collegeadmission: 'collegeadmission',
  Tags.boards: 'boards',
  Tags.career: 'career',
  Tags.branchselection: 'branchselection',
  Tags.abroadinternship: 'abroadinternship',
  Tags.higherstudies: 'higherstudies',
  Tags.productivity: 'productivity',
  Tags.motivation: 'motivation',
};
