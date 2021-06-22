//TODO: Complete
//TODO: Compplete
import 'package:xopinionx/core/api/functions/problem_functions.dart';
import 'package:xopinionx/core/api/functions/user_functions.dart';
import 'package:xopinionx/core/api/models/problem_model.dart';
import 'package:xopinionx/core/api/models/user_model.dart';

Future<void> _initializeApi() async {
  await loadCurrentUser();
}

Future<void> loadCurrentUser() async {
  _globalUser = await UserFunctions.getCurrentUser();
}

Future<void> _disposeApi() async {
  _globalProblemsList = [];
  _globalUser = null;
}

Future<void> loadGlobalProblems() async {
  _globalProblemsList = await ProblemFunctions.getGlobalProblems();
}

UserModel _globalUser = UserModel();
List<ProblemModel> _globalProblemsList = [];

UserModel get globalUser => _globalUser;
List<ProblemModel> get globalProblemsList => _globalProblemsList;
Future<void> get initializeApi => _initializeApi();
Future<void> get disposeApi => _disposeApi();
