import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/components/customFormField.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/global/validators.dart';
import 'package:xopinionx/ui/screens/login_page/bloc/login_bloc.dart';
import 'package:xopinionx/config/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:xopinionx/ui/screens/login_page/forgot_password_bloc/forgot_p_bloc.dart';

import '../../../config/responsive.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: LoginMainBody(),
    );
  }
}

// ignore: must_be_immutable
class LoginMainBody extends StatelessWidget {
  bool isProgress = false;
  @override
  Widget build(BuildContext context) {
    //TODO: check if final is good
    final bool isMobile = Responsive.isMobile(context);

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginFailure) {
          // Navigator.of(context).pop();
          context.vxNav.pop();
          Fluttertoast.showToast(msg: "LoginPage Error: ${state.message}");
          logger.wtf(state.message);
        }
        if (state is LoginSuccess) {
          await Fluttertoast.showToast(msg: 'Login Successful');
          context.vxNav.clearAndPush(Uri.parse(MainRoutes.userHomeRoute));
        }
        if (state is LoginInProgress) {
          isProgress = true;
        }
        if (state is LoginNeedsVerification) {
          //TODO: change
          context.vxNav.popToRoot();
          Fluttertoast.showToast(msg: 'Please verify your email');
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: GestureDetector(
                onTap: () {
                  context.vxNav
                      .clearAndPush(Uri.parse(MainRoutes.homePageRoute));
                },
                child: const Text(
                  'OPINIONX',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.vxNav.replace(Uri.parse(MainRoutes.registerRoute));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: kDefaultPadding / 4,
                      horizontal: kDefaultPadding / 3,
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Get started with Opinionx",
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: isMobile ? 22 : 30,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 570,
                      child: Padding(
                        padding: const EdgeInsets.all(kDefaultPadding * 1.5),
                        child: LoginForm(isLoading: isProgress),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LoginForm extends StatefulWidget {
  final bool isLoading;

  const LoginForm({this.isLoading});
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passtextController = TextEditingController();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();
  bool _isObscure = true;
  final _validator = Validator();

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
        children: [
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
          SizedBox(height: screenHeight * 0.014459975), // 22
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                    barrierColor: Theme.of(context).scaffoldBackgroundColor,
                    context: context,
                    builder: (context) => ForgotPasswordBox(),
                  );
                },
                child: Text("Forgot Password"),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          if (widget.isLoading == true)
            CircularProgressIndicator(
              color: kPrimaryColor,
            )
          else
            TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                TextEditingController().clear();
                if (_formkey.currentState.validate()) {
                  logger.i('validated');
                  BlocProvider.of<LoginBloc>(context).add(
                    LoginButtonPressed(
                      email: _emailTextController.text,
                      password: _passtextController.text,
                    ),
                  );
                } else {
                  Fluttertoast.showToast(
                      msg: 'Email or password is incorrect !');
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding / 2.5,
                  horizontal: kDefaultPadding * 3,
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    letterSpacing: 1.3,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          // SizedBox(height: screenHeight * 0.024459975), // 22

          // TextButton(s
          //   // color: Colors.blue,
          //   // shape: RoundedRectangleBorder(
          //   //   borderRadius: BorderRadius.circular(10),
          //   // ),

          //   onPressed: () {
          //     if (_formkey.currentState.validate()) {
          //       // BlocProvider.of<LoginBloc>(context).add(
          //       //   LoginButtonPressed(
          //       //     email: _emailTextController.text,
          //       //     password: _passtextController.text,
          //       //   ),
          //       // );
          //     } else {
          //       Fluttertoast.showToast(msg: 'Email or password is incorrect !');
          //     }
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(
          //       vertical: 16,
          //       horizontal: 120,
          //     ),
          //     child: widget.isLoading
          //         ? CircularProgressIndicator()
          //         : Text(
          //             'Continue with Google',
          //             style: TextStyle(
          //               letterSpacing: 1.3,
          //               color: Colors.white,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ForgotPasswordBox extends StatefulWidget {
  @override
  _ForgotPasswordBoxState createState() => _ForgotPasswordBoxState();
}

class _ForgotPasswordBoxState extends State<ForgotPasswordBox> {
  final _formkey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();

  final _validator = Validator();

  bool isLoading = false;

  bool emailSent = false;

  bool err = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(),
      child: Builder(
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          content: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
            child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) async {
                if (state is ForgotPasswordLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
                if (state is ForgotPasswordSuccess) {
                  setState(() {
                    isLoading = false;
                    emailSent = true;
                  });
                }
                if (state is ForgotPasswordFailure) {
                  setState(() {
                    isLoading = false;
                    emailSent = false;
                    err = true;
                  });
                  logger.wtf(state.message);
                }
              },
              builder: (context, state) => Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: _formkey,
                      child: TextFormField(
                        validator: _validator.validateEmail,
                        controller: _emailTextController,
                        textAlignVertical: TextAlignVertical.center,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: screenHeight * 0.015565438, // 14
                            ),
                        decoration: InputDecoration(
                          border: kInputBorderStyle,
                          focusedBorder: kInputBorderStyle,
                          enabledBorder: kInputBorderStyle,
                          hintStyle:
                              Theme.of(context).textTheme.caption.copyWith(
                                    fontSize: screenHeight * 0.015565438, // 14
                                  ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.036458333,
                              vertical:
                                  screenHeight * 0.021124524), // h=15, v=19
                          hintText: "Enter your Email",
                          suffixIcon: null,

                          suffix: null,
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                    ),
                    if (err || emailSent) SizedBox(height: 10),
                    if (err)
                      Text("Something went wrong!")
                    else if (emailSent)
                      Text("Email has been sent!"),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            if (!isLoading)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: emailSent ? Text("Done") : Text("Cancel"),
              ),
            if (!isLoading && !emailSent)
              TextButton(
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    BlocProvider.of<ForgotPasswordBloc>(context).add(
                        ForgotPasswordRequested(
                            email: _emailTextController.text));
                  } else {}
                },
                child: Text("Send Link"),
              )
          ],
        ),
      ),
    );
  }
}
