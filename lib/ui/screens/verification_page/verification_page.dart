import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xopinionx/ui/components/showProgress.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/screens/verification_page/bloc/verification_bloc.dart';
import 'package:xopinionx/utils/navigations.dart';
import 'package:xopinionx/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class VerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => VerificationBloc()
          ..add(const VerificationInitiated(isFirstTime: true)),
        child: VerificationMainBody(),
      ),
    );
  }
}

class VerificationMainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _onConfirmButtonPressed() {
      BlocProvider.of<VerificationBloc>(context)
          .add(const VerificationInitiated());
    }

    void _onResendButtonPressed() {
      BlocProvider.of<VerificationBloc>(context).add(ResendVerificationMail());
    }

    return BlocConsumer<VerificationBloc, VerificationState>(
      listener: (context, state) {
        if (state is VerificationFailed) {
          // Navigator.of(context).pop();
          context.vxNav.pop();
          Fluttertoast.showToast(msg: state.message);
        }
        if (state is VerificationSuccess) {
          Fluttertoast.showToast(msg: 'Verification Successful');
          //TODO: check
          // Navigator.of(context).popUntil((route) => route.isFirst);
          context.vxNav.popToRoot();
          // Navigator.of(context).pushReplacementNamed(ProfileRegPage.id);
          // Navigator.of(context).pushReplacementNamed(MainRoutes.userHomeRoute);
          pNavigator(context, MainRoutes.userHomeRoute);
        }
        if (state is VerificationInProgress) {
          showProgress(context);
        }
        if (state is ResendVerification) {
          //check
          context.vxNav.pop();
          // Navigator.of(context).pop();
          BlocProvider.of<VerificationBloc>(context)
              .add(const VerificationInitiated());
        }
      },
      builder: (context, state) {
        return Center(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.072916667), // 30
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  height: screenHeight * 0.222363405, // 200
                  child: const CircularProgressIndicator(),
                ),
                SizedBox(height: screenHeight * 0.044472681), // 40
                Text(
                  "Waiting for Verification",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: screenHeight * 0.03001906, // 27
                      ),
                ),
                SizedBox(height: screenHeight * 0.03001906), // 27
                Text(
                  "A verification email has been sent to your email",
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontSize: screenHeight * 0.015565438, // 14
                      ),
                ),
                Text(
                  "Verify by clicking on the link provided",
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontSize: screenHeight * 0.015565438, // 14
                      ),
                ),
                SizedBox(height: screenHeight * 0.050031766), // 45
                TextButton(
                  onPressed: _onConfirmButtonPressed,
                  child: const Text('Confirm Verification'),
                ),
                TextButton(
                  onPressed: _onResendButtonPressed,
                  child: const Text('Resend Verification Link'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
