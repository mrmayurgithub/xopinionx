import 'package:json_annotation/json_annotation.dart';
import 'package:xopinionx/global/enums.dart';

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
    this.meetLink,
  });
  String userId;
  String problemId;
  String problemTitle;
  String problemDescription;
  String datePosted;
  bool status;
  Tags tag;
  String meetLink;
  factory ProblemModel.fromJson(Map<String, dynamic> data) => _$ProblemModelFromJson(data);
  Map<String, dynamic> toJson() => _$ProblemModelToJson(this);
}
