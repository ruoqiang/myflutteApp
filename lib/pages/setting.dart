import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:myflutterapp/common/http.dart';
import 'package:myflutterapp/pages/user_carinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'car_list.dart';
import 'certification.dart';
import 'login.dart';



class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {

  final List<Map> lists = [
    {'label':'我的车库:','icon':'images/icon-car.png','index':0},
    {'label':'分享:','icon':'images/icon-share.png','index':1},
    {'label':'客服:','icon':'images/question.png','index':2},
    {'label':'设置:','icon':'images/setting.png','index':3}];
  var isCertified;
  var isLogin = false;
  var mobile;

  @override
 initState()  {
    // TODO: implement initState

    print('initState-----执行了');
    super.initState();
    getUserInfo();

  }
 getUserInfo() async{
   SharedPreferences _prefs =  await SharedPreferences.getInstance();
    isCertified = _prefs.get('isCertified')??false;
    isLogin = _prefs.get('isLogin');
    mobile = _prefs.get('mobile');

   setState(() {
     isCertified = isCertified;
     isLogin = isLogin;
     mobile = mobile;
   });

   print('isLogin-----$isLogin');
   print('isCertified-----$isCertified');
   print('mobile-----$mobile');
 }
  gotoLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return new LoginPage(pageFrom:'MyPage');
      }),
    );
  }
  gotoCertified() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return CertificationPage();
      }),
    );
  }
  @override
  Widget build(BuildContext context) {
    print('mypage-----执行了');
    return Scaffold(
      appBar: fixedAppbar(title:'我的'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            cardinfo(),
            BottomListBox(lists)
          ],
        ),
      ),
    );
  }

  Widget BottomListBox (BottomListBox){
    return Container(
//      color: Colors.white,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        children: createdList(BottomListBox),
      ),
    );
  }

  createdList(lists) {
    //1.创建一个空数组并且有返回的组件类型(根据父元素需要的子组件类型)
    List<Widget> Temlist = [];
    //2.forEach变量，并往1添加子项组件
    lists.forEach((item){
      Temlist.add(createItem(item));
    });
//  3.返回
    return Temlist;
  }

    createItem(item)  {
    return InkWell(
        onTap:(){
          print('-------------------isLogin---------------------》》》$isLogin');
          if(isLogin==false) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
              return LoginPage(pageFrom:'MyPage');
            }),
            );
            return;
          }
            print(item['index'].toString());

            var PageList = [CarListPage()];
            if(item['index']==0) {
              print('-------------------item 0---------------------》》》');
            } else {
              print('-------------------item 其他---------------------》》》');
              return showToast('该功能暂未开通');
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return PageList[item['index']];
              }),
            );


        },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom:BorderSide(width: 1,color: Colors.black12))
        ),
        padding: EdgeInsets.only(left: 7,right: 7,top:10,bottom: 10),
        child: Stack(
          children: [
            Row(
              children: [
                Image.asset(item['icon'],width: ScreenUtil().setWidth(46), height:ScreenUtil().setWidth(46)),
                Container(child: Text(item['label']),margin: EdgeInsets.only(left: 8),)
              ],
            ),
            Positioned(child: Icon(Icons.keyboard_arrow_right),right: 0,)
          ],
        )
      )
    );
  }

  Widget cardinfo() {
    return Container(
      child: Stack(
        children: [
          Opacity(opacity: 0.5,child: Image.asset('images/login_bg4.png',width: ScreenUtil().setWidth(750), height:ScreenUtil().setWidth(500),fit: BoxFit.fill),),
          Positioned(
            right: 50,
            top: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(71)),
              child: Image.asset('images/user_img02.png',width: ScreenUtil().setWidth(140), height:ScreenUtil().setWidth(140)),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
//                Text(isLogin.toString()),
                Text(isLogin== true?(isCertified?'已认证':'未认证')
                    :
                  '您还未登录，请去登录',
                  style: TextStyle(fontSize: isLogin==true? 20:17),),
                Container(child: isLogin==true? Text(mobile,style: TextStyle(fontSize: 16)):Text(''),margin: EdgeInsets.only(left: 5),)],
            ),
          ),
          isLogin== true?isCertified?Positioned(
            left: 20,
            top: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text('账户余额',style: TextStyle(fontSize: 20),),
                Container(child: Text('10000,00',style: TextStyle(fontSize: 20)),margin: EdgeInsets.only(left: 5),)],
            ),
          ):
          Positioned(
              left: 20,
              top: 70,
              child: Row(
                crossAxisAlignment:CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      gotoCertified();
                    },
                    child: Container(
                      child: Text('完成认证即可快速联系货主',style: TextStyle(fontSize: 17),),
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1,color: Colors.black))),
                    ),
                  )
                  ,Icon(Icons.keyboard_arrow_right,size: 24,)
                ],
              )
          ):Positioned(
            left: 20,
            top: 80,
            child: Container(
              width:80.0,
              height:28.0,
              child: RaisedButton(
                color: Color(0xff2D4ED1),
                onPressed: () {
                  gotoLogin();
                },
                child: Text(
                  '登录', style: TextStyle(fontSize: 14, color: Colors.white),),
              ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
//  bool get wantKeepAlive => throw UnimplementedError();
  bool get wantKeepAlive => true;
}