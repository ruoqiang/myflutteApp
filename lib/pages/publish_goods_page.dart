import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:myflutterapp/common/http.dart';
import 'package:myflutterapp/pages/add_car_other_info.dart';
import 'package:myflutterapp/pages/user_carinfo.dart';
import 'package:myflutterapp/provide/currentMenuIndex.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base_widgit/nextButton.dart';
import 'package:flutter_my_picker/flutter_my_picker.dart';
import 'package:flutter_my_picker/common/date.dart';
var _controller;
// ignore: camel_case_types
class PublishGoodsPage extends StatefulWidget {
  final changePage;
  PublishGoodsPage({this.changePage});



  @override
  _PublishGoodsPageState createState() => _PublishGoodsPageState();


}

class _PublishGoodsPageState extends State<PublishGoodsPage> {
  @override
  void didChangeDependencies() {
    print('------didChangeDependencies-------');
    super.didChangeDependencies();
  }

  //输入框控制器
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idNumberController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _inviteController = TextEditingController();

  TextEditingController _carOwnerNameController = TextEditingController();
  TextEditingController _carOwnerIDNumController = TextEditingController();
  TextEditingController _carOwnerPhoneController = TextEditingController();

  RegExp mobileExp = RegExp(
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');

  TextEditingController _addressStartController = TextEditingController();
  TextEditingController _addressEndController = TextEditingController();
  TextEditingController _goodsTypeController = TextEditingController();
  TextEditingController _goodsWeightController = TextEditingController();

  DateTime date;
  String dateStr ='请选择装货时间';
  @override
  initState()  {
    super.initState();
//    DateTime _date = new DateTime.now();
//    print(MyDate.format('yyyy-MM-dd HH:mm:ss', _date));
//    setState(() {
//      date = _date;
//      dateStr = MyDate.format('yyyy-MM-dd HH:mm:ss', _date);
//    });
  }

  _change(formatString) {
    return (_date) {
      setState(() {
        date = _date;
        dateStr = MyDate.format(formatString, _date);
      });
    };
  }

  showPicker() {
    if(dateStr =='请选择装货时间') {
      DateTime _date = new DateTime.now();
      print(MyDate.format('yyyy-MM-dd HH:mm', _date));
      setState(() {
        date = _date;
        dateStr = MyDate.format('yyyy-MM-dd HH:mm', _date);
      });
    }
    MyPicker.showDateTimePicker(
      context: context,
      current: date,
      magnification: 1.2,
      squeeze: 1.45,
      offAxisFraction: 0.2,
      onChange: _change('yyyy-MM-dd HH:mm'),
    );

  }



  goToNextPage2() {
    print('goToNextPage2点击了：>>>>>>>>>>>>>-----------------------------------');
    if (_addressStartController.text == '') {
      return showToast("发货开始位置不能为空");
    }
    if (_addressEndController.text == '') {
      return showToast("发货结束位置不能为空");
    }
    if (_goodsTypeController.text == '') {
      return showToast("请输入货物类型");
    }
    if (_goodsWeightController.text == '') {
      return showToast("请输入货物重量");
    }
    print('$_goodsTypeController');
//    setState(() {
//      _goodsTypeController.text = '';
//    });

    widget.changePage(1);
    showToast("发布成功",backgroundColor: Colors.blueAccent);

//    Provide.value<CurrentMenuIndexProvide>(context).changeIndex(1);
//    var currentindex = Provide.value<CurrentMenuIndexProvide>(context).currentIndex;
//    print('currentindex：>>>>>>>>>>>>>-----------------------------------$currentindex');

    FocusScope.of(context).unfocus();
  }

  goToNextPage() async {
    print({'姓名': _nameController, '密码': _nameController.text});
    if (_nameController.text == '') {
      showToast("请输入姓名");
      return;
    }

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    var api = 'SubInfo/UserAndCar';
    var params = {
      'data': {
        'Step': 1,
        'CCustomerApply': {
          "Name": _nameController.text,
          "IDNumber": _idNumberController.text,
          "Phone": _mobileController.text,
          "Inviter": _inviteController.text,
          "CarOwnerName": _carOwnerNameController.text,
          "CarOwnerIDNum": _carOwnerIDNumController.text,
          "CarOwnerPhone": _carOwnerPhoneController.text,
          "Relation": "11111"
        }
      },
      'token': token
    };
    print('dddddd：>>>>>>>>>>>>>-----------------------------------$params');
    await post('SubInfo/CheckStep', formData: params).then((val) {
      print('dddddd：>>>>>>>>>>>>>-----------------------------------$val');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return UserCarInfoPage();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
//    Provide.value<CurrentMenuIndexProvide>(context).changeIndex(1);
    var currentindex = Provide.value<CurrentMenuIndexProvide>(context).currentIndex;
    print('currentindex：>>>>>>>>>>>>>-----------------------------------$currentindex');

    return  Provide<CurrentMenuIndexProvide>(

        builder: (context,child,val){
          return Scaffold(
            appBar: fixedAppbar(title: '发布货源'),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _formStartEndAdress(),
                  _formcarBaseInfoBox(),
                  _formcarBaseInfoBox2(),
                  _formcarBaseInfoBox3(),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
//              child: _nextButton(),
//                    child: NextButton(text: '发布${val.currentIndex}',ButtonClick:(){
                      child: NextButton(text: '发布',ButtonClick:(){
//                      Provide.value<CurrentMenuIndexProvide>(context).changeIndex(1);
                      goToNextPage2();
                    },),
                  )
                ],
              ),
            ),
          );
        });

  }

  Widget _headeText() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '车辆基础信息',
            style: TextStyle(color: Color(0xff2D4ED1), fontSize: 14),
          ),
          Container(
            margin: EdgeInsets.only(left: 82, right: 2),
            child: Text('车辆其他信息'),
          ),
        ],
      ),
    );
  }

  Widget _headeLine() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/index_apply_icon_choose_blue.png',
            width: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 2, right: 2),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            width: 140,
            height: 0,
            child: Text('', textAlign: TextAlign.center),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 20,
              height: 20,
              color: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _formBox() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _formList(Text('基础信息')),
          _formList(_labelAndInput('车牌颜色', '请输入车牌颜色',inputControl: _nameController)),
          _formList(_labelAndInput('车牌号', '请输入车牌号',inputControl: _nameController)),
          _formList(_labelAndInput('发动机号', '请输入发动机号',inputControl: _nameController)),
          _formList(_labelAndInput('车辆识别代码', '请输入车辆识别代码',inputControl: _nameController)),
