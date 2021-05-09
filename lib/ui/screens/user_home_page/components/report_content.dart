import 'package:flutter/material.dart';

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
                title: Text('Violent or repulsive'),
              ),
              RadioListTile<int>(
                value: 1,
                groupValue: grVal,
                onChanged: (val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: Text('Hateful or abusive'),
              ),
              RadioListTile<int>(
                value: 2,
                groupValue: grVal,
                onChanged: (val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: Text('Harmful or dangerous'),
              ),
              RadioListTile<int>(
                value: 3,
                groupValue: grVal,
                onChanged: (val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: Text('Adult content'),
              ),
              RadioListTile<int>(
                value: 4,
                groupValue: grVal,
                onChanged: (val) {
                  setState(() {
                    grVal = val;
                  });
                },
                title: Text('Spam or misleading'),
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
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {},
          child: Text('Report'),
        ),
      ],
    );
  }
}
