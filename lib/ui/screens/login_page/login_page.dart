import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/components/customFormField.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/global/validators.dart';
import 'package:xopinionx/ui/screens/home_page/home_page.dart';
import 'package:xopinionx/ui/screens/login_page/bloc/login_bloc.dart';
import 'package:xopinionx/ui/screens/register_page/register_page.dart';
import 'package:xopinionx/ui/screens/user_home_page/user_home_page.dart';

class LoginPage extends StatelessWidget {
  static const String id = "login_page";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: LoginMainBody(),
    );
  }
}

class LoginMainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginFailure) {
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "LoginPage Error: " + state.message);
          logger.wtf(state.message);
        }
        if (state is LoginSuccess) {
          Navigator.of(context).pop();
          await Fluttertoast.showToast(msg: 'Login Successful');
          Navigator.of(context).pushReplacementNamed(UserHomePage.id);
        }
        if (state is LoginInProgress) {
          showProgress(context);
        }
        if (state is LoginNeedsVerification) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Fluttertoast.showToast(msg: 'Please verify your email');
        }
        if (state is ForgetPasswordSuccess) {
          //TODO: complete
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text(
              'OPINIONX',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {},
                child: Text('About Us'),
              ),
              FlatButton(
                onPressed: () {},
                child: Text('Donate'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterPage.id);
                },
                child: Text('SignUp'),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0,
                        ),
                      ],
                    ),
                    // height: screenHeight / 2,
                    width: 570,
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: LoginForm(),
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

class LoginForm extends StatefulWidget {
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
        children: [
          Text('Get Started with Opinionx'),
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

          FlatButton(
            color: Colors.green,
            onPressed: () {
              if (_formkey.currentState.validate()) {
                logger.i('validated');
                BlocProvider.of<LoginBloc>(context).add(
                  LoginButtonPressed(
                    email: _emailTextController.text,
                    password: _passtextController.text,
                  ),
                );
              } else {
                Fluttertoast.showToast(msg: 'Email or password is incorrect !');
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 120,
              ),
              child: Text(
                'Login',
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
          SizedBox(height: screenHeight * 0.024459975), // 22

          FlatButton(
            color: Colors.blue,
            onPressed: () {
              if (_formkey.currentState.validate()) {
                // BlocProvider.of<LoginBloc>(context).add(
                //   LoginButtonPressed(
                //     email: _emailTextController.text,
                //     password: _passtextController.text,
                //   ),
                // );
              } else {
                Fluttertoast.showToast(msg: 'Email or password is incorrect !');
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 120,
              ),
              child: Text(
                'Continue with Google',
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
        ],
      ),
    );
  }
}