//          _formList(_labelAndInputYzm('验证码','请输入验证码',_inputController)),
        ],
      ),
    );
  }

  Widget _formcarBaseInfoBox() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _formList(Text(
            '货源信息',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(32), fontWeight: FontWeight.w500),
          )),
          _formList(_labelAndInput('货物类型:', '请输入货物类型', inputControl:_goodsTypeController)),
          _formList(_labelAndInput('重量:', '请输入重量', inputControl:_goodsWeightController,type: TextInputType.number)),
          _formList(_labelAndInput('体积:', '请输入体积', inputControl:_goodsWeightController))
        ],
      ),
    );
  }

  Widget _formcarBaseInfoBox2() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _formList(Text(
            '基本信息',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(32), fontWeight: FontWeight.w500),
          )),
          _formList(_labelAndInput('装货时间:', '请输入装货时间', isNotInput: true,isNotInputChild: GestureDetector(
            onTap: (){print('装货时间');showPicker();},
            child: Text('${dateStr ?? MyDate.format('yyyy-MM-dd HH:mm:ss', date)}'),
          ))),
          _formList(_labelAndInput('付款方式:', '请输入付款方式', inputControl:_goodsWeightController)),
          _formList(_labelAndInput('联系人:', '请输入联系人', inputControl:_goodsWeightController)),
          _formList(_labelAndInput('联系电话:', '请输入联系电话', inputControl:_goodsWeightController,type: TextInputType.phone)),
        ],
      ),
    );
  }

  Widget _formcarBaseInfoBox3() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _formList(Text(
            '所需车源',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(32), fontWeight: FontWeight.w500),
          )),
          _formList(_labelAndInput('车辆类型:', '请输入车辆类型', inputControl:_goodsWeightController)),
          _formList(_labelAndInput('特殊要求:', '请输入特殊要求',inputControl: _goodsWeightController))
        ],
      ),
    );
  }

  Widget _formStartEndAdress() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _formList(Text(
            '发货起始位置',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(32), fontWeight: FontWeight.w500),
          )),
          _formList(
              _labelAndInput('发货开始位置:', '请输入发货开始位置', inputControl:_addressStartController),hasOtherChild: true,OtherChild:Container(
            height: 44,
            padding: EdgeInsets.only(left: 20,right: 20),
            child: InkWell(
              onTap: () {
                print('点击了地图1');
              },
              child: Image.asset('images/icon_addres_start.png',width: ScreenUtil().setWidth(50),height: ScreenUtil().setWidth(50)),
            ),
          )),
          _formList(_labelAndInput('发货结束位置:', '请输入发货结束位置',inputControl: _addressEndController),hasOtherChild: true,OtherChild:Container(
            height: 44,
            padding: EdgeInsets.only(left: 20,right: 20),
            child: InkWell(
              onTap: () {
                print('点击了地图2');
              },
              child: Image.asset('images/icon_addres_end.png',width: ScreenUtil().setWidth(50),height: ScreenUtil().setWidth(50)),
            ),
          )
          )
        ],
      ),
    );
  }

  Widget _formList(widgit, {hasOtherChild=false,OtherChild}) {
    return Stack(
      children: [
        Container(
          color: Color(0xffffffff),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  height: 46,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black12),
                    ),
                  ),
                  child: widgit,
                ),
              ),
            ],
          ),
        ),
        hasOtherChild ==true? Positioned(
          right: 0,
          top: 0,
          child: OtherChild,
        ) : Text('')
      ],
    );
  }

  // 有输入框的列
  Widget _labelAndInput(_lable, _phaceholder, {inputControl,type = TextInputType.text,isNotInput = false,isNotInputChild}) {
    return Row(
      children: <Widget>[
        Text(_lable),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 15),
            child: isNotInput ==false ? TextField(
              controller: inputControl,
              keyboardType:type,
              decoration: InputDecoration(
                hintText: _phaceholder,
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 14),
            ) : isNotInputChild,
          ),
        )
      ],
    );
  }

//  带验证码，输入框的列
  Widget _labelAndInputYzm(_lable, _phaceholder, _inputControl) {
    return Row(
      children: <Widget>[
        Text(_lable),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 15),
            child: TextField(
              controller: _inputControl,
              decoration: InputDecoration(
                hintText: _phaceholder,
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          height: 46,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 1.0, color: Colors.black12),
            ),
          ),
          child: Text(
            '获取验证码',
            style: TextStyle(color: Color(0xff108EE9)),
          ),
        )
      ],
    );
  }

  //按钮
  Widget _nextButton(){
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 40,bottom: 20),
            padding: EdgeInsets.only(left: 15,right: 15),
            height: 40,
            child: RaisedButton(
              color:Color(0xff2D4ED1) ,
              onPressed: (){
                goToNextPage2();
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) {
//                  return UserBaseInfoPage();
//                }),
//              );
              },
//            textColor: Color(0xff2D4ED1),
              child: Text("发布",style: TextStyle(fontSize: 16,color: Colors.white),),
            ),
          ),
        )
      ],
    );
  }


}


