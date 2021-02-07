import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/ui/components/customFormField.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/screens/complete_profile_page/bloc/complete_profile_bloc.dart';

class ProfileRegPage extends StatelessWidget {
  static const String id = "profile_reg_page";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteProfileBloc(),
      child: CompleteProfileMainBody(),
    );
  }
}

class CompleteProfileMainBody extends StatefulWidget {
  @override
  _CompleteProfileMainBodyState createState() => _CompleteProfileMainBodyState();
}

class _CompleteProfileMainBodyState extends State<CompleteProfileMainBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteProfileBloc, CompleteProfileState>(
      listener: (context, state) {
        if (state is CompleteProfileInitial) {}
        if (state is CompleteProfileInProgress) {}
        if (state is CompleteProfileSuccess) {}
        if (state is CompleteProfileFailed) {}
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
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
                      child: ProfileCompleteForm(),
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

class ProfileCompleteForm extends StatefulWidget {
  @override
  _ProfileCompleteFormState createState() => _ProfileCompleteFormState();
}

class _ProfileCompleteFormState extends State<ProfileCompleteForm> {
  GlobalKey _formkey = GlobalKey<ScaffoldState>();
  final _eduYearTextController = TextEditingController();
  final _eduYearNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
          items: [
            DropdownMenuItem(
              child: Text('School Student'),
            ),
            DropdownMenuItem(
              child: Text('College Student'),
            ),
            DropdownMenuItem(
              child: Text('Professional'),
            ),
          ],
          onChanged: (value) {},
          // decoration: InputDecoration(
          //   enabledBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(15),
          //     borderSide: BorderSide(
          //       color: Colors.green,
          //       width: 5.0,
          //     ),
          //   ),
          // ),
        ),
        SizedBox(height: screenHeight * 0.024459975), // 22

        TextFormField(),
        SizedBox(height: screenHeight * 0.024459975), // 22

        DropdownButtonFormField(
          items: [
            DropdownMenuItem(
              child: Text('English'),
            ),
            DropdownMenuItem(
              child: Text('Hindi'),
            ),
            DropdownMenuItem(
              child: Text('German'),
            ),
            DropdownMenuItem(
              child: Text('Spanish'),
            ),
          ],
          onChanged: (value) {},
        ),
      ],
    );
  }
}
