import 'package:flutter/material.dart';
import 'package:xopinionx/global/enums.dart';

class TagsProvider with ChangeNotifier {
  List<Tags> _tags = [];
  List<Tags> get tagslist => _tags;
  addtag({@required Tags tag}) {
    _tags.add(tag);
    notifyListeners();
  }

  removetag({@required Tags tag}) {
    _tags.remove(tag);
    notifyListeners();
  }
}
