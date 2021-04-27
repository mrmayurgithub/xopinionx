import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xopinionx/api/models/problem_model.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';

class ProblemFunctions {
  static final _firestore = FirebaseFirestore.instance;
  static Future<void> createProblem({ProblemModel problem}) async {
    //TODO: maybe also add to the local list for optimization and don't use await then
    final _docId = _firestore.collection('problems').doc().id;
    await _firestore.collection('problems').doc(_docId).set(
          ProblemModel(
            problemId: _docId,
            userId: problem.userId,
            problemTitle: problem.problemTitle,
            problemDescription: problem.problemDescription,
            datePosted: problem.datePosted,
            status: problem.status,
            tag: problem.tag,
          ).toJson(),
        );
  }

  static Future<List<ProblemModel>> getUserProblems() async {
    final _queryList = await _firestore.collection('problems').where('userId', isEqualTo: globalUser.id).get();
    final _docList = _queryList.docs;
    List<ProblemModel> _problemsList = [];
    for (var i = 0; i < _docList.length; i++) {
      _problemsList.add(ProblemModel.fromJson(_docList[i].data()));
    }
    return _problemsList;
  }

  static Future<void> finishProblem({ProblemModel problem}) async {
    //TODO: maybe update local list

    await _firestore.collection('problems').doc(problem.problemId).set({
      'id': problem.problemId,
      'userId': problem.userId,
      'problemTitle': problem.problemTitle,
      'problemDescription': problem.problemDescription,
      'datePosted': problem.datePosted,
      'status': true,
      'tag': problem.tag,
    });
  }

  static Future<void> deleteProblem({ProblemModel problem}) async {
    //TODO: maybe also delete from the local list or update the list
    await _firestore.collection('problems').doc(problem.problemId).delete();
  }

  static Future<List<ProblemModel>> getGlobalProblems() async {
    logger.i('GETGLOBALPROBLEMS: getting problems');
    List<ProblemModel> _problems = [];
    Query q = _firestore.collection('problems').limit(20);
    QuerySnapshot querySnapshot = await q.get();
    var _data = querySnapshot.docs;
    logger.e(_data.length);
    _data.forEach((element) {
      Map<String, dynamic> json = element.data();
      // logger.v(a);
      ProblemModel _problem = ProblemModel.fromJson(json);
      //TODO: complete
      for (var tag in globalUser.userTags) {
        if (tag.toString().toLowerCase() == _problem.tag.toString().toLowerCase()) {
          _problems.add(_problem);
        }
      }
      logger.d('PROBLEM: ${_problem.tag.toString()}');
    });

    logger.d('GETGLOBALPROBLEMS: ${_problems.length} ${globalUser.userTags.toString()}');

    return _problems;
  }

  static Future<List<ProblemModel>> againGetGlobalProblems() async {}
}
