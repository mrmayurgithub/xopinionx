import 'package:flutter/material.dart';
import 'package:xopinionx/ui/global/constants.dart';

class ReportContent extends StatefulWidget {
  @override
  _ReportContentState createState() => _ReportContentState();
}

class _ReportContentState extends State<ReportContent> {
  int grVal;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        color: kSecondaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              RadioListTile<int>(
                value: 0,
                groupValue: grVal,
                onChanged: (val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: const Text('Violent or repulsive'),
              ),
              RadioListTile<int>(
                value: 1,
                groupValue: grVal,
                onChanged: (val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: const Text('Hateful or abusive'),
              ),
              RadioListTile<int>(
                value: 2,
                groupValue: grVal,
                onChanged: (val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: const Text('Harmful or dangerous'),
              ),
              RadioListTile<int>(
                value: 3,
                groupValue: grVal,
                onChanged: (val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: const Text('Adult content'),
              ),
              RadioListTile<int>(
                value: 4,
                groupValue: grVal,
                onChanged: (val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: const Text('Spam or misleading'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Report'),
        ),
      ],
    );
  }
}
