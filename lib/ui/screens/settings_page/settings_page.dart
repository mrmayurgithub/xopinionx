import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xopinionx/global/enums.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/components/customFormField.dart';
import 'package:xopinionx/ui/components/drawer.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/global/validators.dart';
import 'package:xopinionx/ui/screens/settings_page/bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: SettingsMainBody(),
    );
  }
}

class SettingsMainBody extends StatefulWidget {
  @override
  _SettingsMainBodyState createState() => _SettingsMainBodyState();
}

class _SettingsMainBodyState extends State<SettingsMainBody> {
  bool editable = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          drawer: MainDrawer(),
          body: Builder(
            builder: (context) {
              return BlocListener<SettingsBloc, SettingsState>(
                listener: (context, state) {
                  if (state is SettingsFailure) {
                    Fluttertoast.showToast(msg: state.message);
                  }
                  if (state is SettingsSaved) {
                    Navigator.of(context).pop();
                    editable = false;
                    Fluttertoast.showToast(msg: 'Settings Updated.');
                  }
                  if (state is SettingsCancelled) {
                    editable = false;
                  }
                  if (state is SettingsInProgress) {
                    showProgress(context);
                  }
                  if (state is EditableSettingsPage) {
                    editable = true;
                  }
                  if (state is SettingsPageLoaded) {}
                  if (state is SettingsInitial) {
                    showProgress(context);
                  }
                },
                child: Center(
                  child: SingleChildScrollView(
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: 570,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: SettingsForm(
                          enabled: editable,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

List<DropdownMenuItem<String>> _langs = <DropdownMenuItem<String>>[
  const DropdownMenuItem<String>(
    value: 'en',
    child: Text('English'),
  ),
  const DropdownMenuItem<String>(
    value: 'hi',
    child: Text('Hindi'),
  ),
];

List<DropdownMenuItem<String>> _edLevel = <DropdownMenuItem<String>>[
  const DropdownMenuItem<String>(
    value: 'ss',
    child: Text('School Student'),
  ),
  const DropdownMenuItem<String>(
    value: 'cs',
    child: Text('College Student'),
  ),
  const DropdownMenuItem<String>(
    value: 'pr',
    child: Text('Professional'),
  ),
];

class SettingsForm extends StatefulWidget {
  final bool enabled;

  const SettingsForm({@required this.enabled});
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _chipKey = GlobalKey<ChipsInputState>();
  final _formkey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _firstnameTextController = TextEditingController();
  final _lastnameTextController = TextEditingController();
  final _firstnameNode = FocusNode();
  final _lastnameNode = FocusNode();
  final _emailNode = FocusNode();
  final _chipNode = FocusNode();
  final _validator = Validator();
  final _eduYearTextController = TextEditingController();
  final _eduYearNode = FocusNode();
  List<Tags> _usertags = [];
  String _education;
  // List<Tags> _tagstemplist = [];
  String _langPref;
  int eduYear;
  @override
  void initState() {
    _firstnameTextController.text = globalUser.fname;
    _lastnameTextController.text = globalUser.lname;
    _langPref = globalUser.languagePreferences;
    _emailTextController.text = globalUser.email;
    _eduYearTextController.text = globalUser.eduYear.toString();
    _education = globalUser.schoolORCollege;
    _usertags = globalUser.userTags;
    // _tagstemplist = _usertags;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Text('Get Started with Opinionx'),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ListTile(
              title: const Text('Profile Settings'),
              // tileColor: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          CustomTextFormField(
            enabled: widget.enabled,
            currentNode: _firstnameNode,
            nextNode: _emailNode,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            fieldController: _firstnameTextController,
            hintText: _firstnameTextController.text,
            keyboardType: TextInputType.name,
            validator: _validator.validateName,
            prefixIcon: const Icon(Icons.person_outline),
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          CustomTextFormField(
            enabled: widget.enabled,
            currentNode: _lastnameNode,
            nextNode: _emailNode,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            fieldController: _lastnameTextController,
            hintText: _lastnameTextController.text,
            keyboardType: TextInputType.name,
            validator: _validator.validateName,
            prefixIcon: const Icon(Icons.person_outline),
          ),

          SizedBox(height: screenHeight * 0.024459975), // 22
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonFormField<String>(
              value: _langPref,
              decoration: const InputDecoration(
                labelText: 'Language Preference',
                hintText: 'Preferred mode of communication',
              ),
              items: _langs,
              onChanged: (value) {
                setState(() {
                  _langPref = value;
                });
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonFormField<String>(
              value: _education,
              decoration: InputDecoration(
                labelText: 'Education Level',
                hintText: 'Education Level',
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: _edLevel,
              onChanged: (value) {
                setState(() {
                  _education = value;
                });
              },
            ),
          ),
          if (_education != '')
            SizedBox(height: screenHeight * 0.024459975)
          else
            const SizedBox(), // 22

          if (_education == 'ss')
            CustomTextFormField(
              enabled: widget.enabled,
              nextNode: _chipNode,
              currentNode: _eduYearNode,
              textInputAction: TextInputAction.done,
              maxLines: 1,
              fieldController: _eduYearTextController,
              hintText: 'School Year',
              prefixIcon: const Icon(Icons.lock_outline),
              keyboardType: TextInputType.text,
              validator: (val) {
                final int x = int.parse(_eduYearTextController.text.toString());
                if (x >= 9 && x <= 12) {
                  return null;
                } else {
                  return 'Only students from 9th class upto 12th can register.';
                }
              },
            )
          else
            const SizedBox(),
          if (_education == 'cs')
            CustomTextFormField(
              enabled: widget.enabled,
              nextNode: _chipNode,
              currentNode: _eduYearNode,
              textInputAction: TextInputAction.done,
              maxLines: 1,
              fieldController: _eduYearTextController,
              hintText: 'Enter your College Year',
              prefixIcon: const Icon(Icons.lock_outline),
              keyboardType: TextInputType.text,
              validator: (val) {
                final int x = int.parse(_eduYearTextController.text.toString());
                if (x >= 1 && x <= 4) {
                  return null;
                } else {
                  return 'Only students from 1st year class upto 5th year can register.';
                }
              },
            )
          else
            const SizedBox(),
          if (_education == 'pr')
            CustomTextFormField(
              enabled: widget.enabled,
              nextNode: _chipNode,
              currentNode: _eduYearNode,
              textInputAction: TextInputAction.done,
              maxLines: 1,
              fieldController: _eduYearTextController,
              hintText: 'Enter years of experience',
              prefixIcon: const Icon(Icons.lock_outline),
              keyboardType: TextInputType.text,
              validator: (val) {
                final int x = int.parse(_eduYearTextController.text.toString());
                if (x <= 50) {
                  return null;
                } else {
                  return 'Enter a valid value';
                }
              },
            )
          else
            const SizedBox(),
          SizedBox(height: screenHeight * 0.024459975), // 22
          // Center(
          //   child: Text('Select the fields you feel free to talk about'),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                ChipsInput(
                  key: _chipKey,
                  // maxChips: 3,
                  focusNode: _chipNode,
                  enabled: false,
                  findSuggestions: (String query) {
                    final String lowercaseQuery = query.toLowerCase();
                    if (query.isNotEmpty) {
                      return choiceTags.where((tag) {
                        return tag.tagname
                            .toLowerCase()
                            .contains(query.toLowerCase());
                      }).toList(growable: false)
                        ..sort(
                          (a, b) => a.tagname
                              .toLowerCase()
                              .indexOf(lowercaseQuery)
                              .compareTo(
                                b.tagname.toLowerCase().indexOf(lowercaseQuery),
                              ),
                        );
                    }
                    return choiceTags;
                  },
                  onChanged: (val) {},
                  textOverflow: TextOverflow.ellipsis,
                  chipBuilder: (context, state, TagModel tag) {
                    return InputChip(
                      key: ObjectKey(tag),
                      label: Text(tag.tagname),
                      onDeleted: () {
                        state.deleteChip(tag);
                        _usertags.remove(tag.tagcode);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  },
                  suggestionBuilder: (context, state, TagModel tag) {
                    // if (_tagstemplist.length != 0) {
                    //   for (Tags tag in _usertags) state.selectSuggestion(tag);
                    // }
                    return ListTile(
                      key: ObjectKey(tag),
                      title: Text(tag.tagname),
                      onTap: () {
                        state.selectSuggestion(tag);
                        _usertags.add(tag.tagcode);
                        logger.w('tag pressed ${tag.tagname}');
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          if (widget.enabled == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _firstnameTextController.text = globalUser.fname;
                    _lastnameTextController.text = globalUser.lname;

                    BlocProvider.of<SettingsBloc>(context)
                        .add(CancelButtonPressed());
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 60,
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        letterSpacing: 1.3,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    BlocProvider.of<SettingsBloc>(context).add(
                      SaveButtonPressed(
                        fname: _firstnameTextController.text,
                        lname: _lastnameTextController.text,
                        educationLevel: _education,
                        eduYear: int.parse(_eduYearTextController.text),
                        langpref: _langPref,
                        usertags: _usertags,
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 60,
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        letterSpacing: 1.3,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                BlocProvider.of<SettingsBloc>(context).add(EditButtonPressed());
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 120,
                ),
                child: Text(
                  'Edit',
                  style: TextStyle(
                    letterSpacing: 1.3,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

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

class TagModel extends Equatable {
  final Tags tagcode;
  final String tagname;
  const TagModel({@required this.tagcode, @required this.tagname});

  @override
  List<Object> get props => [tagcode, tagname];
}
