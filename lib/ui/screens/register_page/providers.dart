import 'package:flutter/material.dart';
import 'package:xopinionx/global/enums.dart';

class TagsProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Tags> _tags = [];
  List<Tags> get tagslist => _tags;
  void addtag({@required Tags tag}) {
    _tags.add(tag);
    notifyListeners();
  }

  void removetag({@required Tags tag}) {
    _tags.remove(tag);
    notifyListeners();
  }
}
