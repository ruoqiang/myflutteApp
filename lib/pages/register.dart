import 'dart:async';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp/base_widgit/create_my_input.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:myflutterapp/base_widgit/webview.dart';
import 'package:myflutterapp/common/http.dart';
import 'package:myflutterapp/pages/details_page.dart';
import 'package:myflutterapp/pages/index_page.dart';
import 'package:myflutterapp/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routers/application.dart';
import 'package:myflutterapp/base_widgit/appbar.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  var tipsText = '';
  var isOpen = true;
  var pressAttention = false;

  Timer _timer;
  int _countdownTime = 0;

  //手机号的控制器
  TextEditingController phoneController = TextEditingController();
  //密码的控制器
  TextEditingController passwordController = TextEditingController();

  TextEditingController codeController = TextEditingController();

  RegExp mobileExp = RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
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
    print(phoneController.text);
    _prefs.setString('mobile',phoneController.text);
  }
  void startCountdownTimer() {
    var mobile = phoneController.text;
    if(mobile=='') {
      showToast('请输入手机号码');
      return;
    }
    if(mobileExp.hasMatch(phoneController.text)==false) {
      showToast('请输入正确格式的手机号码');
      return;
    }
    postVcode(mobile);
    _countdownTime = 60;
    var callback = (timer) => {
          setState(() {
            if (_countdownTime < 1) {
              _timer.cancel();
            } else {
              _countdownTime = _countdownTime - 1;
            }
          })
        };
    _timer = Timer.periodic(Duration(seconds: 1), callback);
  }

void postVcode(String mobile) async {
    var params = {
        'data': {
          'Phone': mobile
        },
        'token': 11111
    };
    await post('ComService/PostVcode',formData:params).then((val){
      print('PostVcode>>>>>>>>>>>>>-----------------------------------$val');
    });
  }
void _register() async{
    print({'手机号': phoneController, '密码': passwordController.text});
    if(phoneController.text == ''){
      showToast("请输入手机号码");
      return;
    }
    if(mobileExp.hasMatch(phoneController.text)==false) {
      showToast('请输入正确格式的手机号码');
      return;
    }
     if(passwordController.text == ''){
      showToast("请输入密码");
      return;
    }
    if(codeController.text == ''){
      showToast("请输入验证码");
      return;
    }
    var params = {
      'data': {
        'Identifier': phoneController.text,
        'Credential': passwordController.text,
        'Additional': codeController.text
      },
      'token': 11111
    };
    SharedPreferences _prefs =  await SharedPreferences.getInstance();
    await post('Login/UserRegister',formData:params).then((val){
      print('dddddd：>>>>>>>>>>>>>-----------------------------------$val');
      // this.storage.set('token', data.result.Token);
      //   this.navCtrl.push(HomePage);
      showToast('注册成功');
      _prefs.setString('token',val['result']['Token']);
      _prefs.setString('mobile',phoneController.text);
      //跳转逻辑跟登录一样。。先省略

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return IndexPage();
        }),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
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
              MyAppBar(title: '注册', isHasBackBtn: true),
              CreateMyInput(
                  iconString: 'images/login_icon_phone.png',
                  placeholder: "请输入手机号",
                  isPassword: false,
                  inputController: phoneController),

              Stack(
                children: <Widget>[
                  CreateMyInput(
                      iconString: 'images/login_icon_code.png',
                      placeholder: "请输入密码",
                      isPassword: isOpen,
                      inputController: passwordController),
                  Positioned(
                    top: -5,
                    right: 20,
                    child: InkWell(
                      onTap: () {
                        print('ddddd');
                        setState(() {
                          isOpen = !isOpen;
                        });
                      },
                      child: Container(
                        width: 55,
                        height: 60,
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 0),
                        color: Colors.transparent,
                        child: Image.asset(
                          isOpen
                              ? 'images/login_icon_close.png'
                              : 'images/login_icon_open.png',
                          width: 25,
                          color: Color(0xff2D4ED1),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  CreateMyInput(
                      iconString: 'images/login_register_icon_verification.png',
                      placeholder: "请输入验证码",
                      isPassword: false,
                      inputController: codeController),
                  Positioned(
                    top: 3,
                    right: 20,
                    child: IgnorePointer(
                      ignoring: _countdownTime > 0?true:false,
                    child: InkWell(
                      onTap: () {
                        print('ddddd');
                        //开始倒计时
                        startCountdownTimer();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    width: 0.8,
                                    color: Color(0xff2D4ED1))), //底部border
                            color: Colors.white),
                        height: 45,
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 0, bottom: 0),
                        child: Container(
                          child: Text(
                            _countdownTime > 0
                                ? '$_countdownTime后重新获取'
                                : '获取验证码',
                            style: TextStyle(color: Color(0xff2D4ED1)),
                          ),
                        ),
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
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Image.asset(
                        'images/login_register_icon_choose.png',
                        width: 15,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                      padding: EdgeInsets.only(bottom: 3),
                      child: Row(
                        children: <Widget>[
                          Wrap(
                            children: <Widget>[
                              Text('同意《'),
                              Container(
                                margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                                child: InkWell(
                                  onTap: () {
//                                      Application.router.navigateTo(context,"/detail?id=3",transition: TransitionType.inFromRight);
                                    // Application.router.navigateTo(
                                    //     context, "/shop_cart",
                                    //     transition: TransitionType.inFromRight);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        // var model = item[index];
                                        return WebView(
                                            statusBarColor: '4c5bca',
                                            url: 'http://wechat.chepass.com:8021/Content/dist/#/useAgreementRegister?backDoor',
                                            title: '注册协议',
                                            hideAppBar: false);
                                      }),
                                    );
                                  },
                                  child: Text(
                                    '注册协议',
                                    style: TextStyle(color: Color(0xff2D4ED1)),
                                  ),
                                ),
                              ),
                              Text('》'),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 40,
                          child: RaisedButton(
                            disabledTextColor: Color(0xff2D4ED1),
                            highlightColor:
                                Color(0xff2D4ED1), //Color(0xff2D4ED1),
                            splashColor: Color(0xff2D4ED1),
                            onPressed: () {
                              _register();
                              setState(() => pressAttention = !pressAttention);
                            },
                            textColor: pressAttention
                                ? Colors.white
                                : Color(0xff2D4ED1),
                            child: Text("注册"),
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      height: 38,
                      child: OutlineButton(
                        borderSide: BorderSide(
                          color: Color(0xff2D4ED1), //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 0.8, //width of the border
                        ),
                        highlightColor: Color(0xff2D4ED1),
                        splashColor: Color(0xff2D4ED1), //点击水波
                        onPressed: () {
//                          Navigator.push(
//                            context,
////                              MaterialPageRoute(builder: (context) => DetailsPage('666')),
//                            MaterialPageRoute(
//                                builder: (context) => LoginPage()),
//                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              print('我要去登录页面了');
                              setValueToLocal();
                              return LoginPage();
                            }),
                          );
//                            Navigator.pushNamed(context, "router/login_page");
//                            Application.router.navigateTo(context,"/login_page");
                        },
                        color: Color(0xff2D4ED1),
                        textColor: Color(0xff2D4ED1),
                        child: InkWell(child: Text('已有账号，去登录',style: TextStyle(color: Color(0xff2D4ED1)),),),
                      ),
                    ))
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
