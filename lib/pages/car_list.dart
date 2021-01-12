import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:myflutterapp/common/http.dart';
import 'package:myflutterapp/pages/user_carinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  final List<Map> lists = [
    {'label':'我的车库:','icon':'images/icon-car.png','index':0},
    {'label':'分享:','icon':'images/icon-share.png','index':1},
    {'label':'客服:','icon':'images/question.png','index':2},
    {'label':'设置:','icon':'images/setting.png','index':3}];

  @override
  Widget build(BuildContext context) {
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

  Widget createItem(item) {
    return InkWell(
        onTap:(){
            print(item['index'].toString());
//          Scaffold.of(context).showSnackBar(SnackBar(
//            content: Text('Tap'),
//          ));
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
                Text('已认证',style: TextStyle(fontSize: 20),),
                Container(child: Text('18226796732',style: TextStyle(fontSize: 16)),margin: EdgeInsets.only(left: 5),)],
            ),
          ),
          Positioned(
            left: 20,
            top: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text('账户余额',style: TextStyle(fontSize: 20),),
                Container(child: Text('10000,00',style: TextStyle(fontSize: 20)),margin: EdgeInsets.only(left: 5),)],
            ),
          ),
        ],
      ),
    );
  }

}
