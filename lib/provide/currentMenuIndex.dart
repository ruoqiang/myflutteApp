import 'package:flutter/material.dart';

class CurrentMenuIndexProvide with ChangeNotifier{
  int value=0;
  
  changeIndex(int newIndex){
    value=newIndex;
    notifyListeners();
  }

}