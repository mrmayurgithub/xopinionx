//TODO: Complete
import 'package:xopinionx/api/functions/problem_functions.dart';
import 'package:xopinionx/api/functions/user_functions.dart';
import 'package:xopinionx/api/models/problem_model.dart';
import 'package:xopinionx/api/models/user_model.dart';

Future<void> _initializeApi() async {
  await loadCurrentUser();
  await loadUserProblems();
  await loadApplicationsForProblem();
  await loadGlobalProblems();
  await loadUserApplications();
  await loadHistory();
}

Future<void> loadCurrentUser() async {
  _globalUser = await UserFunctions.getCurrentUser();
}

//TODO: Maybe sort by tags
Future<void> loadUserProblems() async {
  _userProblemsList = await ProblemFunctions.getUserProblems();
}

Future<void> loadApplicationsForProblem() async {}
Future<void> loadGlobalProblems() async {}
Future<void> loadUserApplications() async {}
Future<void> loadHistory() async {}

UserModel _globalUser = UserModel();
List<ProblemModel> _userProblemsList = [];
// List<ApplicationModel> _userApplications = [];
// List<ApplicationModel> _applicationsForProblem = [];
List<ProblemModel> _globalProblemsList = [];
// List<ApplicationModel> _historyList = [];

UserModel get globalUser => _globalUser;
List<ProblemModel> get userProblemsList => _userProblemsList;
// List<ApplicationModel> get userApplications => _userApplications;
// List<ApplicationModel> get applicationsForProblem => _applicationsForProblem;
List<ProblemModel> get globalProblemsList => _globalProblemsList;
// List<ApplicationModel> get historyList => _historyList;
Future<void> get initializeApi => _initializeApi();
