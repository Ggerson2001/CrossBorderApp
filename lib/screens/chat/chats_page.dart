import 'package:cross_border/services/auth.dart';
import 'package:flutter/material.dart';

import 'chat.dart';
import 'custom_app_bar.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Chat"),
      body: Chat(
        key: UniqueKey(),
        email: AuthService().getEmail(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey[700],
        items: [
          BottomNavigationBarItem(
            label: "Information",
            icon: Icon(
              Icons.info_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(
              Icons.search,
            ),
          ),
          BottomNavigationBarItem(
            label: "Messages",
            icon: Icon(
              Icons.message,
            ),
          ),
        ],
      ),
    );
  }
}
