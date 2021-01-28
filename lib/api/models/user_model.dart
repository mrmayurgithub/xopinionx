import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
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
  });
  String fname;
  String lname;
  String email;
  String id;
  int sessionBalance;
  String schoolORCollege; // CS OR SS
  int eduYear;
  int overallReview;
  List<String> languagePreferences;

  factory UserModel.fromJson(Map<String, dynamic> data) => _$UserModelFromJson(data);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
//TODO: Something to confirm the user's education level