import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:myflutterapp/common/http.dart';
import 'package:myflutterapp/pages/user_carinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_car_base_info.dart';



class CarListPage extends StatefulWidget {
  @override
  _CarListPageState createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {

  final List<Map> lists = [
    {'carNum':'沪B12345:','desc':'长度：6.5米   载重：5000吨   容积：20立方米','index':0},
    {'carNum':'沪AQ2375:','desc':'长度：4.5米   载重：3000吨   容积：10立方米','index':1},
    {'carNum':'粤AQ2375:','desc':'长度：5.5米   载重：4000吨   容积：15立方米','index':2},
    {'carNum':'苏AQ2375:','desc':'长度：8.5米   载重：7000吨   容积：30立方米','index':3}];

  _addCar() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddCarBaseInfoPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fixedAppbar(title:'我的车库'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            BottomListBox(lists),
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
                            _addCar();
                            // setState(() => pressAttention = !pressAttention);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)
                          ),
                          textColor:  Colors.white ,//pressAttention ? Colors.white : Color(0xff2D4ED1),
                          child: Text("添加车辆"),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget BottomListBox (BottomListBox){
    return Container(
//      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        children: createdList(lists),
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
                Image.asset('images/img01.png',width: ScreenUtil().setWidth(100), height:ScreenUtil().setWidth(100)),
                Container(
//                  color: Colors.pink,
                    width: ScreenUtil().setWidth(540),
                    margin: EdgeInsets.only(left: 8),
//                    color: Colors.pink,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['carNum']),
                        Text('长度：6.5米  载重：5000吨  容积：20立方米 ',),
                      ],
                    )
                )
              ],
            ),
            Positioned(child: Icon(Icons.keyboard_arrow_right),right: 0,top:14)
          ],
        )
      )
    );
  }

}


