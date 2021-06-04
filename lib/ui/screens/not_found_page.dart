import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SelectableText(
                  "404",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SelectableText(
                  "We can't find the page you're looking for.",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
