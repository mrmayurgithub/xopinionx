import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:xopinionx/ui/components/customFormField.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/global/validators.dart';
import 'package:xopinionx/ui/screens/complete_profile_page/complete_profile.dart';
import 'package:xopinionx/ui/screens/profile_page/profile_page.dart';
import 'package:xopinionx/ui/screens/register_page/bloc/register_bloc.dart';

class RegisterPage extends StatelessWidget {
  static const String id = 'register_page';

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
        if (state is RegisterInProgress) {}
        if (state is RegisterSuccess) {}
        if (state is RegisterFailed) {}
      },
      builder: (context, state) {
        return Scaffold(
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
                    height: screenHeight / 2,
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
  GlobalKey _formkey = GlobalKey<ScaffoldState>();
  final _emailTextController = TextEditingController();
  final _firstnameTextController = TextEditingController();
  final _lastnameTextController = TextEditingController();
  final _passtextController = TextEditingController();
  final _firstnameNode = FocusNode();
  final _lastnameNode = FocusNode();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();
  final _validator = Validator();
  bool _isObscure = true;

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
          FlatButton(
            color: Colors.green,
            onPressed: () {
              Navigator.of(context).pushNamed(ProfileRegPage.id);
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
        ],
      ),
    );
  }
}
