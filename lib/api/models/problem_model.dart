import 'package:json_annotation/json_annotation.dart';

part 'problem_model.g.dart';

@JsonSerializable()
class ProblemModel {
  ProblemModel({
    this.userId,
    this.problemId,
    this.problemTitle,
    this.problemDescription,
    this.datePosted,
    this.status,
    this.tag,
  });
  String userId;
  String problemId;
  String problemTitle;
  String problemDescription;
  String datePosted;
  bool status;
  String tag;
  factory ProblemModel.fromJson(Map<String, dynamic> data) => _$ProblemModelFromJson(data);
  Map<String, dynamic> toJson() => _$ProblemModelToJson(this);
}
