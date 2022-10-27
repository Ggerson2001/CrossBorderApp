import 'package:cross_border/models/student.dart';
import 'package:cross_border/screens/inbox/inbox_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecipientItem extends StatelessWidget {
  RecipientItemData data;

  RecipientItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          // color: Colors.red,
          ),
      child: Row(
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
            padding: const EdgeInsets.all(3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Status: ${data.status}"),
                Text(
                  "Date: ${DateFormat('dd-MM-yyyy').format(data.date)}",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
