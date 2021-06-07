import 'package:json_annotation/json_annotation.dart';
part 'chat_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatModel {
  ChatModel({
    this.studentId,
    this.teacherId,
    this.problemId,
    this.chatId,
    this.review,
    this.date,
  });
  String studentId;
  String teacherId;
  String problemId;
  String chatId;
  double review;
  String date;
  factory ChatModel.fromJson(Map<String, dynamic> data) =>
      _$ChatModelFromJson(data);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
