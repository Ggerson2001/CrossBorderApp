import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_border/models/message.dart';

class ChatRepository {
  final List<String> companions;
  final String senderEmail;

  final messagesColl = FirebaseFirestore.instance.collection('messages');

  Stream messages;

  ChatRepository({this.companions, this.senderEmail}) {
    messages = messagesColl
        .orderBy("createdAt", descending: true)
        .where("companions", arrayContainsAny: [senderEmail]).snapshots();
  }

  Future<void> sendMessage(String text) async {
    await messagesColl.add(
      MessageModel(
        createdAt: DateTime.now(),
        companions: companions,
        senderEmail: senderEmail,
        text: text,
      ).toJson(),
    );
  }
}
