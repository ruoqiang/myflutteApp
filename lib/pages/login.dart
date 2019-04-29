import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp/pages/details_page.dart';
import 'package:myflutterapp/pages/home.dart';
import 'package:myflutterapp/pages/index_page.dart';
import 'package:myflutterapp/pages/login.dart';
import 'package:myflutterapp/pages/register.dart';
import '../routers/application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myflutterapp/base_widgit/appbar.dart';
import '../pages/forget.dart';
import '../base_widgit/showToast.dart';
import '../base_widgit/create_my_input.dart';
import '../common/http.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  var tipsText = '';
  var isOpen = false;
  var pressAttention = false;
  // var _prefs =  SharedPreferences.getInstance();
  //手机号的控制器
  TextEditingController phoneController = TextEditingController();
  //密码的控制器
  TextEditingController passwordController = TextEditingController();

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
  void _mylogin() async{
    print({'手机号': phoneController, '密码': passwordController.text});
    if(phoneController.text == ''){
      showToast("请输入手机号码");
      return;
    }
     if(passwordController.text == ''){
      showToast("请输入密码");
      return;
    }
    var params = {
      'data': {
        'Identifier': phoneController.text,
        'Credential': passwordController.text
      },
      'token': 11111
    };
    SharedPreferences _prefs =  await SharedPreferences.getInstance();
    await post('Login/UserLogin',formData:params).then((val){
       print('dddddd：>>>>>>>>>>>>>-----------------------------------$val');
      showToast('登录成功');
      _prefs.setString('token',val['result']['Token']);
      _prefs.setString('mobile',phoneController.text);
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) {
           return IndexPage();
         }),
       );
    });
  }
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
                CreateMyInput(iconString:'images/login_icon_phone.png',placeholder:"请输入手机号",isPassword:false,inputController:phoneController),
                Stack(
                  children: <Widget>[
                    CreateMyInput(iconString:'images/login_icon_code.png',placeholder:"请输入密码",isPassword:isOpen,inputController:passwordController),
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
                              MaterialPageRoute(builder: (context) {
                                setValueToLocal();
                                return ForgetPage();
                              } ),
                            );
                      },),
                      InkWell(child: Text('立即注册',style: TextStyle(color: Color(0xffECB81C)),),onTap: (){
                        Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                print('我要去注册页面了');
                                setValueToLocal();
                                return RegisterPage();
                              } ),
                            );
                      },)
                    ],
                  ),
                )

              ],
            ),
          ),
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

