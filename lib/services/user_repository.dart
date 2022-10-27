import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_border/models/student.dart';

class UserRepository {
  static final users = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(ModelUser user) async {
    await users.doc(user.uuid).set(user.toJson());
  }

  Future<ModelUser> getUser(String uuid) async {
    final doc = await users.doc(uuid).get();
    return ModelUser.fromJson(doc.data());
  }

  Future<ModelUser> getChatTester() async {
    final docs =
        await users.where("email", isEqualTo: "chat_tester@email.ru").get();

    return ModelUser.fromJson(docs.docs.first.data());
  }

  Future<void> updateUser(ModelUser user) async {
    await users.doc(user.uuid).update(user.toJson());
  }
}
