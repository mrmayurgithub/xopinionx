// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return ChatModel(
    studentId: json['studentId'] as String,
    teacherId: json['teacherId'] as String,
    problemId: json['problemId'] as String,
    review: (json['review'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'studentId': instance.studentId,
      'teacherId': instance.teacherId,
      'problemId': instance.problemId,
      'review': instance.review,
    };