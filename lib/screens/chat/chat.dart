import 'package:cross_border/services/user_repository.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

class Chat extends StatelessWidget {
  final String email;

  UserRepository userRepository = UserRepository();

  Chat({
    Key key,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatPage(email),
        ),
      ),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.grey,
            ),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/7/73/Evagreen2_%283%29.jpg"),
                radius: 25,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rosanna",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
                // Text(
                //   "How are you?",
                // ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Text(
            //       "11:54 AM",
            //     ),
            //     SizedBox(
            //       height: 2,
            //     ),
            //     Text(
            //       "2",
            //     )
            //   ],
            // ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
