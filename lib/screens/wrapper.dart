import 'package:cross_border/models/student.dart';
import 'package:cross_border/screens/authenticate/authenticate.dart';
import 'package:cross_border/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ModelUser>(context);
    print(user);

    //return Home or Authenticate Widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
