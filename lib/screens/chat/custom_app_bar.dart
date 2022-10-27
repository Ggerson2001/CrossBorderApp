import 'package:cross_border/services/auth.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      title: Text(title),
      actions: [
        Icon(
          Icons.people,
          size: 30,
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () => AuthService().signOut(),
          child: Icon(
            Icons.move_to_inbox_rounded,
            size: 30,
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
