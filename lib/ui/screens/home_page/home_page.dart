import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/screens/home_page/bloc/home_page_bloc.dart';
import 'package:xopinionx/ui/screens/home_page/home_page_desktop.dart';
import 'package:xopinionx/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeUtils(context);
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: HomePageMainBody(),
    );
  }
}

class HomePageMainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: (context, state) async {
        if (state is HomePageInitial) {}
        if (state is HomePageLoaded) {}
        if (state is HomePageProgress) {
          showProgress(context);
        }
        if (state is BlogPageLoaded) {}
        if (state is LoginPageLoaded) {
          context.vxNav.push(Uri.parse(MainRoutes.loginRoute));
        }
        if (state is SignUpPageLoaded) {
          logger.i('SignUpPage Loading');
          context.vxNav.push(Uri.parse(MainRoutes.registerRoute));
        }
        if (state is DonationPageLoaded) {}
        if (state is HomePageFailure) {
          context.vxNav.pop();
          Fluttertoast.showToast(msg: "HomePage Error: ${state.message}");
          logger.wtf(state.message);
        }
      },
      builder: (context, state) {
        return HomePageDesktop();
      },
    );
  }
}
