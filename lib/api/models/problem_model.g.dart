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
    tag: json['tag'] as String,
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
      'tag': instance.tag,
    };
