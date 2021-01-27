import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xopinionx/api/models/application_model.dart';

class ApplicationFunctions {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> addApplicationToProblem({ApplicationModel applicationModel}) async {
    //TODO: update in both global problems
    final _doclistQuerySnapshot = await _firestore.collection('problems').where('problemId', isEqualTo: applicationModel.problemId).get();
    final _docList = _doclistQuerySnapshot.docs;
    final _data = _docList[0];
  }

  static Future<List<ApplicationModel>> getUserApplications() async {}

  static Future<List<ApplicationModel>> getApplicationsForProblem() async {}

  static Future<void> deleteApplicationFromProblem({ApplicationModel applicationModel}) async {
    //TODO: update in both global problems
  }
}
