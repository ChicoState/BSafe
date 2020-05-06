import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference groupsCollection = Firestore.instance.collection('groups');

  Future updateUserData(String name, String group) async {
    return await groupsCollection.document(uid).setData({
      'name': name,
      'group': group,
    });
  }
}