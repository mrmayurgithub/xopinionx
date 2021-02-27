import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/components/customFormField.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/screens/ask_query_page/bloc/ask_query_bloc.dart';
import 'package:xopinionx/ui/screens/user_home_page/user_home_page.dart';

class AskQueryPage extends StatelessWidget {
  static const id = "ask_query_page";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AskQueryBloc(),
      child: AskQueryMainBody(),
    );
  }
}

class AskQueryMainBody extends StatefulWidget {
  @override
  _AskQueryMainBodyState createState() => _AskQueryMainBodyState();
}

class _AskQueryMainBodyState extends State<AskQueryMainBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AskQueryBloc, AskQueryState>(
      listener: (context, state) {
        if (state is AskQueryInitial) {}
        if (state is AskQueryInProgress) {
          showProgress(context);
        }
        if (state is AskQueryPostedSuccess) {
          logger.i('Success: Query Posted');
          Navigator.of(context).pushReplacementNamed(UserHomePage.id);
        }
        if (state is AskQueryCancelled) {}
        if (state is AskQueryFailure) {}
      },
      builder: (context, state) {
        return Scaffold(
          // appBar: AppBar(
          //   automaticallyImplyLeading: false,

          // ),
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
                      child: QueryForm(),
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

class QueryForm extends StatefulWidget {
  @override
  _QueryFormState createState() => _QueryFormState();
}

class _QueryFormState extends State<QueryForm> {
  final _formkey = GlobalKey<FormState>();
  final _problemTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  FocusNode _problemNode = FocusNode();
  FocusNode _descriptionNode = FocusNode();
  String _tag;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          Text('About your Query'),
          SizedBox(height: screenHeight * 0.024459975), // 22
          _CustomTextFormField(
            currentNode: _problemNode,
            fieldController: _problemTextController,
            hintText: 'Title for your problem',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (_) {
              if (_problemTextController.text.length <= 30) {
                return 'The problem title must be atlease 30 characters long';
              } else
                return null;
            },
            maxLines: 1,
            nextNode: _descriptionNode,
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          _CustomTextFormField(
            fieldController: _descriptionTextController,
            hintText: 'Description of your problem',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (_) {
              if (_descriptionTextController.text.length <= 150) {
                return 'The description should consist of 150 characters or more';
              } else
                return null;
            },
            maxLines: 5,
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          DropdownButtonFormField(
            value: _tag,
            decoration: InputDecoration(
              labelText: 'Select a tag',
              hintText: 'Select a Tag',
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _tag = value;
              });
            },
            items: [
              DropdownMenuItem<String>(
                child: Text('Time Management'),
                value: 'timemanagement',
              ),
              DropdownMenuItem<String>(
                child: Text('Coding'),
                value: 'coding',
              ),
              DropdownMenuItem<String>(
                child: Text('Interview'),
                value: 'interview',
              ),
              DropdownMenuItem<String>(
                child: Text('Internship'),
                value: 'internship',
              ),
              DropdownMenuItem<String>(
                child: Text('Projects'),
                value: 'projects',
              ),
              DropdownMenuItem<String>(
                child: Text('College Admission'),
                value: 'collegeadmission',
              ),
              DropdownMenuItem<String>(
                child: Text('Boards'),
                value: 'boards',
              ),
              DropdownMenuItem<String>(
                child: Text('Career'),
                value: 'career',
              ),
              // DropdownMenuItem<String>(
              //   child: Text('Branch Selection'),
              //   value: 'branchselection',
              // ),
              DropdownMenuItem<String>(
                child: Text('Abroad Internship'),
                value: 'abroadinternship',
              ),
              DropdownMenuItem<String>(
                child: Text('HigerStudies'),
                value: 'higherstudies',
              ),
              DropdownMenuItem<String>(
                child: Text('Productivity'),
                value: 'productivity',
              ),
              DropdownMenuItem<String>(
                child: Text('Motivation'),
                value: 'motivation',
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22

          FlatButton(
            color: Colors.green,
            onPressed: () {
              if (_formkey.currentState.validate()) {
                logger.d('Query Validated');
                BlocProvider.of<AskQueryBloc>(context).add(
                  QuerySubmitButtonPressed(
                    problem: _problemTextController.text,
                    description: _descriptionTextController.text,
                    tag: _tag,
                  ),
                );
              } else {
                logger.d('Wrong Query');
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 120,
              ),
              child: Text(
                'Submit',
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

class _CustomTextFormField extends StatelessWidget {
  _CustomTextFormField({
    @required TextEditingController fieldController,
    @required String hintText,
    @required TextInputType keyboardType,
    FocusNode currentNode,
    FocusNode nextNode,
    bool obscureText,
    bool enabled,
    Widget suffix,
    TextCapitalization textCapitalization,
    List<TextInputFormatter> inputFormatters,
    @required TextInputAction textInputAction,
    @required String Function(String) validator,
    @required int maxLines,
  })  : _fieldController = fieldController,
        _hintText = hintText,
        _currentNode = currentNode,
        _nextNode = nextNode,
        _textInputAction = textInputAction,
        _keyboardType = keyboardType,
        _obscureText = obscureText,
        _validator = validator,
        _maxLines = maxLines,
        _suffix = suffix,
        _textCapitalization = textCapitalization,
        _inputFormatters = inputFormatters,
        _enabled = enabled;

  final TextEditingController _fieldController;
  final String _hintText;
  final TextInputType _keyboardType;
  final bool _obscureText;
  final String Function(String) _validator;
  final int _maxLines;
  final bool _enabled;
  final Widget _suffix;
  final TextInputAction _textInputAction;
  final FocusNode _currentNode;
  final FocusNode _nextNode;
  final List<TextInputFormatter> _inputFormatters;
  final TextCapitalization _textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _currentNode,
      onFieldSubmitted: (value) {
        if (_currentNode != null) {
          _currentNode.unfocus();
          FocusScope.of(context).requestFocus(_nextNode);
        }
      },
      textInputAction: _textInputAction,
      enabled: _enabled ?? true,
      maxLines: _maxLines,
      controller: _fieldController,
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: _keyboardType,
      obscureText: _obscureText ?? false,
      validator: _validator,
      textCapitalization: _textCapitalization ?? TextCapitalization.none,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.caption.copyWith(
            fontSize: screenHeight * 0.015565438, // 14
          ),
      inputFormatters: _inputFormatters,
      decoration: InputDecoration(
        suffixIcon: _suffix,
        border: kInputBorderStyle,
        focusedBorder: kInputBorderStyle,
        enabledBorder: kInputBorderStyle,
        hintStyle: Theme.of(context).textTheme.caption.copyWith(
              fontSize: screenHeight * 0.015565438, // 14
            ),
        // contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036458333, vertical: screenHeight * 0.021124524), // h=15, v=19
        hintText: _hintText,
      ),
    );
  }
}
