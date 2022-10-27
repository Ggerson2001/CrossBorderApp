import 'package:cross_border/screens/chat/custom_app_bar.dart';
import 'package:cross_border/screens/inbox/widgets/recipient_item.dart';
import 'package:cross_border/screens/matches/matches_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class InboxPage extends StatelessWidget {
  var urls = [
    "https://static10.tgstat.ru/channels/_0/d8/d868e9a5916239dd46ba6ef66a8d9809.jpg",
    "https://jooinn.com/images/girl-162.jpg",
    "https://pbs.twimg.com/profile_images/1056420148792451072/FtkakMWV.jpg",
  ];

  final dbRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        "Inbox",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: Future.wait([
            dbRef.child("users").once(),
            dbRef.child("match_making").once(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> data = snapshot.data[0].value;
              Map<dynamic, dynamic> data1 = snapshot.data[1].value;

              List<MatchUser> users = [];
              List<MatchMakingModel> matches = [];

              if (data1 != null) {
                matches = data1.values
                    .map<MatchMakingModel>((e) => MatchMakingModel(
                          oldStudentId: e["old_student_id"],
                          status: e["status"],
                          studentId: e["student_id"],
                        ))
                    .toList();
              }

              if (data != null) {
                data.forEach((key, value) {
                  if (value["role"] == "old_student" &&
                      matches.any((element) =>
                          element.studentId == "thesmalldeal" &&
                          element.oldStudentId == key))
                    users.add(MatchUser(
                      id: key,
                      name: value["name"],
                      role: value["role"],
                    ));
                });
              }

              return ListView.separated(
                itemCount: users.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 8,
                  );
                },
                itemBuilder: (context, index) {
                  return RecipientItem(
                    RecipientItemData(
                      user: users[index],
                      name: users[index].name,
                      imageUrl:
                          "https://static10.tgstat.ru/channels/_0/d8/d868e9a5916239dd46ba6ef66a8d9809.jpg",
                      job: users[index].role,
                      matchScore: 100,
                      personalScore: 90,
                      date: DateTime.now(),
                      status: "pending",
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class RecipientItemData {
  int matchScore;
  int personalScore;
  DateTime date;
  String status;
  String imageUrl;
  String job;
  String name;
  MatchUser user;

  RecipientItemData({
    this.date,
    this.imageUrl,
    this.matchScore,
    this.personalScore,
    this.status,
    this.job,
    this.name,
    this.user,
  });
}
