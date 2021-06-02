import 'package:flutter/material.dart';
import 'package:xopinionx/api/models/tags_model.dart';
import 'package:xopinionx/global/enums.dart';

const kDefaultPadding = 20.0;
const kMaxWidth = 1232.0;
const kDefaultDuration = Duration(milliseconds: 250);

Color kSecondaryColor = Color(0xff2a2d3e);
// Color kSecondaryColor = Color(0xff262d31);

Color kBackgroundColor = Color(0xff212332);
// Color kBackgroundColor = Color(0xff090e11);
Color kPrimaryColor = Colors.green;
Color kMenuTextColor = Color(0xff70727d);

List<TagModel> choiceTags = <TagModel>[
  TagModel(tagcode: Tags.timemanagement, tagname: 'Time Management'),
  TagModel(tagcode: Tags.coding, tagname: 'Coding'),
  TagModel(tagcode: Tags.interview, tagname: 'Interview'),
  TagModel(tagcode: Tags.internship, tagname: 'Internship'),
  TagModel(tagcode: Tags.projects, tagname: 'Projects'),
  TagModel(tagcode: Tags.collegeadmission, tagname: 'College Admission'),
  TagModel(tagcode: Tags.boards, tagname: 'Career'),
  TagModel(tagcode: Tags.abroadinternship, tagname: 'Abroad Internship'),
  TagModel(tagcode: Tags.higherstudies, tagname: 'Abroad Studies'),
  TagModel(tagcode: Tags.productivity, tagname: 'Productivity'),
];
