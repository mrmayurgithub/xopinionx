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
    chatId: json['chatId'] as String,
    review: (json['review'] as num)?.toDouble(),
    dateCreated: json['dateCreated'] as String,
    dateUpdated: json['dateUpdated'] as String,
  );
}

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'studentId': instance.studentId,
      'teacherId': instance.teacherId,
      'problemId': instance.problemId,
      'chatId': instance.chatId,
      'review': instance.review,
      'dateCreated': instance.dateCreated,
      'dateUpdated': instance.dateUpdated,
    };
