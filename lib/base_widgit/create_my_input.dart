import 'package:flutter/material.dart';

class CreateMyInput extends StatelessWidget {
  final iconString;
  final placeholder;
  final isPassword;
  final inputController;

  // const CreateMyInput(
  //     {Key key,
  //     @required this.iconString,
  //     @required this.placeholder,
  //     @required this.isPassword,
  //     @required this.inputController})
  //     : super(key: key);
CreateMyInput({this.iconString,this.placeholder,this.isPassword,this.inputController});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0,5,15.0,5),
      child: Row(
        children: <Widget>[
          Image.asset(iconString,width: 25,color:Color(0xff2D4ED1)),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15),
                decoration:BoxDecoration(
                  border:Border(bottom: BorderSide(width: 0.8,color: Color(0xff2D4ED1))), //底部border
                ),
              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: TextField(
                controller: inputController,
                decoration: InputDecoration(
                  hintText: placeholder,
                  contentPadding: EdgeInsets.fromLTRB(0, 17, 15, 15), //输入框内容部分设置padding，跳转跟icon的对其位置
                  border:InputBorder.none,
                ),
                obscureText: isPassword, //是否是以星号*显示密码
              ),
            ),
          )
        ],
      ),
    );
  }
}