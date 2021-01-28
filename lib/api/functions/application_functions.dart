import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xopinionx/api/models/application_model.dart';
import 'package:xopinionx/api/models/problem_model.dart';
import 'package:xopinionx/global/global_helpers.dart';

class ApplicationFunctions {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> addApplicationToProblem({ApplicationModel applicationModel}) async {
    //TODO: update in both global problems
    final _doclistQuerySnapshot = _firestore.collection('problems').doc(applicationModel.problemId);
    final _docId = _doclistQuerySnapshot.id;
    await _doclistQuerySnapshot.collection('applications').doc(_docId).set({
      'applicantViews': applicationModel.applicantViews,
      'problemId': applicationModel.problemId,
      'from': applicationModel.from,
      'applicationId': _docId,
    });

    final _queryList = _firestore.collection('users').doc(globalUser.id).collection('applications');
    await _queryList.doc(_docId).set({
      'applicantViews': applicationModel.applicantViews,
      'problemId': applicationModel.problemId,
      'from': applicationModel.from,
      'applicationId': _docId,
    });
  }

  static Future<List<ApplicationModel>> getUserApplications() async {
    final _queryList = await _firestore.collection('users').doc(globalUser.id).collection('applications').get();
    final _docList = _queryList.docs;
    List<ApplicationModel> _applicationsList = [];
    for (var doc in _docList) {
      _applicationsList.add(ApplicationModel.fromJson(doc.data()));
    }
    return _applicationsList;
  }

  static Future<List<ApplicationModel>> getApplicationsForProblem({ProblemModel problemModel}) async {
    final _queryList = _firestore.collection('problems').doc(problemModel.problemId);
    final _docList = await _queryList.collection('applications').get();
    final _mainList = _docList.docs;
    List<ApplicationModel> _applicationsList = [];
    for (var applc in _mainList) {
      _applicationsList.add(ApplicationModel.fromJson(applc.data()));
    }
    return _applicationsList;
  }

  static Future<void> deleteApplicationFromProblem({ApplicationModel applicationModel}) async {
    //TODO: update in both global problems
    await _firestore.collection('problems').doc(applicationModel.problemId).collection('applications').doc(applicationModel.applicationId).delete();
    await _firestore.collection('users').doc(globalUser.id).collection('applications').doc(applicationModel.applicationId).delete();
  }
}
