import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String text;
  final bool isMe;

  const Message(this.text, this.isMe);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (isMe)
          Padding(
            padding: EdgeInsets.only(
              right: 15,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 15,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        Container(
          width: 270,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topRight: isMe ? Radius.zero : Radius.circular(10),
              topLeft: isMe ? Radius.circular(10) : Radius.zero,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
