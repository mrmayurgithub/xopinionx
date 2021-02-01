import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/ui/components/home_navigation_bar.dart/home_navigation_bar.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/screens/home_page/bloc/home_page_bloc.dart';
import 'package:xopinionx/ui/screens/home_page/home_centered_view.dart';
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

// class HomePageMainBody extends StatelessWidget {
//   Color _color1 = Color.fromARGB(255, 9, 220, 129);
//   Color _color2 = Color.fromARGB(255, 255, 107, 74);
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveBuilder(
//       builder: (context, sizingInformation) {
//         return BlocConsumer<HomePageBloc, HomePageState>(
//           listener: (context, state) async {
//             if (state is HomePageInitial) {}
//             if (state is HomePageLoaded) {}
//             if (state is HomePageProgress) {}
//             if (state is BlogPageLoaded) {}
//             if (state is LoginPageLoaded) {}
//             if (state is SignUpPageLoaded) {}
//             if (state is DonationPageLoaded) {}
//             if (state is HomePageFailure) {}
//           },
//           builder: (context, state) {
//             bool isMobile =
//                 sizingInformation.deviceScreenType == DeviceScreenType.mobile;
//             return Scaffold(
//               appBar: AppBar(
//                 elevation: 1,
//                 leading: Icon(
//                   Icons.connect_without_contact_outlined,
//                   color: Colors.black,
//                 ),
//                 backgroundColor: _color1,
//                 title: Text(
//                   'OPINIONX',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Open Sans',
//                   ),
//                 ),
//                 actions: isMobile
//                     ? null
//                     : [
//                         FlatButton(
//                           child: Text('HOME'),
//                           onPressed: () {},
//                         ),
//                         FlatButton(
//                           child: Text('BLOG'),
//                           onPressed: () {},
//                         ),
//                         FlatButton(
//                           child: Text('DONATE'),
//                           onPressed: () {},
//                         ),
//                       ],
//               ),
//               body: SingleChildScrollView(
//                 child: Wrap(
//                   children: [
//                     Stack(
//                       children: [
//                         ClipPath(
//                           clipper: WaveClipperOne(),
//                           child: Container(
//                             height: 600,
//                             color: _color1,
//                           ),
//                         ),
//                         Wrap(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.symmetric(vertical: 20),
//                               child: Image.asset(
//                                 'assets/images/home_page_images/1.png',
//                                 width: screenWidth / 2,
//                                 height: screenHeight / 2,
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Container(
//                                 color: _color2,
//                                 height: 300,
//                                 width: 300,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

class HomePageMainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        bool _isMobile = sizingInformation.isMobile ? true : false;
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
