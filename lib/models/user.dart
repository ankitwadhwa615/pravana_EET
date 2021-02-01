import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NAME = 'username';
  static const EMAIL = "email";
  static const ID = 'id';

  String _name;
  String _email;
  String _id;
//  GETTERS
  String get name => _name;
  String get email => _email;
  String get id => _id;

  UserModel.fromSnapshot(DocumentSnapshot snap) {
    try {
      _email = snap.data[EMAIL];
      _name = snap.data[NAME];
      _id = snap.data[ID];
    } catch (e) {
      print(e);
    }
  }
}
