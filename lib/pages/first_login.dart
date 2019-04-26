import 'package:flutter/material.dart';

class FirstLoginPage extends StatefulWidget {
  @override
  _FirstLoginState createState() => _FirstLoginState();
}

class _FirstLoginState extends State<FirstLoginPage> {
  var tipsText = '';
  var isOpen = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
//      appBar: AppBar(title: Text('登录页面',style: TextStyle(color: Colors.white),),elevation: 0,),
//      resizeToAvoidBottomPadding: false,
      body: Container(
          constraints: BoxConstraints(minHeight: 500),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/login_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(

            child: Column(
              children: <Widget>[
                SafeArea(
                    child:Container(
                      height: 51,
                      alignment: Alignment.center,
                      color: Color(0xff2D4ED1),
                      child: Text('登录页面',style: TextStyle(fontSize: 22,color: Colors.white),),
                    )),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Image.asset('images/login_logo.png',width: 100,),
                ),

                Container(
                  padding: EdgeInsets.all(15.0),
                  child: TextField(
//                        autofocus: true,
                    decoration: InputDecoration(
//                        labelText: "手机号",
                      hintText: "请输入手机号",
//                          border:InputBorder.none , //边框
                      contentPadding: EdgeInsets.fromLTRB(15, 17, 15, 15), //输入框内容部分设置padding，跳转跟icon的对其位置
                      prefixIcon: Container(
                          width: 20,
//                            padding: EdgeInsets.all(12.0),
                          padding: EdgeInsets.only(top:12.0,left: 12,bottom: 15,right: 12),
                          margin: EdgeInsets.only(top:0),
                          child: Image.asset('images/login_icon_phone.png',width:20,color: Colors.white,fit: BoxFit.fitWidth,)
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
//                      padding: EdgeInsets.fromLTRB(0,15,15,5),
                    margin: EdgeInsets.fromLTRB(15,0,15,0),
                      child: TextField(
                        decoration: InputDecoration(
//                        labelText: "密码",
                          hintText: "请输入密码",
                          prefixIcon: Padding(padding: EdgeInsets.fromLTRB(12,12,12,12),child: Image.asset('images/login_icon_code.png',width:20,color: Colors.white,fit: BoxFit.fitWidth,)),
//                          border:InputBorder.none,
                        ),
                        obscureText: isOpen, //是否是以星号*显示密码
                      ),
                    ),
                    Positioned(
                      top:-30,
                      right: 20,
//                      left: 500,
                      child: InkWell(
                        onTap: (){
                          print('ddddd');
                          setState(() {
                            isOpen = !isOpen;
                          });
                        },
                        child: Container(
                          width: 55,
                          height: 75,
                          padding: EdgeInsets.only(left: 15,right: 15,top:26),
                          color: Colors.pinkAccent,
                          child: Image.asset(isOpen?'images/login_icon_close.png':'images/login_icon_open.png',width:25,color: Colors.white,fit: BoxFit.fitWidth,),
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  padding: EdgeInsets.all(15),
                  child:Row(
                    children: <Widget>[
                      Expanded(child:
                      OutlineButton(
                          onPressed: (){},
                          color: Color(0xff2D4ED1),
                          padding: EdgeInsets.all(15.0),
                          textColor:Colors.white,
                          child: Text("登录"),

                      )
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child:InkWell(
                          onTap: () {},
                          child: Text('忘记密码？',style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child:InkWell(
                          onTap: () {
                            print('立即注册');
                          },
                          child: Text('立即注册',style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
//                Expanded(
//                  flex: 1,
//                  child: Text(''),
//                )
              ],
            ),
          ),
        ),
       );
  }
}
