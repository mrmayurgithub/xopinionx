import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:xopinionx/ui/components/custom_autosizetext.dart';
import 'package:xopinionx/ui/components/rounded_button.dart';
import 'package:xopinionx/ui/global/utils.dart';

class HomePageDesktop extends StatefulWidget {
  @override
  _HomePageDesktopState createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  Color _color1 = Color.fromARGB(255, 9, 220, 129);
  Color _color2 = Color.fromARGB(255, 255, 107, 74);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        child: Stack(
          children: [
            Image.asset(
              'images/home_page_images/5.png',
              width: screenWidth,
              height: screenHeight,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.connect_without_contact_outlined,
                          color: Colors.green,
                        ),
                        Text(
                          'OpinionX',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        children: [
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
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        preferredSize: Size.fromHeight(50),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 117, 221, 131),
              height: screenHeight / 1.8,
              child: Padding(
                padding: EdgeInsets.only(top: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'images/home_page_images/1.png',
                      width: screenWidth / 2.5,
                      height: screenHeight / 2.5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAutoSizeText(
                          width: 500,
                          title: '​You have some doubts?\nAnd want genuine opinions?\nWe provide a safe place for you to have one on one discussions with experienced seniors!',
                          fontSize: 35,
                          maxLines: 10,
                        ),
                        RoundedButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//        body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(10),
//                       child: Image.asset(
//                         'assets/images/home_page_images/1.png',
//                         width: screenWidth / 3,
//                         height: screenHeight / 3,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CustomAutoSizeText(
//                             width: screenWidth / 3.5,
//                             title: "You have some doubts?\nAnd want genuine opinions?\nWe provide a safe place for you to have one on one discussions with experienced seniors!",
//                             fontSize: screenWidth / 55,
//                             maxLines: 7,
//                           ),
//                           SizedBox(height: 20),
//                           RoundedButton(
//                             onPressed: () {},
//                             title: 'Get Started',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             WhyOpinionx(),
//           ],
//         ),
//       ),
//     );
//   }
// }
class WhyOpinionx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAutoSizeText(
                width: screenWidth / 4,
                title: 'Why Opinionx',
                fontSize: screenWidth / 35,
                maxLines: 1,
              ),
            ],
          ),
          Image.asset(
            'assets/images/home_page_images/3.png',
            width: screenWidth / 5,
          ),
        ],
      ),
    );
  }
}
