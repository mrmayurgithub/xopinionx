// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    fname: json['fname'] as String,
    lname: json['lname'] as String,
    email: json['email'] as String,
    id: json['id'] as String,
    sessionBalance: json['sessionBalance'] as int,
    schoolORCollege: json['schoolORCollege'] as String,
    eduYear: json['eduYear'] as int,
    overallReview: json['overallReview'] as int,
    registrationStatus: json['registrationStatus'] as String,
    languagePreferences: json['languagePreferences'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'id': instance.id,
      'sessionBalance': instance.sessionBalance,
      'schoolORCollege': instance.schoolORCollege,
      'eduYear': instance.eduYear,
      'overallReview': instance.overallReview,
      'languagePreferences': instance.languagePreferences,
      'registrationStatus': instance.registrationStatus,
    };
