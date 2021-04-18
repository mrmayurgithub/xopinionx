import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/screens/home_page/bloc/home_page_bloc.dart';
import 'package:xopinionx/ui/screens/home_page/home_page_desktop.dart';
import 'package:xopinionx/ui/screens/home_page/home_page_mobile.dart';
import 'package:xopinionx/ui/screens/login_page/login_page.dart';
import 'package:xopinionx/ui/screens/register_page/register_page.dart';
import 'package:xopinionx/utils/routes.dart';

class HomePage extends StatelessWidget {
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
            if (state is HomePageProgress) {
              showProgress(context);
            }
            if (state is BlogPageLoaded) {}
            if (state is LoginPageLoaded) {
              Navigator.of(context).pushNamed(MainRoutes.loginRoute);
            }
            if (state is SignUpPageLoaded) {
              logger.i('SignUpPage Loading');
              Navigator.of(context).pushNamed(MainRoutes.registerRoute);
            }
            if (state is DonationPageLoaded) {}
            if (state is HomePageFailure) {
              Navigator.of(context).pop();
              Fluttertoast.showToast(msg: "HomePage Error: " + state.message);
              logger.wtf(state.message);
            }
          },
          builder: (context, state) {
            return ScreenTypeLayout(
              mobile: HomePageDesktop(),
              desktop: HomePageDesktop(),
              tablet: HomePageDesktop(),
            );
          },
        );
      },
    );
  }
}
