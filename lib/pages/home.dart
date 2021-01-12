import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:myflutterapp/base_widgit/webview.dart';
import 'package:myflutterapp/common/http.dart';
import 'package:myflutterapp/pages/login.dart';
import 'package:myflutterapp/pages/process.dart';
import 'package:myflutterapp/pages/user_base_info.dart';
import 'package:myflutterapp/pages/user_center.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provide/provide.dart';
import '../provide/currentMenuIndex.dart';
import '../provide/count.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent='正在获取数据';
  List<Map> navigatorList = [];
  List<Map> slideList = [{'image': 'images/banner.png'},{'image': 'images/banner2.png'},{'image': 'images/banner3.png'}];
  List<Map> menuNavigatorList = [{'image': 'images/index_tab_etc.png','name':'办理ETC','index':0},{'image': 'images/index_tab_bill.png','name':'账单查询','index':1},{'image': 'images/index_tab_current.png','name':'通行记录','index':2}
  ,{'image': 'images/index_tab_car.png','name':'车辆绑定','index':3}];

  List<Map> actionlistList = [{'image': 'images/action001.png','url':'http://wechat.chepass.com:8021/Content/dist/#/home/ActionDtl/3?backDoor','title': '开票新规'},
  {'image': 'images/action002.png','url':'http://wechat.chepass.com:8021/Content/dist/#/home/ActionDtl/2?backDoor','title': '开票公告'}
  ];
  @override
  void initState() {
    super.initState();

  }
  void checkToken() async {
   SharedPreferences  _prefs =  await SharedPreferences.getInstance();
   var token = _prefs.getString('token');
   var params = {
      'token': token
    };
    //全局Provide
    var currentMenuIndexCount = Provide.value<CurrentMenuIndexProvide>(context);

    await post('Main/MainQuest',formData:params).then((val){
      if(val['issuccess'] ==false) {
        Navigator.push(
         context,
         MaterialPageRoute(builder: (context) {
           return LoginPage();
         }),
       );
      } else if(val['issuccess'] ==true) {
        var pageList = [ProcessPage(),UserCenterPage()];
        Navigator.push(
         context,
         MaterialPageRoute(builder: (context) {
           return pageList[currentMenuIndexCount.currentIndex];
         }),
       );
      }
    });
 }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
//       appBar: AppBar(title: Text('首页')),
      appBar: fixedAppbar(title:'运单'),
      body:Container(
          child:SingleChildScrollView(
            child: SafeArea(
              child: Column(
              children: <Widget>[
                  slideList.length >0 ?SlideList(slideList: slideList,):new Text(''),
                MenuNavigator(menuNavigatorList:menuNavigatorList,goToNextPage: checkToken),

                Actionlist(title:'活动推荐',actionlistList:actionlistList),
                // RaisedButton(child: Text('跳转到个人信息',style: TextStyle(color: Colors.deepPurple),),onPressed: () {
                //   checkToken(1);
                //   // Navigator.push(
                //   //   context,
                //   //   new MaterialPageRoute(builder: (context) => new UserBaseInfoPage()),
                //   // );
                // },),
              ],
            ),
            ),
          )
      ) ,
    );
  }

}

class MenuNavigator extends StatelessWidget {

  final List menuNavigatorList;
  final void Function() goToNextPage;

  MenuNavigator({this.menuNavigatorList,this.goToNextPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      margin: EdgeInsets.only(top: 10,bottom: 10),
      padding: EdgeInsets.fromLTRB(3, 10, 0, 0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: menuNavigatorList.map((item) {

          return _getMenuItem(context, item,goToNextPage);
        }).toList(),
      ),
    );
  }
  Widget _getMenuItem(BuildContext context, item,goToNextPage){
    var currentMenuIndexCount = Provide.value<CurrentMenuIndexProvide>(context);

    return Container(
      child: InkWell(
      onTap: () {
        currentMenuIndexCount.changeIndex(item['index']);
        goToNextPage();
      },
      child: Column(
        children: <Widget>[
          Image.asset(
            item['image'],
            width: 45.0,
          ),
          Text(item['name'],style: TextStyle(color: Colors.black),),
        ],
      ),
    ),
    );
  }
}

class SlideList extends StatelessWidget {
  final List slideList;

  SlideList({Key key, this.slideList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.asset((slideList[index]['image']).toString(), fit: BoxFit.fill,
          );
        },
        pagination: new SwiperPagination(),
        itemCount: slideList.length,
        autoplay: true,
        // viewportFraction: 0.8,
        // scale: 0.9,
      ),
    );
  }
}

class Actionlist extends StatelessWidget {
  final String title;
  final List actionlistList;

  Actionlist({Key key, this.title,this.actionlistList,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 30,
          color: Colors.white,
          alignment: Alignment.centerLeft,
          child: Text(title,style: TextStyle(fontSize: 16),),
        ),
        Container(
        color: Colors.white,
        height: 150.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal, //水平滚动
          itemCount: actionlistList.length,
          itemBuilder: (context,index) {
            return _actionViewItem(context,actionlistList[index],index);
          },
        )
      )
      ],
    );
  }
 Widget _actionViewItem(BuildContext context,item,index) { //如果第一个参数加了上下文BuildContext context，调用的时候也要加。。不加的话，都不加
    return Container(
      margin: index ==1 ?EdgeInsets.only(right: 0):EdgeInsets.only(right: 10),
      child: InkWell(
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        // var model = item[index];
                        return WebView(
                            url: item['url'],
                            title: item['title'],
                            hideAppBar: false);
                      }),
                    );
            },
            child: Column(
              children: <Widget>[
                Image.asset(
                  item['image'],
                  width: 250.0,
                ),
              ],
            ),
          ),
    );
  }
}



