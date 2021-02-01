import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:xopinionx/ui/screens/register_page/bloc/register_bloc.dart';
import 'package:xopinionx/ui/screens/register_page/register_page_desktop.dart';
import 'package:xopinionx/ui/screens/register_page/register_page_mobile.dart';

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
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        bool _isMobile = sizingInformation.isMobile ? true : false;
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
            return ScreenTypeLayout(
              mobile: RegisterPageMobile(),
              desktop: RegisterPageDesktop(),
            );
          },
        );
      },
    );
  }
}
