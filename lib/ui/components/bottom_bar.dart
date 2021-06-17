import 'package:flutter/material.dart';
import 'package:xopinionx/config/responsive.dart';
import 'package:xopinionx/ui/global/constants.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 100,
      ),
      decoration: BoxDecoration(color: kSecondaryColor),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment:
          //       isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       "Opinionx",
          //       style: TextStyle(
          //           color: kTextColor, fontSize: 23, letterSpacing: 1.1),
          //     ),
          //     SizedBox(
          //       height: kDefaultPadding / 4,
          //     ),
          //     Text(
          //       "​© Copyright OpinionX 2021",
          //       style: TextStyle(
          //           color: kTextColor, fontSize: 13, letterSpacing: 1.1),
          //     ),
          //   ],
          // ),
          Text(
            "​© Copyright OpinionX 2021",
            style:
                TextStyle(color: kTextColor, fontSize: 13, letterSpacing: 1.1),
          ),
          isMobile
              ? SizedBox(
                  height: kDefaultPadding / 4,
                )
              : SizedBox(
                  width: kDefaultPadding * 1.5,
                ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Privacy Policy",
              style: TextStyle(
                color: kTextColor,
                fontSize: 13,
                decoration: TextDecoration.underline,
                letterSpacing: 1.1,
              ),
            ),
          ),
          isMobile
              ? SizedBox(
                  height: kDefaultPadding / 4,
                )
              : SizedBox(
                  width: kDefaultPadding,
                ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Terms of Service",
              style: TextStyle(
                color: kTextColor,
                fontSize: 13,
                decoration: TextDecoration.underline,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
