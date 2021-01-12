import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:myflutterapp/common/http.dart';
import 'package:myflutterapp/pages/index_page2.dart';
import 'package:myflutterapp/pages/login.dart';
import 'package:myflutterapp/pages/user_base_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'index_page.dart';
//import './search.dart';
class SelectUserTypePage extends StatefulWidget {
  @override
  _SelectUserTypePageState createState() => _SelectUserTypePageState();
}

class _SelectUserTypePageState extends State<SelectUserTypePage> {
  String homePageContent='正在获取数据';
  List<Map> navigatorList = [];
  List<Map> slideList = [];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('选择用户')),
      body:Container(
          child:SingleChildScrollView(
            child: Column(
              children: <Widget>[
                new TextButton(
                  onPressed: () {
                    selectUserType('0');
                  },
                  child: Text('货主'),
                ),
                new TextButton(
                  onPressed: () {
                    selectUserType('1');
                  },
                  child: Text('司机'),
                ),
              ],
            ),
          )
      ) ,
    );


  }


//Main/MainQuest

 void selectUserType(type) async {
   SharedPreferences  _prefs =  await SharedPreferences.getInstance();
  _prefs.setString('userType',type);
  var pageList = [IndexPage2(),IndexPage()];
   Navigator.pushAndRemoveUntil(
       context,
       MaterialPageRoute(builder: (context) {
         return pageList[int.parse(type)];
       }),(check) => false
   );

 }

}
// 导航组件
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, navigatorList.length);
    }
    return Container(
      height: 200.0,
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItem(context, item);
        }).toList(),
      ),
    );
  }

  Widget _gridViewItem(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: 45.0,
          ),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }
}

class TopNavigatorlist extends StatelessWidget {
  final List navigatorList;

  TopNavigatorlist({Key key, this.navigatorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 500.0,

      padding: EdgeInsets.all(3.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: navigatorList.length,
        itemBuilder: (context,index) {
          return _gridViewItem(navigatorList[index]);
        },
      )
    );
  }
 Widget _gridViewItem(item) { //如果第一个参数加了上下文BuildContext context，调用的时候也要加。。不加的话，都不加
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: 45.0,
          ),
          Text(item['mallCategoryName']),
        ],
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
//      width: 400.0,
      color: Color(0xff2D4ED1),
      padding: EdgeInsets.all(3.0),
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network((slideList[index]['image']).toString(), fit: BoxFit.fill,
          );
        },
        pagination: new SwiperPagination(),
        itemCount: slideList.length,
        autoplay: true,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}
