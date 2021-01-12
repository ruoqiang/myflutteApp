
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
showToast (msg,{backgroundColor=Colors.black54,time=1}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: time,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0
      );
}