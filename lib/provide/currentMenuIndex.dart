import 'package:flutter/material.dart';

class CurrentMenuIndexProvide with ChangeNotifier{
  int currentIndex=1;
  
  changeIndex(int newIndex){
    currentIndex=newIndex;
    notifyListeners();
  }

}