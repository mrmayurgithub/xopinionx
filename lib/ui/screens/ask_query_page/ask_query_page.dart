import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/global/enums.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/components/customFormField.dart';
import 'package:xopinionx/ui/components/drawer.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/screens/ask_query_page/bloc/ask_query_bloc.dart';
import 'package:xopinionx/config/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class AskQueryPage extends StatelessWidget {
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
          context.vxNav.clearAndPush(Uri.parse(MainRoutes.userHomeRoute));
        }
        if (state is AskQueryCancelled) {
          context.vxNav.pop();
        }
        if (state is AskQueryFailure) {
          context.vxNav.pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          drawer: MainDrawer(),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: kMaxWidth / 2,
                    padding: const EdgeInsets.all(kDefaultPadding),
                    constraints: const BoxConstraints(maxWidth: kMaxWidth),
                    child: QueryForm(),
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

List<DropdownMenuItem<Tags>> dropdownMenuItems = [
  const DropdownMenuItem<Tags>(
    value: Tags.timemanagement,
    child: Text('Time Management'),
  ),
  const DropdownMenuItem<Tags>(
    value: Tags.coding,
    child: Text('Coding'),
  ),
  const DropdownMenuItem<Tags>(
    value: Tags.interview,
    child: Text('Interview'),
  ),
  const DropdownMenuItem<Tags>(
    value: Tags.internship,
    child: Text('Internship'),
  ),
  const DropdownMenuItem<Tags>(
    value: Tags.projects,
    child: Text('Projects'),
  ),
  const DropdownMenuItem<Tags>(
    value: Tags.collegeadmission,
    child: Text('College Admission'),
  ),
  const DropdownMenuItem<Tags>(
    value: Tags.boards,
    child: Text('Boards'),
  ),
  const DropdownMenuItem<Tags>(
    value: Tags.career,
    child: Text('Career'),
  ),
  // DropdownMenuItem<String>(
  //   child: Text('Branch Selection'),
  //   value: 'branchselection',
  // ),
  const DropdownMenuItem<Tags>(
    value: Tags.abroadinternship,
    child: Text('Abroad Internship'),
  ),
  const DropdownMenuItem<Tags>(
    value: Tags.higherstudies,
    child: Text('HigerStudies'),
  ),
  const DropdownMenuItem<Tags>(
    value: Tags.productivity,
    child: Text('Productivity'),
  ),
  const DropdownMenuItem<Tags>(
    value: Tags.motivation,
    child: Text('Motivation'),
  ),
];

class QueryForm extends StatefulWidget {
  @override
  _QueryFormState createState() => _QueryFormState();
}

class _QueryFormState extends State<QueryForm> {
  final _formkey = GlobalKey<FormState>();
  final _problemTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final FocusNode _problemNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  Tags _tag;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('About your Query'),
          SizedBox(height: screenHeight * 0.024459975), // 22
          _CustomTextFormField(
            currentNode: _problemNode,
            fieldController: _problemTextController,
            hintText: 'Title for your problem',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (_) {
              if (_problemTextController.text.length <= 10) {
                return 'The problem title must be atlease 10 characters long';
              } else {
                return null;
              }
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
              if (_descriptionTextController.text.length <= 80) {
                return 'The description should consist of 80 characters or more';
              } else {
                return null;
              }
            },
            maxLines: 5,
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          DropdownButtonFormField<Tags>(
            value: _tag,
            decoration: InputDecoration(
              labelText: 'Select a tag',
              hintText: 'Select a Tag',
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (Tags value) {
              setState(() {
                _tag = value;
              });
            },
            items: dropdownMenuItems,
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
            child: const Padding(
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
          ),
        ],
      ),
    );
  }
}

class _CustomTextFormField extends StatelessWidget {
  const _CustomTextFormField({
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
