import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:xopinionx/auth/auth_bloc.dart';
import 'package:xopinionx/global/bloc_observer.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/screens/ask_query_page/ask_query_page.dart';
import 'package:xopinionx/ui/screens/donation_page/donation_page.dart';
import 'package:xopinionx/ui/screens/history_page/history_page.dart';
import 'package:xopinionx/ui/screens/home_page/home_page.dart';
import 'package:xopinionx/ui/screens/login_page/login_page.dart';
import 'package:xopinionx/ui/screens/profile_page/profile_page.dart';
import 'package:xopinionx/ui/screens/register_page/providers.dart';
import 'package:xopinionx/ui/screens/register_page/register_page.dart';
import 'package:xopinionx/ui/screens/see_problems_page/see_problems.dart';
import 'package:xopinionx/ui/screens/user_home_page/user_home_page.dart';
import 'package:xopinionx/ui/screens/verification_page/verification_page.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
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

class MainAppWithTheme extends StatefulWidget {
  @override
  _MainAppWithThemeState createState() => _MainAppWithThemeState();
}

class _MainAppWithThemeState extends State<MainAppWithTheme> {
  @override
  void initState() {
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
          );
        }
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<TagsProvider>.value(
            value: TagsProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Opinionx',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: 'Open Sans',
                ),
          ),
          builder: (context, widget) {
            return ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget),
              maxWidth: 1920,
              minWidth: 480,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(480, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
              background: Container(
                color: Color(0xFFF5F5F5),
              ),
            );
          },
          routes: {
            LoginPage.id: (context) => LoginPage(),
            RegisterPage.id: (context) => RegisterPage(),
            VerificationPage.id: (context) => VerificationPage(),
            SeeProblemsPage.id: (context) => SeeProblemsPage(),
            DonationPage.id: (context) => DonationPage(),
            HomePage.id: (context) => HomePage(),
            HistoryPage.id: (context) => HistoryPage(),
            ProfilePage.id: (context) => ProfilePage(),
            UserHomePage.id: (context) => UserHomePage(),
            AskQueryPage.id: (context) => AskQueryPage(),
          },
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              initializeUtils(context);
              if (state is AuthUnInitialized)
                return HomePage();
              else if (state is AuthUnAuthenticated)
                return HomePage();
              else if (state is AuthAuthenticated) {
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
      ),
    );
  }
}
