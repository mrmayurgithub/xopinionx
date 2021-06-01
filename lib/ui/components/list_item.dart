// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:xopinionx/ui/components/color.dart';
// import 'package:xopinionx/ui/components/spacing.dart';
// import 'package:xopinionx/ui/components/typography.dart';

// class ListItem extends StatelessWidget {
//   // TODO replace with Post item model.
//   final String title;
//   final String description;

//   const ListItem({Key key, @required this.title, this.description}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Container(
//             margin: marginBottom12,
//             child: Text(
//               title,
//               style: headlineTextStyle,
//             ),
//           ),
//         ),
//         if (description != null)
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Container(
//               margin: marginBottom12,
//               child: Text(
//                 description,
//                 style: bodyTextStyle,
//               ),
//             ),
//           ),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Container(
//             margin: marginBottom24,
//             child: ReadMoreButton(
//               onPressed: () {},
//               // onPressed: () => Navigator.pushNamed(context, Routes.post),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ReadMoreButton extends StatelessWidget {
//   final Function onPressed;

//   const ReadMoreButton({Key key, @required this.onPressed}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool hover = false;
//     return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
//       return MouseRegion(
//         onHover: (event) => setState(() => hover = true),
//         onExit: (event) => setState(() => hover = false),
//         child: OutlineButton(
//           onPressed: onPressed,
//           highlightedBorderColor: textPrimary,
//           hoverColor: textPrimary,
//           borderSide: BorderSide(color: textPrimary, width: 2),
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Text(
//             "READ MORE",
//             style: GoogleFonts.montserrat(
//               textStyle: TextStyle(fontSize: 14, color: hover ? Colors.white : textPrimary, letterSpacing: 1),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
