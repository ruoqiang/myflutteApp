
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
showToast (msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
        fontSize: 16.0
      );
}