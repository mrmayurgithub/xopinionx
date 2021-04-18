import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xopinionx/global/enums.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/components/customFormField.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/global/validators.dart';
import 'package:xopinionx/ui/screens/register_page/bloc/register_bloc.dart';
import 'package:xopinionx/utils/routes.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: RegistrationPageMainBody(),
    );
  }
}

class RegistrationPageMainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) async {
        if (state is RegisterInitial) {
          return CircularProgressIndicator();
        }
        if (state is RegisterInProgress) {
          showProgress(context);
        }
        if (state is RegisterSuccess) {
          Navigator.of(context).pushReplacementNamed(MainRoutes.verificationRoute);
        }
        if (state is RegisterFailed) {
          logger.d(state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          // extendBodyBehindAppBar: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: GestureDetector(
              onTap: () {
                // Navigator.of(context).pushReplacementNamed(HomePage.id);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  MainRoutes.homePageRoute,
                  (route) => false,
                );
              },
              child: Text(
                'OPINIONX',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(MainRoutes.loginRoute);
                },
                child: Text("Login"),
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey,
                      //     blurRadius: 15.0,
                      //   ),
                      // ],
                    ),
                    // height: screenHeight / 2,
                    width: 570,
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: SignUpForm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _chipKey = GlobalKey<ChipsInputState>();
  final _formkey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _firstnameTextController = TextEditingController();
  final _lastnameTextController = TextEditingController();
  final _passtextController = TextEditingController();
  final _firstnameNode = FocusNode();
  final _lastnameNode = FocusNode();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();
  final _chipNode = FocusNode();
  final _validator = Validator();
  bool _isObscure = true;
  final _eduYearTextController = TextEditingController();
  final _eduYearNode = FocusNode();
  List<Tags> _usertags = [];
  String _education;
  String _langPref;
  int eduYear;
  @override
  Widget build(BuildContext context) {
    Widget _showPassIcon() {
      return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        child: IconButton(
          icon: _isObscure ? Icon(Icons.visibility_off_outlined) : Icon(Icons.visibility_outlined),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      );
    }

    return Form(
      key: _formkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Get Started with Opinionx'),
          SizedBox(height: screenHeight * 0.024459975), // 22
          CustomTextFormField(
            currentNode: _firstnameNode,
            nextNode: _emailNode,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            fieldController: _firstnameTextController,
            hintText: 'Full Name',
            keyboardType: TextInputType.name,
            validator: _validator.validateName,
            prefixIcon: Icon(Icons.person_outline),
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          CustomTextFormField(
            currentNode: _lastnameNode,
            nextNode: _emailNode,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            fieldController: _lastnameTextController,
            hintText: 'Last Name',
            keyboardType: TextInputType.name,
            validator: _validator.validateName,
            prefixIcon: Icon(Icons.person_outline),
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          CustomTextFormField(
            currentNode: _emailNode,
            nextNode: _passwordNode,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            fieldController: _emailTextController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: _validator.validateEmail,
            prefixIcon: Icon(Icons.email_outlined),
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          CustomTextFormField(
            currentNode: _passwordNode,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            fieldController: _passtextController,
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock_outline),
            keyboardType: TextInputType.text,
            validator: _validator.validatePassword,
            obscureText: _isObscure,
            suffix: _showPassIcon(),
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonFormField(
              value: _langPref,
              decoration: InputDecoration(
                labelText: 'Language Preference',
                hintText: 'Preferred mode of communication',
              ),
              items: [
                DropdownMenuItem<String>(
                  child: Text('English'),
                  value: 'en',
                ),
                DropdownMenuItem<String>(
                  child: Text('Hindi'),
                  value: 'hi',
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _langPref = value;
                });
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonFormField(
              value: _education,
              decoration: InputDecoration(
                labelText: 'Education Level',
                hintText: 'Education Level',
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
              items: [
                DropdownMenuItem<String>(
                  child: Text('School Student'),
                  value: 'ss',
                ),
                DropdownMenuItem<String>(
                  child: Text('College Student'),
                  value: 'cs',
                ),
                DropdownMenuItem<String>(
                  child: Text('Professional'),
                  value: 'pr',
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _education = value;
                });
              },
            ),
          ),
          _education != '' ? SizedBox(height: screenHeight * 0.024459975) : SizedBox(), // 22

          _education == 'ss'
              ? CustomTextFormField(
                  nextNode: _chipNode,
                  currentNode: _eduYearNode,
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  fieldController: _eduYearTextController,
                  hintText: 'School Year',
                  prefixIcon: Icon(Icons.lock_outline),
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    int x = int.parse(_eduYearTextController.text.toString());
                    if (x >= 9 && x <= 12) {
                      return null;
                    } else {
                      return 'Only students from 9th class upto 12th can register.';
                    }
                  },
                )
              : SizedBox(),
          _education == 'cs'
              ? CustomTextFormField(
                  nextNode: _chipNode,
                  currentNode: _eduYearNode,
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  fieldController: _eduYearTextController,
                  hintText: 'Enter your College Year',
                  prefixIcon: Icon(Icons.lock_outline),
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    int x = int.parse(_eduYearTextController.text.toString());
                    if (x >= 1 && x <= 4) {
                      return null;
                    } else {
                      return 'Only students from 1st year class upto 5th year can register.';
                    }
                  },
                )
              : SizedBox(),
          _education == 'pr'
              ? CustomTextFormField(
                  nextNode: _chipNode,
                  currentNode: _eduYearNode,
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  fieldController: _eduYearTextController,
                  hintText: 'Enter years of experience',
                  prefixIcon: Icon(Icons.lock_outline),
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    int x = int.parse(_eduYearTextController.text.toString());
                    if (x <= 50) {
                      return null;
                    } else {
                      return 'Enter a valid value';
                    }
                  },
                )
              : SizedBox(),
          SizedBox(height: screenHeight * 0.024459975), // 22
          Center(
            child: Text('Select the fields you feel free to talk about'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                ChipsInput(
                  key: _chipKey,
                  // maxChips: 3,
                  focusNode: _chipNode,
                  enabled: false,
                  findSuggestions: (String query) {
                    var lowercaseQuery = query.toLowerCase();
                    if (query.isNotEmpty) {
                      return choiceTags.where((tag) {
                        return tag.tagname.toLowerCase().contains(query.toLowerCase());
                      }).toList(growable: false)
                        ..sort(
                          (a, b) => a.tagname.toLowerCase().indexOf(lowercaseQuery).compareTo(
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
                  // decoration: InputDecoration(
                  //   border: kInputBorderStyle,
                  //   focusedBorder: kInputBorderStyle,
                  //   enabledBorder: kInputBorderStyle,
                  // ),

                  suggestionBuilder: (context, state, TagModel tag) {
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
          FlatButton(
            color: Colors.green,
            onPressed: () {
              if (_formkey.currentState.validate()) {
                logger.i('validated');
                print(_usertags.toString());
                BlocProvider.of<RegisterBloc>(context).add(
                  RegisterButtonClicked(
                    fname: _firstnameTextController.text,
                    lname: _lastnameTextController.text,
                    educationLevel: _education,
                    eduYear: int.parse(_eduYearTextController.text),
                    langpref: _langPref,
                    email: _emailTextController.text,
                    password: _passtextController.text,
                    usertags: _usertags,
                  ),
                );
              } else {
                Fluttertoast.showToast(msg: 'Check if the information you filled is correct');
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 120,
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  letterSpacing: 1.3,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // SizedBox(height: screenHeight * 0.024459975), // 22
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 8),
          //   child: DropDownField(
          //     hintText: 'Field you wanna talk about',
          //     enabled: true,
          //     itemsVisibleInDropdown: 5,
          //     items: choicetags,
          //   ),
          // ),
        ],
      ),
    );
  }
}

// List<String> choicetags = [
//   "Time Management",
//   "Coding",
//   "Interview",
//   "Internship",
//   "Projects",
//   "College Admission",
//   "Boards",
//   "Career",
//   "Abroad Internship",
//   "Higher Studies",
//   "Productivity",
//   "Motivation",
// ];

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

class TagModel extends Equatable {
  final Tags tagcode;
  final String tagname;
  TagModel({@required this.tagcode, @required this.tagname});

  @override
  List<Object> get props => [tagcode, tagname];
}
