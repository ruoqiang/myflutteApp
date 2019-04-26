import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/shopping_cart.dart';
import '../pages/details_page.dart';
import '../pages/login.dart';
Handler detailsHanderl =Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      String goodsId = params['id']?.first;
      print('index>details goodsID is ${goodsId}');
      return DetailsPage(goodsId);
    }
);

Handler loginPageHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params) {
    return LoginPage();
  }
);
Handler ShopCartHandler = Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params) {
      return ShopCart();
    }
);
