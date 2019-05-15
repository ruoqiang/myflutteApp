import 'package:flutter/material.dart';

Widget fixedAppbar(title) {
    return AppBar(
              title: Text(title,style: TextStyle(color: Colors.white),),
              backgroundColor:  Color(0xff2D4ED1),
              iconTheme: IconThemeData(color: Colors.white),
              centerTitle:true,
    );
  }