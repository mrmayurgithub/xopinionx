import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/screens/home_page/bloc/home_page_bloc.dart';
import 'package:xopinionx/ui/screens/home_page/home_page_desktop.dart';
import 'package:xopinionx/ui/screens/home_page/home_page_mobile.dart';
import 'package:xopinionx/ui/screens/register_page/register_page.dart';

class HomePage extends StatelessWidget {
  static const String id = "home_page";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: HomePageMainBody(),
    );
  }
}

class HomePageMainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return BlocConsumer<HomePageBloc, HomePageState>(
          listener: (context, state) async {
            if (state is HomePageInitial) {}
            if (state is HomePageLoaded) {}
            if (state is HomePageProgress) {}
            if (state is BlogPageLoaded) {}
            if (state is LoginPageLoaded) {}
            if (state is SignUpPageLoaded) {
              logger.i('SignUpPage Loading');
              Navigator.of(context).pushNamed(RegisterPage.id);
            }
            if (state is DonationPageLoaded) {}
            if (state is HomePageFailure) {}
          },
          builder: (context, state) {
            return ScreenTypeLayout(
              mobile: HomePageMobile(),
              desktop: HomePageDesktop(),
              tablet: HomePageDesktop(),
            );
          },
        );
      },
    );
  }
}
