import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:myflutterapp/common/http.dart';
import 'package:provide/provide.dart';
import '../provide/count.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'order_detail.dart';


class OrderPage extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<OrderPage> with SingleTickerProviderStateMixin  {
  TabController _tabController;

  EasyRefreshController _controller;
  int _count = 15;
  @override
  void initState() {
    print('OrderPage---------------执行了');

    super.initState();
    this._tabController = new TabController(vsync: this, length: 4);
    this._tabController.addListener(() {
      print(this._tabController.toString());
      print(this._tabController.index);
      print(this._tabController.length);
      print(this._tabController.previousIndex);
    });

    _controller = EasyRefreshController();
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

   _gotoDetial(status) {
     Future.delayed(Duration(seconds: 1), (){
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) {
           return OrderDetailPage(id: status);
         }),
       );
     });
  }
  //后面需要替换成EasyReReesh插件
  Future<Null> _handleRefresh() async{
    print('refreshing stocks...');
    setState(() {
      _count +=10;
    });
  }
  @override
  Widget build(BuildContext context) {
    print('OrderPage--------------build--执行了');
    return Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.white,
////          title:
//        ),
        appBar:  fixedAppbar(title:'历史货源清单'),
        body: Column(
          children: [
              Container(
                color: Colors.white,
//                padding: EdgeInsets.only(top: 30),
                child:TabBar(
                  controller: this._tabController,
                  unselectedLabelColor:Colors.grey,
                  labelColor: Colors.blue,

                  indicator: DotIndicator(
                    color: Colors.blue,
                    distanceFromCenter: 16,
                    radius: 3,
                    paintingStyle: PaintingStyle.fill,
                  ),
                  tabs: <Widget>[
                    Tab(text: '全部'),
                    Tab(text: '申请中'),
                    Tab(text: '进行中'),
                    Tab(text: '已完成')
                  ],
                ),
              ),
            Flexible(
                child:TabBarView(
                  controller: this._tabController,
                  children: <Widget>[
                    createEasyrefresh(context,0),
                    createEasyrefresh(context,2),
                    createEasyrefresh(context,1),
                    createEasyrefresh(context,0),
                  ],
                )
            )
          ],
        )
    );


  }

  createEasyrefresh(BuildContext context,status) {

    return RefreshIndicator(
          onRefresh: _handleRefresh,
          child: MediaQuery.removePadding(
           context: context,
            removeTop: true,
              child:ListView(
                padding: EdgeInsets.only(bottom: 15),
                scrollDirection: Axis.vertical,//垂直列表
                children: List.generate(_count, (index) {
                  return Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 10,top: 1),
                    child: Column(
                      children: [
                        _ListTop(status),
                        _listBottom()
                      ],
                    ),
                  );
                }),
              )
          )
      );

  }



  Widget _ListTop(status) {
    String btnText = '已完成';
    Color btnColor = Colors.green;
    String userImg = 'images/user_img01.png';
    if(status ==0) {
      btnText = '已完成';
      btnColor = Colors.green;
      userImg = 'images/user_img03.png';
    } else if(status ==1) {
      btnText = '进行中';
      btnColor = Colors.deepOrange;
      userImg = 'images/user_img02.png';
    } else if(status ==2) {
      btnText = '申请中';
      btnColor = Colors.blueAccent;
      userImg = 'images/user_img03.png';
    }
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 3),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50)),
                  child: Image.asset(userImg,width: ScreenUtil().setWidth(96),height: ScreenUtil().setWidth(96),),
                ),
                Text('张三',style: TextStyle(fontSize: ScreenUtil().setWidth(28)),)
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                width: ScreenUtil().setWidth(630),
                padding: EdgeInsets.only(top: ScreenUtil().setWidth(20),bottom:  ScreenUtil().setWidth(10),left:  ScreenUtil().setWidth(20)),
                margin: EdgeInsets.only(top: ScreenUtil().setWidth(10),right: ScreenUtil().setWidth(10),bottom:  ScreenUtil().setWidth(10),),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: Colors.black12)),
                ),
                child: Column(
                  children: [
                    Row(children: [
                      Image.asset('images/icon_addres_start.png',width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40)),
                      Container(
                        margin: EdgeInsets.only(bottom:  ScreenUtil().setWidth(10),),
                        width: ScreenUtil().setWidth(300),
                        child: Text('上海市闵行区顾戴路上海市闵行区顾戴路上海市闵行区顾戴路',overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: ScreenUtil().setWidth(28)),),
                      )
                    ],),
                    Container(
                      margin: EdgeInsets.only(top:  ScreenUtil().setWidth(30),),
                      child: Row(children: [
                        Image.asset('images/icon_addres_end.png',width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40)),
                        Container(
                          width: ScreenUtil().setWidth(300),
                          child: Text('上海市闵行区顾戴路上海市闵行区顾戴路上海市闵行区顾戴路',overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: ScreenUtil().setWidth(28)),),
                        )
                      ],),
                    )
                  ],
                ),
              ),
              Positioned(
                right: 10,top: 30,
                child: SizedBox(
                  width: 80,
                  height: 32,
                  child:
                  FittedBox(
                    fit: BoxFit.fitHeight,
                      child: FlatButton(
                        child: Text(btnText,style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(36))),color: btnColor,onPressed: (){
                        _gotoDetial(status);
                      },),
                      )
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  Widget _listBottom() {
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(100),bottom:ScreenUtil().setWidth(10) ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 3),
            child: Row(children: [
              Icon(Icons.alarm,size: 14,),
              Container(
//              width: ScreenUtil().setWidth(300),
                constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(300)),
                child: Text('货物类型货物类型货物类型货物类型',style: TextStyle(fontSize: ScreenUtil().setWidth(24)),overflow: TextOverflow.ellipsis,),
              ),
              Container(
                width: ScreenUtil().setWidth(300),
                child: Text('2020-10-01 16:00:00 ',style: TextStyle(fontSize: ScreenUtil().setWidth(24)),overflow: TextOverflow.ellipsis,),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(top: 3),
            child: Row(children: [
              Icon(Icons.child_friendly,size: 14,),
              Container(
//              width: ScreenUtil().setWidth(300),
                constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(300)),
                child: Text('货物类型:',style: TextStyle(fontSize: ScreenUtil().setWidth(24)),overflow: TextOverflow.ellipsis,),
              ),
              Container(
                width: ScreenUtil().setWidth(300),
                child: Text('服装、饮料   5吨',style: TextStyle(fontSize: ScreenUtil().setWidth(24)),overflow: TextOverflow.ellipsis,),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(top: 3),
            child: Row(children: [
              Icon(Icons.airport_shuttle,size: 14,),
              Container(
//              width: ScreenUtil().setWidth(300),
                constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(300)),
                child: Text('车辆需求:',style: TextStyle(fontSize: ScreenUtil().setWidth(24)),overflow: TextOverflow.ellipsis,),
              ),
              Container(
                width: ScreenUtil().setWidth(300),
                child: Text('5米 平板车   20吨',style: TextStyle(fontSize: ScreenUtil().setWidth(24)),overflow: TextOverflow.ellipsis,),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}


