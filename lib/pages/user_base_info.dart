import 'package:flutter/material.dart';

class UserBaseInfoPage extends StatefulWidget {
  @override
  _UserBaseInfoState createState() => _UserBaseInfoState();
}

class _UserBaseInfoState extends State<UserBaseInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My searchPage')),
      body: Center(
        child: FlatButton(
          child: Text('POP-返回'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
