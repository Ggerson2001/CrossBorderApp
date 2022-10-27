import 'package:cross_border/screens/inbox/inbox_page.dart';
import 'package:cross_border/screens/matches/widgets/match_item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MatchesPage extends StatefulWidget {
  @override
  _MatchesPageState createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  var urls = [
    "https://jooinn.com/images/girl-162.jpg",
    "https://pbs.twimg.com/profile_images/1056420148792451072/FtkakMWV.jpg",
  ];

  final dbRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        leading: Icon(
          Icons.arrow_back,
        ),
        title: Text(
          "Match with a buddy",
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => InboxPage())),
            child: Icon(
              Icons.move_to_inbox_rounded,
              size: 30,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
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
                      !matches.any((element) =>
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
                  return MatchItem(
                    () => setState(() {}),
                    MatchItemData(
                      user: users[index],
                      name: users[index].name,
                      imageUrl:
                          "https://static10.tgstat.ru/channels/_0/d8/d868e9a5916239dd46ba6ef66a8d9809.jpg",
                      job: users[index].role,
                      matchScore: 100,
                      personalScore: 90,
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

class MatchMakingModel {
  String status;
  String studentId;
  String oldStudentId;

  MatchMakingModel({
    this.oldStudentId,
    this.status,
    this.studentId,
  });
}

class MatchUser {
  String name;
  String role;
  String id;
  String status;

  MatchUser({
    this.name,
    this.role,
    this.id,
    this.status,
  });
}

class MatchItemData {
  MatchUser user;
  int matchScore;
  int personalScore;
  String imageUrl;
  String job;
  String jobExperience;
  String name;

  MatchItemData({
    this.imageUrl,
    this.matchScore,
    this.personalScore,
    this.job,
    this.jobExperience,
    this.name,
    this.user,
  });
}
