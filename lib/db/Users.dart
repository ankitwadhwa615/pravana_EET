import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pravana_eet/models/user.dart';
class UserServices {
  String user = "users";
  String collection = "users";
  Firestore _firestore = Firestore.instance;
  String ref= 'user';

  Future<List<DocumentSnapshot>> getUser() =>
      _firestore.collection(ref).getDocuments().then((snaps) {
        return snaps.documents;
      });

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).document(id).get().then((doc){
        return UserModel.fromSnapshot(doc);
      });
}




