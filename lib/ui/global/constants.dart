import 'package:flutter/material.dart';
import 'package:xopinionx/core/api/models/tags_model.dart';
import 'package:xopinionx/global/enums.dart';

const kDefaultPadding = 20.0;
const kMaxWidth = 1232.0;
const kDefaultDuration = Duration(milliseconds: 250);

Color kSecondaryColor = const Color(0xff212121);
// Color kSecondaryColor = Color(0xff262d31);

Color kBackgroundColor = const Color(0xff212332);
// Color kBackgroundColor = Color(0xff090e11);
Color kPrimaryColor = Colors.green;
Color kMenuTextColor = const Color(0xff70727d);
Color kTextColor = Colors.white.withOpacity(0.8);

List<TagModel> choiceTags = <TagModel>[
  const TagModel(tagcode: Tags.timemanagement, tagname: 'Time Management'),
  const TagModel(tagcode: Tags.coding, tagname: 'Coding'),
  const TagModel(tagcode: Tags.interview, tagname: 'Interview'),
  const TagModel(tagcode: Tags.internship, tagname: 'Internship'),
  const TagModel(tagcode: Tags.projects, tagname: 'Projects'),
  const TagModel(tagcode: Tags.collegeadmission, tagname: 'College Admission'),
  const TagModel(tagcode: Tags.boards, tagname: 'Career'),
  const TagModel(tagcode: Tags.abroadinternship, tagname: 'Abroad Internship'),
  const TagModel(tagcode: Tags.higherstudies, tagname: 'Abroad Studies'),
  const TagModel(tagcode: Tags.productivity, tagname: 'Productivity'),
];
