import 'package:flutter/material.dart';
class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: <Widget>[
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
            Row(
              children: <Widget>[
                FractionallySizedBox(
                  child: SafeArea(child: Text('ListView创建列表${goodsId}',style: TextStyle(fontSize: 25,),),),
                )
              ],
            ),
              Expanded(
                flex: 1,
                child: Container(

                  child:Text('商品ID为：${goodsId}',style: TextStyle(color: Colors.blue),),
                  decoration: BoxDecoration(

                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}