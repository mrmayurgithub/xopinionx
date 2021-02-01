import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:xopinionx/ui/components/custom_autosizetext.dart';
import 'package:xopinionx/ui/components/rounded_button.dart';
import 'package:xopinionx/ui/global/utils.dart';
import 'package:xopinionx/ui/screens/home_page/bloc/home_page_bloc.dart';

// class HomePageDesktop extends StatefulWidget {
//   @override
//   _HomePageDesktopState createState() => _HomePageDesktopState();
// }

// class _HomePageDesktopState extends State<HomePageDesktop> {
//   Color _color1 = Color.fromARGB(255, 9, 220, 129);
//   Color _color2 = Color.fromARGB(255, 255, 107, 74);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         leading: Icon(Icons.connect_without_contact_outlined),
//         title: Text('Opinionx'),
//         actions: [
//           Container(
//             child: Row(
//               children: [
//                 FlatButton(
//                   onPressed: () {},
//                   child: Text('Home'),
//                 ),
//                 FlatButton(
//                   onPressed: () {},
//                   child: Text('Blog'),
//                 ),
//                 FlatButton(
//                   onPressed: () {},
//                   child: Text('Donate'),
//                 ),
//                 SizedBox(width: 20),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(30.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Image.asset(
//                       'assets/images/home_page_images/1.png',
//                       width: screenWidth / 2.5,
//                       height: screenHeight / 2.5,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CustomAutoSizeText(
//                           width: screenWidth / 3.5,
//                           title: "You have some doubts?\nAnd want genuine opinions?\nWe provide a safe place for you to have one on one discussions with experienced seniors!",
//                           fontSize: screenWidth / 55,
//                           maxLines: 7,
//                         ),
//                         SizedBox(height: 20),
//                         RoundedButton(
//                           onPressed: () {},
//                           title: 'Get Started',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             WhyOpinionx(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class WhyOpinionx extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomAutoSizeText(
//                 width: screenWidth / 4,
//                 title: 'Why Opinionx',
//                 fontSize: screenWidth / 35,
//                 maxLines: 1,
//               ),
//               SizedBox(height: screenHeight / 25),
//               CustomAutoSizeText(
//                 width: screenWidth / 5,
//                 title:
//                     'There are various platforms to ask your doubts, queries, questions but you get very generalist solutions available for everyone in general but finding an ideal solution to your query or problem is difficult. That is why you need a one on one interaction. Here, we take time to listen to your problems and provide you with satisfactory solutions. ',
//                 fontSize: screenWidth / 80,
//                 maxLines: 10,
//               ),
//               CustomAutoSizeText(
//                 width: screenWidth / 4,
//                 title: 'Why Opinionx',
//                 fontSize: screenWidth / 35,
//                 maxLines: 1,
//               ),
//             ],
//           ),
//           Image.asset(
//             'assets/images/home_page_images/3.png',
//             width: screenWidth / 5,
//           ),
//         ],
//       ),
//     );
//   }
// }

class HomePageDesktop extends StatefulWidget {
  @override
  _HomePageDesktopState createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  @override
  Widget build(BuildContext context) {
    print(screenHeight);
    print(screenWidth);
    return AspectRatio(
      aspectRatio: 1920 / 1008,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: Color.fromARGB(255, 117, 221, 131),
          leading: Icon(Icons.connect_without_contact_outlined),
          title: Text('Opinionx'),
          actions: [
            FlatButton(
              onPressed: () {},
              child: Text('Home'),
            ),
            FlatButton(
              onPressed: () {},
              child: Text('Blog'),
            ),
            FlatButton(
              onPressed: () {},
              child: Text('Donate'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Color.fromARGB(255, 117, 221, 131),
                child: Padding(
                  padding: EdgeInsets.all(0.0198412698 * screenHeight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.00416666667 * screenWidth,
                          vertical: 0.00793650794 * screenHeight,
                        ),
                        child: Image.asset(
                          'images/home_page_images/1.png',
                          width: screenWidth / 2.7,
                          height: screenHeight / 2.7,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomAutoSizeText(
                            width: screenWidth / 3.7,
                            title: "You have some doubts?\nAnd want genuine opinions?\nWe provide a safe place for you to have one on one discussions with experienced seniors!",
                            fontSize: screenWidth / 55,
                            maxLines: 7,
                            color: Colors.white,
                          ),
                          SizedBox(height: 0.0198412698 * screenHeight),
                          RoundedButton(
                            onPressed: () {
                              BlocProvider.of<HomePageBloc>(context).add(SignUpPageRequested());
                            },
                            title: CustomAutoSizeText(
                              width: screenWidth / 8,
                              title: 'Get Started',
                              fontSize: screenWidth / 70,
                              maxLines: 2,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              CustomAutoSizeText(
                width: screenWidth / 4,
                title: 'Why OpinionX ?',
                fontSize: screenWidth / 45,
                maxLines: 2,
                color: Colors.green,
              ),
              SizedBox(height: 20),
              CustomAutoSizeText(
                // width: screenWidth / 4,
                width: screenWidth / 2,
                title:
                    'There are various platforms to ask your doubts, queries, questions but you get very generalised solutions available for everyone in general but finding an ideal solution to your query or problem is difficult. That is why you need a one on one interaction. Here, we take time to listen to your problems and provide you with satisfactory solutions. ',
                fontSize: screenWidth / 65,
                maxLines: 20,
                color: Colors.black,
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.all(10),
                child: CustomAutoSizeText(
                  width: screenWidth / 1.5,
                  title: 'Small Queries  +  Casual Discussion  =  6 Hours',
                  fontSize: screenWidth / 50,
                  maxLines: 3,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: CustomAutoSizeText(
                  width: screenWidth / 1.5,
                  title: '   Big Queries    +  Healthy Discussion   =  6 Minutes',
                  fontSize: screenWidth / 50,
                  maxLines: 3,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(20),
                child: RichText(
                  text: TextSpan(
                    text: 'A ',
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: screenWidth / 50,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      _darkTextSpan(text: 'Smart Man '),
                      _lightTextSpan(text: 'learns from '),
                      _darkTextSpan(text: 'their '),
                      _lightTextSpan(text: 'mistakes\nbut\na '),
                      _darkTextSpan(text: 'Wise Man '),
                      _lightTextSpan(text: 'learns from '),
                      _darkTextSpan(text: 'other\'s '),
                      _lightTextSpan(text: 'mistakes.'),
                    ],
                  ),
                ),
              ),
              //TODO: Complete
              //TODO: Complete
              //TODO: Complete
              //TODO: Complete
            ],
          ),
        ),
      ),
    );
  }

  TextSpan _lightTextSpan({@required String text}) {
    return TextSpan(
      text: text,
      style: TextStyle(
        letterSpacing: 2.0,
        color: Colors.lightGreen,
        fontSize: screenWidth / 50,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

TextSpan _darkTextSpan({@required String text}) {
  return TextSpan(
    text: text,
    style: TextStyle(
      letterSpacing: 2.0,
      color: Colors.green,
      fontSize: screenWidth / 50,
      fontWeight: FontWeight.bold,
    ),
  );
}
