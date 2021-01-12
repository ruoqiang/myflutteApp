import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'index_page.dart';
class PublishGoodsDetailPage extends StatefulWidget {
  final id;
  PublishGoodsDetailPage({this.id});

  @override
  _PublishGoodsDetailPageState createState() => _PublishGoodsDetailPageState();
}
class _PublishGoodsDetailPageState extends State<PublishGoodsDetailPage> {

  final List<Map> listDescs1 = [{'label':'货物类型:','value':'设备、牛奶'},{'label':'重量:','value':'10吨'},{'label':'体积:','value':'10立方'},{'label':'装货时间:','value':'2010-02-20'}];
  final List<Map> listDescs2 = [{'label':'车辆类型:','value':'零担 6.2米 厢式 10吨'},{'label':'重量:','value':'10吨'},{'label':'特殊要求:','value':'冷链'}];
  final List<Map> listDescs3 = [{'label':'货到付款','value':''}];

  final List<Map> listDescs4 = [{'label':'货主:','value':'张先生'},{'label':'交易量:','value':'23'},{'label':'好评率:','value':'90%'}];
  var pressAttention = false;

  TextEditingController _payMoneyController = TextEditingController();

  _getOrder(context) {
    print('接单');
//    showToast('接单成功',backgroundColor:Colors.pink,time: 2);
    //打电话
    _launchURL(context);
  }
  //打电话
  void _launchURL(context) async {
    if(_payMoneyController.text == '') {
      return showToast('输入本次装货收取金额');
    }
//    _payMoneyController.clear();
    FocusScope.of(context).unfocus(); //让输入框失去焦点
//    showToast('您的申请已通知货主，货主看到消息后，确认订单后会通知您',backgroundColor: Colors.pink,time: 5);
    _showMyDialog(context);

//    String url = 'tel:'+ '18226796732';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: Text('温馨提示'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('您的申请已通知货主，货主看到消息并确认订单后，会通知您'),
//                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('确认'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(
                    context);
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  fixedAppbar(title:'货源详情'),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(ScreenUtil().setWidth(20)),
          child: SafeArea(
            child: Column(
                children: <Widget>[
                  _adressBox(context),
                  _detailList(context,'货源信息',listDescs1),
                  _detailList(context,'所需车辆信息',listDescs2),
                  _detailList(context,'付款方式',listDescs3),
                  _detailList(context,'货主信息',listDescs4),
                  _myInput('输入本次装货收取金额','请输入本次装货收取金额',_payMoneyController),
                  Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(top: 20,bottom: 30),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 40,
                              child: RaisedButton(
//                                disabledTextColor:Color(0xff2D4ED1),
//                                highlightColor:Color(0xff2D4ED1), //Color(0xff2D4ED1),
                                splashColor:Color(0xff2D4ED1),
                                color: Color(0xff2D4ED1),
                                onPressed: (){
                                  _getOrder(context);
                                  // setState(() => pressAttention = !pressAttention);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)
                                ),
                                textColor:  Colors.white ,//pressAttention ? Colors.white : Color(0xff2D4ED1),
                                child: Text("申请运货"),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ]
            ),
          ),

        ),
      )
    );



  }
}
//获取上一步参数
_selectedBox(BuildContext context,id) {
  return Container(
    child: Text(id),
  );
}


//获取上一步参数
_adressBox(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(bottom: 10),
    color: Colors.white,
    child:  Column(
      children: [
        Container(
          margin: EdgeInsets.only(top:ScreenUtil().setWidth(15)),
          child: Row(children: [
            Image.asset('images/icon_addres_start.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60)),
            Container(
              margin: EdgeInsets.only(left:ScreenUtil().setWidth(10)),
              width: ScreenUtil().setWidth(620),child: Text('上海市闵行区顾戴路  七星路交叉路口向南200米 公交站牌附近'),
            )
          ]),
        ),
        Container(
          margin: EdgeInsets.only(top:ScreenUtil().setWidth(15)),
          child: Row(children: [
            Image.asset('images/icon_addres_end.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60)),
            Container(
              margin: EdgeInsets.only(left:ScreenUtil().setWidth(10)),
              width: ScreenUtil().setWidth(620),child: Text('上海市青浦区徐泾镇  明珠路229号'),
            )
          ]),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 10,left: 5),
          child: Text('运输距离30公里',style: TextStyle(fontSize: ScreenUtil().setSp(28),fontWeight: FontWeight.bold),),
        )
      ],
    ),
  );

}

//详情大列表
_detailList(BuildContext context,title,listDescs) {
  return Container(
    margin: EdgeInsets.only(top:ScreenUtil().setWidth(20)),
    padding: EdgeInsets.only(top:10,bottom: 10),
    color: Colors.white,
    child:  Column(
      children: [
        Container(
          child: Row(children: [
            Container(
              margin: EdgeInsets.only(left:ScreenUtil().setWidth(10)),
              padding: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(bottom:BorderSide(width: 1,color: Colors.black12))
              ),
              width: ScreenUtil().setWidth(670),child: Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(32),fontWeight: FontWeight.w600),),
            )
          ]),
        ),
        Container(
          margin: EdgeInsets.only(top:ScreenUtil().setWidth(15)),
            padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
            child:Table(
              columnWidths: {0:FractionColumnWidth(0.25)},
              children: createTableList2(listDescs)
            )
        )
      ],
    ),
  );

}

createTableList(lists) {
//  return lists.map((item)=>createTableItem(item).toList());
  List<TableRow> Tlist = <TableRow>[];
  dynamic content;
  for (var i = 0; i < lists.length; i++) {
    content = TableRow(
      children: [
        Text(lists[i]['label'].toString()),
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child:  Text(lists[i]['value'].toString()),
        )
      ],
    );
    Tlist.add(content);
  }
  return Tlist;
}
//根据数据创建列表
createTableList2(lists) {
//  return lists.map((item)=>createTableItem(item).toList());
  //1.创建一个空数组并且有返回的组件类型(根据父元素需要的子组件类型)
  List<TableRow> Tlist = [];
  //2.forEach变量，并往1添加子项组件
  lists.forEach((item){
    Tlist.add(createTableItem(item));
  });
//  3.返回
  return Tlist; //可根据需要包裹组件修改外观
}
//创建每列表的每一项布局
createTableItem (item) {
  return TableRow(
    children: [
      Text(item['label'].toString()), //安全起见转一下字符串，如果确保是字符串可以不转
      Container(
        padding: EdgeInsets.only(bottom: 10),
        child:  Text(item['value'].toString()),
      )
    ],
  );
}

// 有输入框的列
Widget _myInput(_lable,_phaceholder,_inputControl){
  return Container(
    margin: EdgeInsets.only(top: 10),
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5),
          padding: EdgeInsets.only(bottom: 10,top: 10),
          decoration: BoxDecoration(
            border: Border(bottom:BorderSide(width: 1,color: Colors.black12)),

          ),
          width: ScreenUtil().setWidth(670),child: Text(_lable,style: TextStyle(fontSize: ScreenUtil().setSp(32),fontWeight: FontWeight.w600),),
        ),
        Container(
            margin: EdgeInsets.only(top:ScreenUtil().setWidth(10)),
            color: Colors.white,
            child:Row(
              children: <Widget>[

              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  child: TextField(
                    controller: _inputControl,
                    keyboardType:TextInputType.number,
                    decoration: InputDecoration(
                      hintText: _phaceholder,
                      border:InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              )
            ],
            )
        )
      ],
    ),
  );



}