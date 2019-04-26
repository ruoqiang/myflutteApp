import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myflutterapp/common/http.dart';
import '../model/goods_list_model.dart';

class UserCenterPage extends StatefulWidget {
  @override
  _UserCenterPageState createState() => _UserCenterPageState();
}

class _UserCenterPageState extends State<UserCenterPage> {
  var list = [];
  void _getGoodList() async {
    var data = {
      'categoryId': '4',
      'categorySubId': "",
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      print('分类商品列表：>>>>>>>>>>>>>-----------------------------------3333${data}');
      GoodsListModel goodsList = GoodsListModel.fromJson(data);
      setState(() {
//        list = (data['data'] as List).cast();
      list = goodsList.data;
      });
    });
  }
  @override
  void initState() {
    _getGoodList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('ListView model创建列表',style: TextStyle(fontSize: 25,),),
        Expanded(
          flex:1,
          child:ListView.builder(
              itemCount: list.length,
              itemBuilder: (context,index) {
                return _listItem(list[index]);
              }
          ),
        ),
//        Container(
////      child: Text('shopping_cart'),
//          width: 400,
//          height: 550,
//          child: ListView.builder(
//              itemCount: list.length,
//              itemBuilder: (context,index) {
//                return _listItem(list[index]);
//              }
//          ),
//        )
      ],
    );
  }


  Widget _goodsImage(image) {
    return Container(
      width: 100,
      child: Image.network(image),
    );
  }

  Widget _goodsName(name) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: 250,
      color: Colors.pinkAccent,
      child: Text(
        name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _goodsPrice(price, oriPrice) {
    return Container(
        child: Row(
            children: <Widget>[
              Text(
                '价格:￥$price',
                style: TextStyle(color: Colors.pink, fontSize: 20),
              ),
              Text(
                '￥$oriPrice',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 16,
                    decoration: TextDecoration.lineThrough
                ),
              )
            ]
        )
    );
  }

  Widget _listItem(item) {
    return Container(
      width: 500,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 1, color: Colors.black12)
          )
      ),
      child: Row(
        children: <Widget>[
          _goodsImage(item.image),
          Column(
            children: <Widget>[
              _goodsName(item.goodsName),
              _goodsPrice(item.presentPrice, item.oriPrice)
            ],
          ),
        ],
      ),
    );
  }
}
class GetBuildButton extends StatelessWidget {
  final List items;
  // final mylist = [{'icon':Icons.call,"label":'CALL1d'},{'icon':Icons.near_me,"label":'CALL1d2'},{'icon':Icons.share,"label":'CALL1d3'}];
  GetBuildButton({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index){
        return buildButtonColumn(items[index]['icon'],items[index]['label']);
      },
    ),
    );
  }
}

 buildButtonColumn(IconData icon, String label) {
      Color color = Colors.blue;
      return new Container(
        color: Colors.pink,
        child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          new Icon(icon, color: color),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
                
              ),
            ),
          ),
        ],
      ),
      );
    }