import 'package:json_annotation/json_annotation.dart';
part 'completed_Session.g.dart';

@JsonSerializable()
class CompletedSessionModel {
  CompletedSessionModel({
    this.from,
    this.to,
    this.problemId,
    this.problemTitle,
    this.description,
    this.dateCompleted,
    this.applicatantViews,
  });
  String from;
  String to;
  String problemId;
  String problemTitle;
  String description;
  String dateCompleted;
  String applicatantViews;

  factory CompletedSessionModel.fromJson(Map<String, dynamic> data) => _$CompletedSessionModelFromJson(data);
  Map<String, dynamic> toJson() => _$CompletedSessionModelToJson(this);
}
