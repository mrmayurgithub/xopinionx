import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:xopinionx/ui/components/custom_autosizetext.dart';
import 'package:xopinionx/ui/components/rounded_button.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/screens/home_page/home_page.dart';

class RegisterPageDesktop extends StatefulWidget {
  @override
  _RegisterPageDesktopState createState() => _RegisterPageDesktopState();
}

class _RegisterPageDesktopState extends State<RegisterPageDesktop> {
  GlobalKey<ScaffoldState> _formKey;
  @override
  Widget build(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(HomePage.id);
    return Scaffold(
      appBar: PreferredSize(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: FlatButton(
                  onPressed: () {
                    // Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed(HomePage.id);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.connect_without_contact_outlined),
                      Text('Opinionx'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text('Already have an account ?'),
                    FlatButton(
                      onPressed: () {},
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(50),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
