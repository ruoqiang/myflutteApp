import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:url_launcher/url_launcher.dart';
class OrderDetailPage extends StatelessWidget {
  final id;
  OrderDetailPage({this.id});

  final List<Map> listDescs1 = [{'label':'货物类型:','value':'设备、牛奶'},{'label':'重量:','value':'10吨'},{'label':'体积:','value':'10立方'},{'label':'装货时间:','value':'2010-02-20'}];
  final List<Map> listDescs2 = [{'label':'车辆类型:','value':'零担 6.2米 厢式 10吨'},{'label':'重量:','value':'10吨'},{'label':'特殊要求:','value':'冷链'}];
  final List<Map> listDescs3 = [{'label':'货到付款','value':''}];

  final List<Map> listDescs4 = [{'label':'货主:','value':'张三'},{'label':'联系电话:','value':'18226796732'}];
  var pressAttention = false;

  _back(context) {
      Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print('id---------$id');
    String btnText = '已完成';
    Color bColor = Colors.green;
    if(id ==0) {
      btnText = '已完成';
       bColor = Colors.green;
    } else if(id ==1) {
      btnText = '进行中';
       bColor = Colors.deepOrange;
    }
    return Scaffold(
      appBar:  fixedAppbar(title:'运单详情'),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(ScreenUtil().setWidth(20)),
          child: SafeArea(
            child: Column(
                children: <Widget>[
                  _OrderStatus(btnText,bColor),
                  _adressBox(context),
                  _detailList(context,'货源信息',listDescs1),
                  _detailList(context,'所需车辆信息',listDescs2),
                  _detailList(context,'付款方式',listDescs3),
                  _detailList(context,'联系方式',listDescs4),
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
                                  _back(context);
                                  // setState(() => pressAttention = !pressAttention);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)
                                ),
                                textColor:  Colors.white ,//pressAttention ? Colors.white : Color(0xff2D4ED1),
                                child: Text("返回"),
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
        )
      ],
    ),
  );


}

_OrderStatus (Txt,backGroundColor) {
  return Container(
    margin: EdgeInsets.only(bottom:ScreenUtil().setWidth(20)),
    padding: EdgeInsets.only(top:10,bottom: 10),
    color:Colors.white,
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 5),
            child: Text(Txt,style: TextStyle(color: backGroundColor,fontSize: ScreenUtil().setWidth(40)),),
          )
      )],
    )
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

