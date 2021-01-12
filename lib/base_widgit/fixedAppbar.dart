import 'package:flutter/material.dart';

//Widget fixedAppbar(title) {
//    return AppBar(
//              title: Text(title,style: TextStyle(color: Colors.white),),
//              backgroundColor:  Color(0xff2D4ED1),
//              iconTheme: IconThemeData(color: Colors.white),
//              centerTitle:true,
//    );
//  }

class fixedAppbar extends StatelessWidget implements PreferredSizeWidget {

  final title;
  fixedAppbar({this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,style: TextStyle(color: Colors.white),),
      backgroundColor:  Color(0xff2D4ED1),
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40);
}