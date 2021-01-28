import 'package:json_annotation/json_annotation.dart';
part 'application_model.g.dart';

@JsonSerializable()
class ApplicationModel {
  ApplicationModel({
    this.applicantViews,
    this.problemId,
    this.from,
    this.applicationId,
  });
  String applicantViews;
  String problemId;
  String from;
  String applicationId;

  factory ApplicationModel.fromJson(Map<String, dynamic> data) => _$ApplicationModelFromJson(data);
  Map<String, dynamic> toJson() => _$ApplicationModelToJson(this);
}
