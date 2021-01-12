import 'package:flutter/material.dart';
import './router_handler.dart';
import 'package:fluro/fluro.dart';

class Routes{
  static String root='/';
  static String detailsPage = '/detail';
  static String loginPage = '/login';
  static String ShopCartPage = '/shopCartPage';
  static void configureRoutes(router){
    router.notFoundHandler= new Handler(
        handlerFunc: (BuildContext context,Map<String,List<String>> params){
          print('ERROR====>ROUTE WAS NOT FONUND!!!');
        }
    );

    router.define(root,handler: detailsHanderl);
    router.define(detailsPage,handler: detailsHanderl);
    router.define(loginPage,handler: loginPageHandler);
  }

}