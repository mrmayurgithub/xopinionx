import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:xopinionx/config/theme/bloc/theme_bloc.dart';
import 'package:xopinionx/core/auth/auth_bloc.dart';
import 'package:xopinionx/global/bloc_observer.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/screens/ask_query_page/ask_query_page.dart';
import 'package:xopinionx/ui/screens/chats_page/chat_provider.dart';
import 'package:xopinionx/ui/screens/chats_page/chats_screen.dart';
import 'package:xopinionx/ui/screens/donation_page/donation_page.dart';
import 'package:xopinionx/ui/screens/history_page/history_page.dart';
import 'package:xopinionx/ui/screens/home_page/home_page.dart';
import 'package:xopinionx/ui/screens/login_page/login_page.dart';
import 'package:xopinionx/ui/screens/not_found_page.dart';
import 'package:xopinionx/ui/screens/profile_page/profile_page.dart';
import 'package:xopinionx/ui/screens/register_page/providers.dart';
import 'package:xopinionx/ui/screens/register_page/register_page.dart';
import 'package:xopinionx/ui/screens/settings_page/settings_page.dart';
import 'package:xopinionx/ui/screens/user_home_page/user_home_page.dart';
import 'package:xopinionx/ui/screens/user_queries/user_queries.dart';
import 'package:xopinionx/ui/screens/verification_page/verification_page.dart';
import 'package:xopinionx/config/routes.dart';

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
          return const Text('ERROR');
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
  final _navigator = VxNavigator(
    notFoundPage: (uri, params) => const MaterialPage(
      key: ValueKey("not-found-page"),
      child: NotFoundPage(),
    ),
    routes: {
      '/': (_, __) => MaterialPage(child: HomePage()),
      MainRoutes.homePageRoute: (_, __) => MaterialPage(child: HomePage()),
      MainRoutes.loginRoute: (_, __) =>
          VxRoutePage(pageName: "LoginPage", child: LoginPage()),
      MainRoutes.registerRoute: (_, __) =>
          VxRoutePage(pageName: "Resgisterpage", child: RegisterPage()),
      MainRoutes.verificationRoute: (_, __) =>
          MaterialPage(child: VerificationPage()),
      MainRoutes.donationRoute: (_, __) =>
          VxRoutePage(pageName: "DonationPage", child: DonationPage()),
      MainRoutes.historyRoute: (_, __) =>
          VxRoutePage(pageName: "HistoryPage", child: HistoryPage()),
      MainRoutes.profileRoute: (_, __) =>
          VxRoutePage(pageName: "ProfilePage", child: ProfilePage()),
      MainRoutes.userHomeRoute: (_, __) =>
          VxRoutePage(pageName: "UserHomePage", child: UserHomePage()),
      MainRoutes.askQueryRoute: (_, __) =>
          VxRoutePage(pageName: "AskQueryPage", child: AskQueryPage()),
      MainRoutes.settingsRoute: (_, __) =>
          VxRoutePage(pageName: "SettingsPage", child: SettingsPage()),
      MainRoutes.chatRoute: (_, __) =>
          VxRoutePage(pageName: "ChatPage", child: ChatPage()),
      MainRoutes.userQueries: (_, __) =>
          VxRoutePage(pageName: "UserQueries", child: UserQueries()),
    },
  );

  @override
  Widget build(BuildContext context) {
    _navigator.addListener(() {
      logger.wtf(_navigator.currentConfiguration.path);
    });
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
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                // ? Theme.of(context).backgroundColor
                ? kSecondaryColor
                : Colors.grey[800],
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
          ChangeNotifierProvider<ChatSelectionProvider>.value(
            value: ChatSelectionProvider(),
          ),
        ],
        child: BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
          child: GetMaterialApp.router(
            title: 'Opinionx',
            debugShowCheckedModeBanner: false,
            // theme: widget.state.appThemeData,
            theme: ThemeData.dark(),
            routeInformationParser: VxInformationParser(),
            routerDelegate: _navigator,
            builder: (context, widget) {
              return ResponsiveWrapper.builder(
                BouncingScrollWrapper.builder(context, widget),
                maxWidth: 1920,
                minWidth: 480,
                defaultScale: true,
                breakpoints: [
                  const ResponsiveBreakpoint.resize(480, name: MOBILE),
                  const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
                background: Container(
                  color: const Color(0xFFF5F5F5),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// // // // child: MaterialApp(
// // // //   title: 'Opinionx',
// // // //   debugShowCheckedModeBanner: false,
// // // //   theme: widget.state.appThemeData,
// // // //   builder: (context, widget) {
// // // //     return ResponsiveWrapper.builder(
// // // //       BouncingScrollWrapper.builder(context, widget),
// // // //       maxWidth: 1920,
// // // //       minWidth: 480,
// // // //       defaultScale: true,
// // // //       breakpoints: [
// // // //         ResponsiveBreakpoint.resize(480, name: MOBILE),
// // // //         ResponsiveBreakpoint.autoScale(800, name: TABLET),
// // // //         ResponsiveBreakpoint.resize(1200, name: DESKTOP),
// // // //         ResponsiveBreakpoint.autoScale(2460, name: "4K"),
// // // //       ],
// // // //       background: Container(
// // // //         color: Color(0xFFF5F5F5),
// // // //       ),
// // // //     );
// // // //   },
// // // //   routes: <String, WidgetBuilder>{
// // // //     MainRoutes.loginRoute: (context) => LoginPage(),
// // // //     MainRoutes.registerRoute: (context) => RegisterPage(),
// // // //     MainRoutes.verificationRoute: (context) => VerificationPage(),
// // // //     MainRoutes.donationRoute: (context) => DonationPage(),
// // // //     MainRoutes.homePageRoute: (context) => HomePage(),
// // // //     MainRoutes.historyRoute: (context) => HistoryPage(),
// // // //     MainRoutes.profileRoute: (context) => ProfilePage(),
// // // //     MainRoutes.userHomeRoute: (context) => UserHomePage(),
// // // //     MainRoutes.askQueryRoute: (context) => AskQueryPage(),
// // // //     MainRoutes.settingsRoute: (context) => SettingsPage(),
// // // //     MainRoutes.chatRoute: (context) => ChatPage(),
// // // //     MainRoutes.userQueries: (context) => UserQueries(),
// // // //   },
// // // //   home: BlocBuilder<AuthBloc, AuthState>(
// // // //     builder: (context, state) {
// // // //       initializeUtils(context);
// // // //       if (state is AuthUnInitialized)
// // // //         return HomePage();
// // // //       else if (state is AuthUnAuthenticated)
// // // //         return HomePage();
// // // //       else if (state is AuthAuthenticated) {
// // // //         return UserHomePage();
// // // //       } else if (state is AuthNeedsVerification)
// // // //         return VerificationPage();
// // // //       else if (state is AuthNeedsProfileComplete)
// // // //         return ProfilePage();
// // // //       else
// // // //         return SafeArea(
// // // //           child: Scaffold(
// // // //             body: Center(
// // // //               child: CircularProgressIndicator(),
// // // //             ),
// // // //           ),
// // // //         );
// // // //     },
// // // //   ),
// // // // ),

// // // // home: BlocBuilder<AuthBloc, AuthState>(
// // // //   builder: (context, state) {
// // // //     initializeUtils(context);
// // // //     if (state is AuthUnInitialized)
// // // //       return HomePage();
// // // //     else if (state is AuthUnAuthenticated)
// // // //       return HomePage();
// // // //     else if (state is AuthAuthenticated) {
// // // //       return UserHomePage();
// // // //     } else if (state is AuthNeedsVerification)
// // // //       return VerificationPage();
// // // //     else if (state is AuthNeedsProfileComplete)
// // // //       return ProfilePage();
// // // //     else
// // // //       return SafeArea(
// // // //         child: Scaffold(
// // // //           body: Center(
// // // //             child: CircularProgressIndicator(),
// // // //           ),
// // // //         ),
// // // //       );
// // // //   },
// // // // ),
