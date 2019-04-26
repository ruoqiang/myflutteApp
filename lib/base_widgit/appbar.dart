import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget  {
  final String title;
  final bool isHasBackBtn;
  MyAppBar({this.title,this.isHasBackBtn});
  Widget build(BuildContext context) {
    return SafeArea(
        child:Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: 51,
                alignment: Alignment.center,
                color: Color(0xff2D4ED1),
                child: Text(title,style: TextStyle(fontSize: 22,color: Colors.white),),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: GestureDetector(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 55,
                    height: 51,
                    child: isHasBackBtn?Icon(Icons.arrow_back,color:Colors.white,) : null,
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}