import 'package:json_annotation/json_annotation.dart';
import 'package:xopinionx/global/enums.dart';
part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  UserModel({
    this.fname,
    this.lname,
    this.email,
    this.id,
    this.sessionBalance,
    this.schoolORCollege,
    this.eduYear,
    this.overallReview,
    this.languagePreferences,
    this.registrationStatus,
    this.userTags,
  });
  String fname;
  String lname;
  String email;
  String id;
  int sessionBalance;
  String schoolORCollege; // CS OR SS
  int eduYear;
  double overallReview;
  String languagePreferences;
  String registrationStatus;
  List<Tags> userTags;
  factory UserModel.fromJson(Map<String, dynamic> data) =>
      _$UserModelFromJson(data);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

//TODO: Something to confirm the user's education level
enum registrationStatus {
  registered,
  invited,
  dummy,
}
