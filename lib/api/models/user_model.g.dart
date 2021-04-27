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
    languagePreferences: json['languagePreferences'] as String,
    registrationStatus: json['registrationStatus'] as String,
    userTags: (json['userTags'] as List)
        ?.map((e) => _$enumDecodeNullable(_$TagsEnumMap, e))
        ?.toList(),
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
      'userTags': instance.userTags?.map((e) => _$TagsEnumMap[e])?.toList(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TagsEnumMap = {
  Tags.timemanagement: 'timemanagement',
  Tags.coding: 'coding',
  Tags.interview: 'interview',
  Tags.internship: 'internship',
  Tags.projects: 'projects',
  Tags.collegeadmission: 'collegeadmission',
  Tags.boards: 'boards',
  Tags.career: 'career',
  Tags.branchselection: 'branchselection',
  Tags.abroadinternship: 'abroadinternship',
  Tags.higherstudies: 'higherstudies',
  Tags.productivity: 'productivity',
  Tags.motivation: 'motivation',
};
