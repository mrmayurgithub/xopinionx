import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:xopinionx/api/functions/problem_functions.dart';
import 'package:xopinionx/api/functions/user_functions.dart';
import 'package:xopinionx/api/models/problem_model.dart';
import 'package:xopinionx/api/models/user_model.dart';
import 'package:xopinionx/global/enums.dart';
import 'package:xopinionx/global/logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('ERROR');
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: 'Open Sans',
                ),
          ),
          home: Scaffold(
            body: Center(
              child: FlatButton(
                color: Colors.grey,
                onPressed: () {
                  logger.i('pushing');
                  return ProblemFunctions.createProblem(
                    problem: ProblemModel(
                      userId: 'sss',
                      problemDescription: 'ddd',
                      problemTitle: 'ddd',
                      datePosted: 'dd',
                      status: true,
                      tag: Tags.Electrial,
                    ),
                  );
                },
                child: Text('Upload'),
              ),
            ),
          ),
        );
      },
    );
  }
}
