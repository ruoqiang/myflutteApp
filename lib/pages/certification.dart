import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:myflutterapp/common/http.dart';
import 'package:myflutterapp/pages/index_page.dart';
import 'package:myflutterapp/pages/my_page.dart';
import 'package:myflutterapp/pages/user_carinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base_widgit/nextButton.dart';


class CertificationPage extends StatefulWidget {
  @override
  _CertificationPageState createState() => _CertificationPageState();
}

class _CertificationPageState extends State<CertificationPage> {
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

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _cardNumController = TextEditingController();

  File _uploadImage1;
  File _uploadImage2;
  final picker = ImagePicker();


  goToNextPage2() async {
    if (_uploadImage1== null) {
      return showToast("请上身份证正面照片");
    }
//    if (_usernameController.text == '') {
//      return showToast("请输入姓名");
//    }
//    if (_cardNumController.text == '') {
//      return showToast("请输入身份证号");
//    }
    SharedPreferences _prefs =  await SharedPreferences.getInstance();
    _prefs.setBool('isCertified',true);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) {
        return IndexPage();
      }),(check) => false
    );
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
      appBar: fixedAppbar(title: '用户信息认证'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _formCarImgList(),
            _formcarBaseInfoBox(),
            NextButton(text: '提交', ButtonClick: goToNextPage2)
          ],
        ),
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
            '申请人信息', style: TextStyle(fontSize: ScreenUtil().setSp(32)),)),
          _formList(_labelAndInput('姓名:', '请输入姓名', _usernameController)),
          _formList(_labelAndInput('身份证号:', '请输入身份证号', _cardNumController))
        ],
      ),
    );
  }

  Widget _formCarImgList() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _formList(Text(
            '用户身份证照片信息', style: TextStyle(fontSize: ScreenUtil().setSp(32)),)),
          _carImgList()
        ],
      ),
    );
  }

  Widget _carImgList() {
    return Container(
      color: Color(0xffffffff),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              _pickImage(0);
            },
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  _uploadImage1 ==null ?
                  Image.asset('images/car_info_defaul01.png', height: 140,
                    width: 140,): Container(
                    decoration:BoxDecoration(
                      border:Border.all(color: Colors.black12,width: 1), //底部border
                    ),
                    child: Image.file(_uploadImage1, height: 140,width: 140,),
                  ),
                  Container(
                    child: Text('上传身份证正页照'), margin: EdgeInsets.only(top: 10),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //
              _pickImage(1);
            },
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  _uploadImage2 == null ? Image.asset('images/car_info_defaul02.png', height: 140,width: 140,)
                      :
                  Container(
                    decoration:BoxDecoration(
                      border:Border.all(color: Colors.black12,width: 1), //底部border
                    ),
                    child: Image.file(_uploadImage2, height: 140,width: 140,),
                  ),
                  Container(
                    child: Text('上传身份证反页照'), margin: EdgeInsets.only(top: 10),)
                ],
              ),
            ),
          )
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




  _pickImage(index) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          height: 160,
          child: Column(
            children: <Widget>[
              _item('拍照', true,index),
              _item('从相册选择', false,index),
            ],
          ),
        ));
  }
  _item(String title, bool isTakePhoto,index) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(isTakePhoto ? Icons.camera_alt : Icons.photo_library),
        title: Text(title),
        onTap: () => getImage(isTakePhoto,index),
      ),
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
