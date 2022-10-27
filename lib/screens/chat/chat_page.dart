import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_border/models/message.dart';
import 'package:cross_border/services/auth.dart';
import 'package:cross_border/services/chat_repository.dart';
import 'package:cross_border/services/user_repository.dart';
import 'package:flutter/material.dart';

import 'custom_app_bar.dart';
import 'message.dart';

class ChatPage extends StatefulWidget {
  final String email;

  ChatPage(this.email);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatRepository chatRepository;
  TextEditingController textEditingController;

  final UserRepository userRepository = UserRepository();
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    chatRepository = ChatRepository(
      senderEmail: widget.email,
      companions: ["chat_tester@mail.ru", widget.email],
    );
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        "Messaging",
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey,
                ),
              ),
            ),
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: 7.5,
                ),
                Container(
                  width: 65,
                  height: 65,
                  child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/7/73/Evagreen2_%283%29.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Rosannne",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Software engineering",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: StreamBuilder<QuerySnapshot>(
                stream: chatRepository.messages,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  String myEmail = authService.getEmail();

                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  return ListView.separated(
                    reverse: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      final message = MessageModel.fromJson(
                          snapshot.data.docs[index].data()
                              as Map<String, dynamic>);
                      return Message(
                        message.text,
                        myEmail == message.senderEmail,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 100,
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Icon(
                  Icons.camera_alt,
                  color: Colors.blue,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 280,
                    height: 45,
                    child: TextField(
                      controller: textEditingController,
                      onSubmitted: (value) async {
                        textEditingController.text = "";
                        await chatRepository.sendMessage(value);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                        ),
                        hintText: "Say something...",
                        hintStyle: TextStyle(
                          color: Colors.blue.withOpacity(0.2),
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.blue.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    String buffer = textEditingController.text;
                    textEditingController.text = "";
                    await chatRepository.sendMessage(buffer);
                  },
                  child: Icon(
                    Icons.arrow_forward_sharp,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
