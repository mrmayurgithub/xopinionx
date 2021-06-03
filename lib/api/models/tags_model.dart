import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:xopinionx/global/enums.dart';

class TagModel extends Equatable {
  final Tags tagcode;
  final String tagname;
  const TagModel({@required this.tagcode, @required this.tagname});

  @override
  List<Object> get props => [tagcode, tagname];
}
