import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:myflutterapp/common/http.dart';
import 'package:myflutterapp/model/goods_list_model.dart';
import 'package:myflutterapp/provide/currentMenuIndex.dart';
import 'package:provide/provide.dart';
import '../provide/count.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:myflutterapp/common/mock.dart';
import 'order_detail.dart';



class HistoryPublishOrderPage extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}
var tabControllerIndex =0;
class _OrderState extends State<HistoryPublishOrderPage> with SingleTickerProviderStateMixin  {
  TabController _tabController;

  EasyRefreshController _controller;
  int _count = 9;
  var list = [];
  var listWaiting = [];
  var listProcessing = [];
  var listSuccess = [];
  var listWaitingTep = [];
  var listProcessingTep = [];
  var listSuccessTep = [];
  @override
  void initState() {
    print('OrderPage---------------执行了');
    getGoodsList();
    super.initState();
    this._tabController = new TabController(vsync: this, length: 4);
    this._tabController.addListener(() {
      tabControllerIndex = this._tabController.index;
      print(this._tabController.toString());
      print(this._tabController.index);
      print(this._tabController.length);
      print(this._tabController.previousIndex);
    });

    _controller = EasyRefreshController();
  }

  getGoodsList() {
    var historyGoods = HistoryGoods; //1.获取json格式字符串 带双引号
    print('goodsListModel- hasMore--------------$historyGoods');

    var JosnData = json.decode(historyGoods); //2.json.decode转换json格式字符串 去掉双引号 方便打印
    print('goodsListModel- data--------------$JosnData');

    GoodsListModel GoodsModelData = GoodsListModel.fromJson(JosnData); //3.让数据可以使用点属性访问

    print('setState --before--GoodsModelData.createTime------------${GoodsModelData.data[0].createTime}');
    print('setState --before--GoodsModelData.status------------${GoodsModelData.data[0].status}');
    print('setState --before--GoodsModelData.goodsType------------${GoodsModelData.data[0].goodsType}');
    setState(() {
      list = GoodsModelData.data;
    });
    print('setState --after list.createTime-------------${GoodsModelData.data[0].createTime}');
      //过滤重组数据
     GoodsModelData.data.forEach((item) {
      if(item.status =='1') {
        listWaitingTep.add(item);
      }
      if(item.status =='2') {
        listProcessingTep.add(item);
      }
      if(item.status =='3') {
        listSuccessTep.add(item);
      }
    });
    copyData();
    setState(() {
      listWaiting = listWaitingTep;
      listProcessing = listProcessingTep;
      listSuccess = listSuccessTep;
    });
  }
  //拷贝数据
  copyData() {
    while(listWaitingTep.length <10) {
      var newList = List.from(listWaitingTep);
      listWaitingTep.addAll(newList);
    }
    while(listProcessingTep.length <10) {
      var newProcessingTepList = List.from(listProcessingTep);
      listProcessingTep.addAll(newProcessingTepList);
    }
    while(listSuccessTep.length <10) {
      var newSuccessTepList = List.from(listSuccessTep);
      listSuccessTep.addAll(newSuccessTepList);
    }
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
    print('refreshing stocks...tabControllerIndex:$tabControllerIndex');
    var dataList = [list,listWaiting,listProcessing,listSuccess];
    var newList = List.from(dataList[tabControllerIndex]);

    setState(() {
      dataList[tabControllerIndex].addAll(newList);
//      listProcessing = listProcessingTep;
//      listSuccess = listSuccessTep;
    });
    setState(() {
      _count +=10;
    });
  }
  @override
  Widget build(BuildContext context) {
    print('OrderPage--------------build--执行了');
    print('OrderPage build--------------build--');
//    final _name = Provider.of<CurrentMenuIndexProvide>(context);
    return Scaffold(
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
                    Tab(text: '未接单'),
                    Tab(text: '进行中'),
                    Tab(text: '已完成')
                  ],
                ),
              ),
            Flexible(
                child:TabBarView(
                  controller: this._tabController,
                  children: <Widget>[
                    createEasyrefresh(context,list),
                    createEasyrefresh(context,listWaiting),
                    createEasyrefresh(context,listProcessing),
                    createEasyrefresh(context,listSuccess),
//                    Tab(text: '全部'),
//                    Tab(text: list[0].status),
//                    Tab(text: '未接单'),
//                    Tab(text: '进行中'),
//                    Tab(text: '已完成')
                  ],
                )
            )
          ],
        )
    );


  }

  createEasyrefresh(BuildContext context,data) {

    return RefreshIndicator(
          onRefresh: _handleRefresh,
          child: MediaQuery.removePadding(
           context: context,
            removeTop: true,
              child:ListView(
                padding: EdgeInsets.only(bottom: 15),
                scrollDirection: Axis.vertical,//垂直列表
                children: List.generate(data.length, (index) {
                  return Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 10,top: 1),
                    child: Column(
                      children: [
//                        TestList(index)
                        _ListTop(data,index),
                        _listBottom(data,index)
                      ],
                    ),
                  );
                }),
              )
          )
      );
  }

  Widget TestList(list,index){
    print(index);
    return Text(list[index].status);
  }

  Widget _ListTop(list,index) {
    String btnText = '已完成';
    Color btnColor = Colors.green;
    String userImg = 'images/user_img01.png';
    if(list[index].status == '3') {
      btnText = '已完成';
      btnColor = Colors.green;
      userImg = 'images/user_img03.png';
    } else if(list[index].status =='2') {
      btnText = '进行中';
      btnColor = Colors.deepOrange;
      userImg = 'images/user_img02.png';
    } else if(list[index].status =='1') {
      btnText = '未接单';
      btnColor = Colors.blueAccent;
      userImg = 'images/user_img03.png';
    }

    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: ScreenUtil().setWidth(700),
                padding: EdgeInsets.only(top: ScreenUtil().setWidth(20),bottom:  ScreenUtil().setWidth(10)),
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
                        width: ScreenUtil().setWidth(340),
                        child: Text(list[index].startAddress,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: ScreenUtil().setWidth(28)),),
                      )
                    ],),
                    Container(
                      margin: EdgeInsets.only(top:  ScreenUtil().setWidth(30),bottom:  ScreenUtil().setWidth(10)),
                      child: Row(children: [
                        Image.asset('images/icon_addres_end.png',width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40)),
                        Container(
                          width: ScreenUtil().setWidth(340),
                          child: Text(list[index].endAddress,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: ScreenUtil().setWidth(28)),),
                        )
                      ],),
                    )
                  ],
                ),
              ),
              Positioned(
                right: 10,top: 0,
                child: Container(
                  transform: Matrix4.rotationZ(0.5),
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(32)),color: btnColor),
                  child: Text(btnText,style: TextStyle(color: Colors.white),)
                )
              )
            ],
          )
        ],
      ),
    );
  }
  Widget _listBottom(data,index) {
    var isFinished = data[index].status =='2' ? true: false;
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(20),bottom:ScreenUtil().setWidth(10) ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 6),
            child: Row(children: [
              Icon(Icons.alarm,size: 14,),
              Container(
//              width: ScreenUtil().setWidth(300),
                constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(300)),
                child: Text('发布时间: ',style: TextStyle(fontSize: ScreenUtil().setWidth(24)),overflow: TextOverflow.ellipsis,),
              ),
              Container(
                width: ScreenUtil().setWidth(300),
                child: Text(data[index].createTime,style: TextStyle(fontSize: ScreenUtil().setWidth(24)),overflow: TextOverflow.ellipsis,),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(top: 6),
            child: Row(children: [
              Icon(Icons.child_friendly,size: 14,),
              Container(
//              width: ScreenUtil().setWidth(300),
                constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(300)),
                child: Text('货物类型: ',style: TextStyle(fontSize: ScreenUtil().setWidth(24)),overflow: TextOverflow.ellipsis,),
              ),
              Container(
                width: ScreenUtil().setWidth(300),
                child: Text('${data[index].goodsType}',style: TextStyle(fontSize: ScreenUtil().setWidth(24)),overflow: TextOverflow.ellipsis,),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(top: 6),
            child: Row(children: [
              Icon(Icons.airport_shuttle,size: 14,),
              Container(
//              width: ScreenUtil().setWidth(300),
                constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(300)),
                child: Text('车辆需求:',style: TextStyle(fontSize: ScreenUtil().setWidth(24)),overflow: TextOverflow.ellipsis,),
              ),
              Container(
                width: ScreenUtil().setWidth(300),
                child: Text('${data[index].needsCar}',style: TextStyle(fontSize: ScreenUtil().setWidth(24)),overflow: TextOverflow.ellipsis,),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(top: 10,bottom: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
//                  Container(
//                    constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(300)),
//                    child: SizedBox(
//                        width: 80,
//                        height: 36,
//                        child:
//                        FittedBox(
//                          fit: BoxFit.fitHeight,
//                          child: FlatButton(
//                            child: Text('联系司机',style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(36))),color: Color(0xff6884f1),onPressed: (){
//                          },),
//                        )
//                    ),
//                  ),
                  isFinished?
                  Container(
                    width: ScreenUtil().setWidth(300),
                    child: SizedBox(
                        width: 80,
                        height: 36,
                        child:
                        FittedBox(
                          fit: BoxFit.fitHeight,
                          child: FlatButton(
                            child: Text('确认收货',style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(36))),color: Color(0xff6884f1),onPressed: (){
                          },),
                        )
                    ),
                  ): Container(),
            ]),
          ),
        ],
      ),
    );
  }
}


