import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:myflutterapp/common/http.dart';
import 'package:myflutterapp/pages/user_carinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base_widgit/nextButton.dart';


class AddCarOtherInfoPage extends StatefulWidget {
  @override
  _AddCarOtherInfoState createState() => _AddCarOtherInfoState();
}

class _AddCarOtherInfoState extends State<AddCarOtherInfoPage> {
  var _inputController;

//  var _nameController;
//  var _idNumberController;
//  var _mobileController;
//  var _inviteController;

  //输入框控制器
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idNumberController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _inviteController = TextEditingController();
  var sex = 1;
  var isSelf = false;
  TextEditingController _carOwnerNameController = TextEditingController();
  TextEditingController _carOwnerIDNumController = TextEditingController();
  TextEditingController _carOwnerPhoneController = TextEditingController();

  RegExp mobileExp = RegExp(
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');

  goToNextPage2() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return UserCarInfoPage();
      }),
    );
  }

  goToNextPage() async {
    print({'姓名': _nameController, '密码': _nameController.text});
    if (_nameController.text == '') {
      showToast("请输入姓名");
      return;
    }
//    if(_idNumberController.text == ''){
//      showToast("请输入身份证号");
//      return;
//    }
//    if(_mobileController.text == ''){
//      showToast("请输入手机号码");
//      return;
//    }
//    if(mobileExp.hasMatch(_mobileController.text)==false) {
//      showToast('请输入正确格式的手机号码');
//      return;
//    }


    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    var api = 'SubInfo/UserAndCar';
    var params = {
      'data': {
        'Step': 1,
        'CCustomerApply': {
          "Name": _nameController.text,
          "Sex": this.sex,
          "IDNumber": _idNumberController.text,
          "Phone": _mobileController.text,
          "Inviter": _inviteController.text,
          "IsOwnerApply": this.isSelf,
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

  File _uploadImage1;
  File _uploadImage2;
  final picker = ImagePicker();

  /// *
  /// isTakePhoto:是否为拍照
  /// selectedIndex列表显示图片的索引
  ///**/
  Future getImage(isTakePhoto,selectedIndex) async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(source: isTakePhoto ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        if(selectedIndex ==0) {
          _uploadImage1 = File(pickedFile.path);
        } else if(selectedIndex ==1) {
          _uploadImage2 = File(pickedFile.path);
        }


      } else {
        print('No image selected.');
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fixedAppbar(title: '车辆基础信息'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _headeText(),
            _headeLine(),
            _formcarBaseInfoBox(),
            NextButton(text: '提交', ButtonClick: goToNextPage)
          ],
        ),
      ),
    );
  }

  Widget _headeText() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('车辆基础信息',),
          Container(
            margin: EdgeInsets.only(left: 82, right: 2),
            child: Text('车辆其他信息',style: TextStyle(color: Color(0xff2D4ED1), fontSize: 14),),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 20,
              height: 20,
              color: Colors.black12,
            ),
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
          Image.asset('images/index_apply_icon_choose_blue.png', width: 20,),

        ],
      ),
    );
  }

  Widget _formBox() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _formList(Text('其他信息')),
          _formList(_labelAndInput('车牌颜色', '请输入车牌颜色', _nameController)),
          _formList(_labelAndInput('车牌号', '请输入车牌号', _nameController)),
          _formList(_labelAndInput('发动机号', '请输入发动机号', _nameController)),
          _formList(_labelAndInput('车辆识别代码', '请输入车辆识别代码', _nameController)),
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
            '其他信息', style: TextStyle(fontSize: ScreenUtil().setSp(32)),)),
          _formList(_labelAndInput('载货长度（车身长度）:', '请输入车牌颜色', _nameController)),
          _formList(_labelAndInput('其他长度:', '请输入其他长度', _nameController)),
          _formList(_labelAndInput('车辆类型:', '请输入车辆类型', _nameController)),
          _formList(_labelAndInput('货运类型:', '请输入货运类型', _nameController)),
          _formList(_labelAndInput('载重:', '请输入载重', _nameController)),
          _formList(_labelAndInput('容积:', '请输入载重', _nameController)),
          
        ],
      ),
    );
  }



  Widget _formList(widgit) {
    return Container(
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
          )
        ],
      ),
    );
  }

  // 有输入框的列
  Widget _labelAndInput(_lable, _phaceholder, _inputControl) {
    return Row(children: <Widget>[
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
      )
    ],
    );
  }


//  带验证码，输入框的列
  Widget _labelAndInputYzm(_lable, _phaceholder, _inputControl) {
    return Row(children: <Widget>[
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
        child: Text('获取验证码', style: TextStyle(color: Color(0xff108EE9)),),
      )
    ],
    );
  }
}
