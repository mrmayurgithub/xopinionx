import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:xopinionx/auth/auth_bloc.dart';
import 'package:xopinionx/global/bloc_observer.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/global/theme/bloc/theme_bloc.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/screens/ask_query_page/ask_query_page.dart';
import 'package:xopinionx/ui/screens/chats_page/chats_screen.dart';
import 'package:xopinionx/ui/screens/donation_page/donation_page.dart';
import 'package:xopinionx/ui/screens/history_page/history_page.dart';
import 'package:xopinionx/ui/screens/home_page/home_page.dart';
import 'package:xopinionx/ui/screens/login_page/login_page.dart';
import 'package:xopinionx/ui/screens/profile_page/profile_page.dart';
import 'package:xopinionx/ui/screens/register_page/providers.dart';
import 'package:xopinionx/ui/screens/register_page/register_page.dart';
import 'package:xopinionx/ui/screens/settings_page/settings_page.dart';
import 'package:xopinionx/ui/screens/user_home_page/user_home_page.dart';
import 'package:xopinionx/ui/screens/user_queries/user_queries.dart';
import 'package:xopinionx/ui/screens/verification_page/verification_page.dart';
import 'package:xopinionx/utils/routes.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc()..add(AppStarted()),
      child: App(),
    ),
  );
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
        return BlocProvider(
          create: (context) => ThemeBloc(),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) => MainAppWithTheme(
              context: context,
              state: state,
            ),
          ),
        );
      },
    );
  }
}

class MainAppWithTheme extends StatefulWidget {
  final BuildContext context;
  final ThemeState state;

  const MainAppWithTheme({
    Key key,
    this.context,
    this.state,
  }) : super(key: key);

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
        // child: MaterialApp(
        //   title: 'Opinionx',
        //   debugShowCheckedModeBanner: false,
        //   theme: widget.state.appThemeData,
        //   builder: (context, widget) {
        //     return ResponsiveWrapper.builder(
        //       BouncingScrollWrapper.builder(context, widget),
        //       maxWidth: 1920,
        //       minWidth: 480,
        //       defaultScale: true,
        //       breakpoints: [
        //         ResponsiveBreakpoint.resize(480, name: MOBILE),
        //         ResponsiveBreakpoint.autoScale(800, name: TABLET),
        //         ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        //         ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        //       ],
        //       background: Container(
        //         color: Color(0xFFF5F5F5),
        //       ),
        //     );
        //   },
        //   routes: <String, WidgetBuilder>{
        //     MainRoutes.loginRoute: (context) => LoginPage(),
        //     MainRoutes.registerRoute: (context) => RegisterPage(),
        //     MainRoutes.verificationRoute: (context) => VerificationPage(),
        //     MainRoutes.donationRoute: (context) => DonationPage(),
        //     MainRoutes.homePageRoute: (context) => HomePage(),
        //     MainRoutes.historyRoute: (context) => HistoryPage(),
        //     MainRoutes.profileRoute: (context) => ProfilePage(),
        //     MainRoutes.userHomeRoute: (context) => UserHomePage(),
        //     MainRoutes.askQueryRoute: (context) => AskQueryPage(),
        //     MainRoutes.settingsRoute: (context) => SettingsPage(),
        //     MainRoutes.chatRoute: (context) => ChatPage(),
        //     MainRoutes.userQueries: (context) => UserQueries(),
        //   },
        //   home: BlocBuilder<AuthBloc, AuthState>(
        //     builder: (context, state) {
        //       initializeUtils(context);
        //       if (state is AuthUnInitialized)
        //         return HomePage();
        //       else if (state is AuthUnAuthenticated)
        //         return HomePage();
        //       else if (state is AuthAuthenticated) {
        //         return UserHomePage();
        //       } else if (state is AuthNeedsVerification)
        //         return VerificationPage();
        //       else if (state is AuthNeedsProfileComplete)
        //         return ProfilePage();
        //       else
        //         return SafeArea(
        //           child: Scaffold(
        //             body: Center(
        //               child: CircularProgressIndicator(),
        //             ),
        //           ),
        //         );
        //     },
        //   ),
        // ),
        child: BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
          child: MaterialApp.router(
            title: 'Opinionx',
            debugShowCheckedModeBanner: false,
            theme: widget.state.appThemeData,
            routeInformationParser: VxInformationParser(),
            routerDelegate: VxNavigator(
              routes: {
                '/': (_, __) => MaterialPage(child: HomePage()),
                MainRoutes.homePageRoute: (_, __) => MaterialPage(child: HomePage()),
                MainRoutes.loginRoute: (_, __) => MaterialPage(child: LoginPage()),
                MainRoutes.registerRoute: (_, __) => MaterialPage(child: RegisterPage()),
                MainRoutes.verificationRoute: (_, __) => MaterialPage(child: VerificationPage()),
                MainRoutes.donationRoute: (_, __) => MaterialPage(child: DonationPage()),
                MainRoutes.historyRoute: (_, __) => MaterialPage(child: HistoryPage()),
                MainRoutes.profileRoute: (_, __) => MaterialPage(child: ProfilePage()),
                MainRoutes.userHomeRoute: (_, __) => MaterialPage(child: UserHomePage()),
                MainRoutes.askQueryRoute: (_, __) => MaterialPage(child: AskQueryPage()),
                MainRoutes.settingsRoute: (_, __) => MaterialPage(child: SettingsPage()),
                MainRoutes.chatRoute: (_, __) => MaterialPage(child: ChatPage()),
                MainRoutes.userQueries: (_, __) => MaterialPage(child: UserQueries()),
              },
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

            // home: BlocBuilder<AuthBloc, AuthState>(
            //   builder: (context, state) {
            //     initializeUtils(context);
            //     if (state is AuthUnInitialized)
            //       return HomePage();
            //     else if (state is AuthUnAuthenticated)
            //       return HomePage();
            //     else if (state is AuthAuthenticated) {
            //       return UserHomePage();
            //     } else if (state is AuthNeedsVerification)
            //       return VerificationPage();
            //     else if (state is AuthNeedsProfileComplete)
            //       return ProfilePage();
            //     else
            //       return SafeArea(
            //         child: Scaffold(
            //           body: Center(
            //             child: CircularProgressIndicator(),
            //           ),
            //         ),
            //       );
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}

// class BaseState extends StatefulWidget {
//   @override
//   _BaseStateState createState() => _BaseStateState();
// }

// class _BaseStateState extends State<BaseState> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         initializeUtils(context);
//       },
//     );
//   }
// }
