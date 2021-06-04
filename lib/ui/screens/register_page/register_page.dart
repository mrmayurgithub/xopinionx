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
import 'package:xopinionx/ui/screens/settings_page/settings_page.dart';
import 'package:xopinionx/utils/routes.dart';
import 'package:xopinionx/utils/status.dart';
import 'package:velocity_x/velocity_x.dart';

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
          return const CircularProgressIndicator();
        }
        if (state is RegisterInProgress) {
          showProgress(context);
        }
        if (state is RegisterSuccess) {
          if (isLoggedIn()) {
            context.vxNav.replace(Uri.parse(MainRoutes.verificationRoute));
          } else {
            context.vxNav.clearAndPush(Uri.parse(MainRoutes.homePageRoute));
          }
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
                context.vxNav.clearAndPush(Uri.parse(MainRoutes.homePageRoute));
              },
              child: const Text(
                'OPINIONX',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.vxNav.replace(Uri.parse(MainRoutes.loginRoute));
                },
                child: const Text("Login"),
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 570,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
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
  final List<Tags> _usertags = [];
  String _education;
  String _langPref;
  int eduYear;
  @override
  Widget build(BuildContext context) {
    Widget _showPassIcon() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          icon: _isObscure
              ? const Icon(Icons.visibility_off_outlined)
              : const Icon(Icons.visibility_outlined),
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
          const Text('Get Started with Opinionx'),
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
            prefixIcon: const Icon(Icons.person_outline),
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
            prefixIcon: const Icon(Icons.person_outline),
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
            prefixIcon: const Icon(Icons.email_outlined),
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          CustomTextFormField(
            currentNode: _passwordNode,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            fieldController: _passtextController,
            hintText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
            keyboardType: TextInputType.text,
            validator: _validator.validatePassword,
            obscureText: _isObscure,
            suffix: _showPassIcon(),
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonFormField(
              value: _langPref,
              decoration: const InputDecoration(
                labelText: 'Language Preference',
                hintText: 'Preferred mode of communication',
              ),
              items: _langs,
              onChanged: (String value) {
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
              onChanged: (String value) {
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
          const Center(
            child: Text('Select the fields you feel free to talk about'),
          ),
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
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              if (_formkey.currentState.validate()) {
                logger.i('validated');
                // ignore: avoid_print
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
                Fluttertoast.showToast(
                    msg: 'Check if the information you filled is correct');
              }
            },
            child: const Padding(
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
          ),
        ],
      ),
    );
  }
}
