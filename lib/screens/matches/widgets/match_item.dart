import 'package:cross_border/screens/inbox/inbox_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../matches_page.dart';

class MatchItem extends StatelessWidget {
  MatchItemData data;
  Function callback;

  final dbRef = FirebaseDatabase.instance.reference();

  MatchItem(
    this.callback,
    this.data,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text("Do you wan to match with ${data.name}?"),
            actions: [
              TextButton(
                onPressed: () async {
                  await dbRef
                      .child("match_making")
                      .child(DateTime.now().microsecondsSinceEpoch.toString())
                      .set({
                    "old_student_id": data.user.id,
                    "status": "pending",
                    "student_id": "thesmalldeal",
                  });

                  Navigator.pop(context);
                  callback();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => InboxPage()),
                  );
                },
                child: Text(
                  "Yes",
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "No",
                ),
              ),
            ],
          );
        },
      ),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            // color: Colors.red,
            ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              data.imageUrl,
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  Spacer(),
                  Text(
                    data.job,
                  ),
                  Spacer(),
                  Text(
                    "Match score: ${data.matchScore}%",
                  ),
                  Text(
                    "Personal score: ${data.personalScore}%",
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 25),
              child: Image.network(
                "https://lothiancatrescue.org/wp-content/uploads/2018/01/005-hand-shake.png",
                height: 45,
                width: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
