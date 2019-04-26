import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myflutterapp/common/http.dart';
import 'package:provide/provide.dart';
import '../provide/count.dart';
class ShopCart extends StatefulWidget {
  @override
  _ShopCartState createState() => _ShopCartState();
}

class _ShopCartState extends State<ShopCart> {
  var list = [];
  var count = 0;
  @override
  void initState() {
    _getGoodList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var provideCout = Provide.value<Counter>(context);
    print(provideCout.value);
    setState(() {
      count = provideCout.value;
    });
    return Scaffold(
      appBar: AppBar(title: Text('My 消息Page')),
      body: Column(
        children: <Widget>[
          SafeArea(child: Text('ListView创建列表${count}',style: TextStyle(fontSize: 25,),),),
          Expanded(
            flex:1,
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context,index) {
                  return _listItem(list[index]);
                }
            ),
          ),
        ],
      ),
    );


  }

  void _getGoodList()async {
    var data={
      'categoryId':'4',
      'categorySubId':"",
      'page':1
    };
    await request('getMallGoods',formData:data ).then((val){
      var data = json.decode(val.toString());
      print('分类商品列表：>>>>>>>>>>>>>-----------------------------------${data}');
      setState(() {
//        list = data['data'];
        list = (data['data'] as List).cast(); //cast方式 访问字段属性是使用中括号 item['presentPrice']  model.formJson方式使用点符号  item.presentPrice ------->2中属性访问一种不行，就换一种
      });
    });
  }

  Widget _goodsImage(image) {
    return Container(
      width: 100,
      child: Image.network(image),
    );
  }
  Widget _goodsName(name){
    return Container(
      padding: EdgeInsets.all(5.0),
      width: 250,
      color: Colors.pinkAccent,
      child: Text(
        name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize:20),
      ),
    );
  }
  Widget _goodsPrice(price,oriPrice) {
    return Container(
        child:Row(
            children: <Widget>[
              Text(
                '价格:￥$price',
                style: TextStyle(color:Colors.pink,fontSize:20),
              ),
              Text(
                '￥$oriPrice',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize:16,
                    decoration: TextDecoration.lineThrough
                ),
              )
            ]
        )
    );
  }

  Widget _listItem(item) {
    return InkWell(
      onTap: (){
        print('ddddddddddddddddddddddddd');
        setState(() {
          count = Provide.value<Counter>(context).value; //手动获取状态          ------>注：   如果想不同页面直接动态绑定实时更新同一状态需要使用Provide<Counter>(builder： 模板关联
        });
      },
      child: Provide<Counter>(
//        builder: (context, child, counter) => Text('${counter.value}'),
        builder: (context, child, counter) {
          return  Container(
            width: 500,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(width: 1,color:Colors.black12 )
                )
            ),
            child: Row(
              children: <Widget>[
                _goodsImage(item['image']),
                Column(
                  children: <Widget>[
                    _goodsName(item['goodsName']),
                    _goodsPrice(item['presentPrice'], item['oriPrice']),
                    Text('${counter.value}')
                  ],
                ),
              ],
            ),
          );
        },
      ),


    );
  }
}
