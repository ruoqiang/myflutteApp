import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp/pages/details_page.dart';
import 'package:myflutterapp/pages/login.dart';
import '../routers/application.dart';
import 'package:myflutterapp/base_widgit/appbar.dart';

class ForgetPage extends StatefulWidget {
  @override
  _ForgetState createState() => _ForgetState();
}

class _ForgetState extends State<ForgetPage> {
  var tipsText = '';
  var isOpen = false;
  var pressAttention = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
          constraints: BoxConstraints(minHeight: 500),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                MyAppBar(title:'忘记密码',isHasBackBtn:true),
                createMyInput('images/login_icon_phone.png',"请输入手机号",false),
                Stack(
                  children: <Widget>[
                    createMyInput('images/login_icon_code.png',"请输入密码",isOpen),
                    Positioned(
                      top:-5,
                      right: 20,
                      child: InkWell(
                        onTap: (){
                          print('ddddd');
                          setState(() {
                            isOpen = !isOpen;
                          });
                        },
                        child: Container(
                          width: 55,
                          height: 60,
                          padding: EdgeInsets.only(left: 15,right: 15,top:10,bottom: 0),
                          color: Colors.transparent,
                          child: Image.asset(isOpen?'images/login_icon_close.png':'images/login_icon_open.png',width:25,color: Color(0xff2D4ED1),fit: BoxFit.fitWidth,),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    createMyInput('images/login_register_icon_verification.png',"请输入密码",false),
                    Positioned(
                      top:3,
                      right: 20,
                      child: InkWell(
                        onTap: (){
                          print('ddddd');
                          setState(() {
                            isOpen = !isOpen;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration:BoxDecoration(
                            border:Border(left: BorderSide(width: 0.8,color: Color(0xff2D4ED1))), //底部border
                            color: Colors.white
                          ),
                          height: 45,
                          padding: EdgeInsets.only(left: 15,right: 15,top:0,bottom: 0),
                          child: Container(
                            child: Text('获取验证码',style: TextStyle(color: Color(0xff2D4ED1)),),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 40,
                            child: RaisedButton(
                                disabledTextColor:Color(0xff2D4ED1),
                            highlightColor:Color(0xff2D4ED1), //Color(0xff2D4ED1),
                              splashColor:Color(0xff2D4ED1),
                              onPressed: (){
                                setState(() => pressAttention = !pressAttention);
                              },
                              textColor:pressAttention ? Colors.white : Color(0xff2D4ED1),
                              child: Text("确认"),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child:Row(
                    children: <Widget>[
                      Expanded(child:
                      Container(
                        height: 38,
                        child: OutlineButton(
                          borderSide: BorderSide(
                            color: Color(0xff2D4ED1), //Color of the border
                            style: BorderStyle.solid, //Style of the border
                            width: 0.8, //width of the border
                          ),
                          highlightColor:Color(0xff2D4ED1) ,
                          splashColor:Color(0xff2D4ED1), //点击水波
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
//                            Navigator.pushNamed(context, "router/login_page");
//                            Application.router.navigateTo(context,"/login_page");
                          },
                          color: Color(0xff2D4ED1),
                          textColor:Color(0xff2D4ED1),
                          child: Text("已有账号，去登录"),
                        ),
                      )
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
       );
  }

  Widget createMyInput(iconString,placeholder,isPassword) {

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
