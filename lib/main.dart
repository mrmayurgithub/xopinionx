import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xopinionx/api/functions/problem_functions.dart';
import 'package:xopinionx/api/models/problem_model.dart';
import 'package:xopinionx/auth/auth_bloc.dart';
import 'package:xopinionx/global/bloc_observer.dart';
import 'package:xopinionx/global/enums.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/components/googleButton.dart';
import 'package:xopinionx/ui/global/theme/bloc/theme_bloc.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/screens/complete_profile_page/complete_profile.dart';
import 'package:xopinionx/ui/screens/donation_page/donation_page.dart';
import 'package:xopinionx/ui/screens/history_page/history_page.dart';
import 'package:xopinionx/ui/screens/home_page/home_page.dart';
import 'package:xopinionx/ui/screens/login_page/login_page.dart';
import 'package:xopinionx/ui/screens/profile_page/profile_page.dart';
import 'package:xopinionx/ui/screens/register_page/register_page.dart';
import 'package:xopinionx/ui/screens/see_problems_page/see_problems.dart';
import 'package:xopinionx/ui/screens/user_home_page/user_home_page.dart';
import 'package:xopinionx/ui/screens/verification_page/verification_page.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(App());
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('ERROR');
        }
        return BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AppStarted()),
          child: MainAppWithTheme(),
        );
      },
    );
  }
}

// class OpinionxApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ThemeBloc(),
//       child: BlocBuilder<ThemeBloc, ThemeState>(
//         builder: (context, state) => MainAppWithTheme(
//           context: context,
//           state: state,
//         ),
//       ),
//     );
//   }
// }

class MainAppWithTheme extends StatefulWidget {
  // const MainAppWithTheme({
  //   Key key,
  //   @required this.context,
  //   @required this.state,
  // }) : super(key: key);

  // final BuildContext context;
  // final ThemeState state;
  @override
  _MainAppWithThemeState createState() => _MainAppWithThemeState();
}

class _MainAppWithThemeState extends State<MainAppWithTheme> {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  @override
  void initState() {
    _analytics.logAppOpen().then((_) => logger.v("AnalyticsEvent: AppStarted"));
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthUnAuthenticated) {
          logger.d('state is AuthUnAuthenticated');
          if (state.justLoggedOut) {
            logger.d('Just logged out');
          }
        }
        if (state is AuthFailure) {
          Fluttertoast.showToast(
            msg: state.message,
            textColor: Theme.of(context).textTheme.bodyText2.color,
            backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).backgroundColor : Colors.grey[800],
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 4,
            // fontSize: screenHeight * 0.01511817,
          );
        }
      },
      child: MaterialApp(
        title: 'Opinionx',
        debugShowCheckedModeBanner: false,
        // theme: widget.state.appThemeData,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Open Sans',
              ),
        ),
        navigatorObservers: [FirebaseAnalyticsObserver(analytics: _analytics)],
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          VerificationPage.id: (context) => VerificationPage(),
          ProfileRegPage.id: (context) => ProfileRegPage(),
          SeeProblemsPage.id: (context) => SeeProblemsPage(),
          DonationPage.id: (context) => DonationPage(),
          HomePage.id: (context) => HomePage(),
          HistoryPage.id: (context) => HistoryPage(),
          ProfilePage.id: (context) => ProfilePage(),
          UserHomePage.id: (context) => UserHomePage(),
        },
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            initializeUtils(context);
            if (state is AuthUnInitialized)
              return HomePage();
            else if (state is AuthUnAuthenticated)
              return HomePage();
            else if (state is AuthAuthenticated) {
              _analytics.logEvent(name: "user_home_page_loaded");
              return UserHomePage();
            } else if (state is AuthNeedsVerification)
              return VerificationPage();
            else if (state is AuthNeedsProfileComplete)
              return ProfilePage();
            else
              return SafeArea(
                child: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(App());
// }

// class App extends StatelessWidget {
//   // Create the initialization Future outside of `build`:
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     // initializeUtils(context);
//     return FutureBuilder(
//       // Initialize FlutterFire:
//       future: _initialization,
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           return Text('ERROR');
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//             textTheme: Theme.of(context).textTheme.apply(
//                   fontFamily: 'Open Sans',
//                 ),
//           ),
//           home: Appkk(),
//         );
//       },
//     );
//   }
// }

// class Appkk extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     initializeUtils(context);
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Center(
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('OpinionX'),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text('Home'),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Text('Donate'),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Text('Settings'),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
