import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp/base_widgit/create_my_input.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:myflutterapp/pages/details_page.dart';
import 'package:myflutterapp/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routers/application.dart';
import 'package:myflutterapp/base_widgit/appbar.dart';

class ForgetPage extends StatefulWidget {
  @override
  _ForgetState createState() => _ForgetState();
}

class _ForgetState extends State<ForgetPage> {
  var tipsText = '';
  var isOpen = true;
  var pressAttention = false;
//手机号的控制器
  TextEditingController phoneController = TextEditingController();
  //密码的控制器
  TextEditingController passwordController = TextEditingController();
  //验证码的控制器
  TextEditingController codeController = TextEditingController();
  @override
  void initState() {
    getValueFromLocalToForm();
    super.initState();
  }

  //获取本地持久化数据
  getValueFromLocalToForm() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if(_prefs.getString('mobile')!=null) {
      setState(() {
        phoneController.text = _prefs.getString('mobile');
      });
    }
  }
   //设置本地持久化数据
  setValueToLocal() async{
    SharedPreferences  _prefs =  await SharedPreferences.getInstance();
    _prefs.setString('mobile',phoneController.text);
  }

  getCode() {
    print({'手机号': phoneController, '密码': passwordController.text});
    if(phoneController.text == ''){
      showToast("请输入手机号");
      return;
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
          constraints: BoxConstraints(minHeight: 500),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                MyAppBar(title:'忘记密码',isHasBackBtn:true),
                CreateMyInput(iconString:'images/login_icon_phone.png',placeholder:"请输入手机号",isPassword:false,inputController:phoneController),
                Stack(
                  children: <Widget>[
                    CreateMyInput(iconString:'images/login_icon_code.png',placeholder:"请输入密码",isPassword:false,inputController:passwordController),
                   
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
                    CreateMyInput(iconString:'images/login_register_icon_verification.png',placeholder:"请输入验证码",isPassword:false,inputController:codeController),
                    Positioned(
                      top:3,
                      right: 20,
                      child: InkWell(
                        onTap: (){
                          print('ddddd');
                          getCode();
//                          setState(() {
//                            isOpen = !isOpen;
//                          });
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
                              MaterialPageRoute(builder: (context) {
                                setValueToLocal();
                                return LoginPage();
                              }),
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

}
