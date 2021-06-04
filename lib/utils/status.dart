import 'package:firebase_auth/firebase_auth.dart';

bool isLoggedIn() {
  final _currentUser = FirebaseAuth.instance.currentUser;
  return _currentUser != null;
}
