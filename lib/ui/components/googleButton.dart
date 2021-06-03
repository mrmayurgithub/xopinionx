import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:xopinionx/ui/global/utils.dart';

class GoogleButton extends StatelessWidget {
  final Callback onPressed;
  final String title;
  const GoogleButton({@required this.title, @required this.onPressed})
      : assert(onPressed != null),
        assert(title != null);
  @override
  Widget build(BuildContext context) {
    return Material(
      // borderRadius: ,
      color: Colors.transparent,
      elevation: 2.0,
      shadowColor: Colors.grey[400].withOpacity(0.2),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          elevation: 0.0,
          // padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01500953), // 13.5
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Colors.grey[500].withOpacity(0.5),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(
            //   'assets/logo/google.svg',
            //   alignment: Alignment.center,
            //   fit: BoxFit.contain,
            //   height: screenWidth * 0.068055556, // 28
            //   width: screenWidth * 0.068055556, // 28
            // ),

            SizedBox(
              width: screenWidth * 0.051041667, // 21
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
