import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp/pages/details_page.dart';
import 'package:myflutterapp/pages/login.dart';
import '../routers/application.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myflutterapp/base_widgit/appbar.dart';
import '../pages/forget.dart';
import '../base_widgit/showToast.dart';
import '../common/http.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  var tipsText = '';
  var isOpen = false;
  var pressAttention = false;

  //手机号的控制器
  TextEditingController phoneController = TextEditingController();
  //密码的控制器
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
//      appBar: AppBar(title: Text('注册',style: TextStyle(color: Colors.white),),elevation: 0,),
//      resizeToAvoidBottomPadding: false,
      body: Container(
          constraints: BoxConstraints(minHeight: 500),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                MyAppBar(title:'登录',isHasBackBtn:true),
                _logo(),
                createMyInput('images/login_icon_phone.png',"请输入手机号",false,phoneController),
                Stack(
                  children: <Widget>[
                    createMyInput('images/login_icon_code.png',"请输入密码",isOpen,passController),
                    Positioned(
                      top:-5,
                      right: 20,
                      child: InkWell(
                        onTap: (){
                          print('dddd');
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
                                  _mylogin();
                                  // setState(() => pressAttention = !pressAttention);
                                },
                              textColor:pressAttention ? Colors.white : Color(0xff2D4ED1),
                              child: Text("登录"),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(child: Text('忘记密码？',style: TextStyle(color: Color(0xff2D4ED1)),),onTap: (){
                        Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgetPage()),
                            );
                      },),
                      InkWell(child: Text('立即注册',style: TextStyle(color: Color(0xffECB81C)),),onTap: (){},)
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
       );
  
    
  }
 void _mylogin() async{
    
    print({'手机号': phoneController, '密码': passController.text});
    if(phoneController.text == ''){
      showToast("请输入手机号码");
      return;
    }
     if(passController.text == ''){
      showToast("请输入密码");
      return;
    }
    var params = {
      'data': {
        'Identifier': phoneController.text,
        'Credential': passController.text
      },
      'token': 11111
    };
    await post('Login/UserLogin',formData:params).then((val){
      print('dddddd：>>>>>>>>>>>>>-----------------------------------$val');
    });
  }


  Widget createMyInput(iconString,placeholder,isPassword,myController) {

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
                controller: myController,
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

  Widget _logo() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 60, 0, 20),
      child: Column(
        children: <Widget>[
          Container(
            // alignment: Alignment.center, //开启就会该元素宽度变成100%
            decoration: BoxDecoration(
              color: Color(0xff2D4ED1),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Image.asset('images/login_logo.png',width: 79,),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0,20,0,0),
            child: Text('易路通达-专注公路物流服务',style: TextStyle(color: Color(0xff2D4ED1),fontSize: 16),),
          )
        ],
      ),
    );
  }

  

}

