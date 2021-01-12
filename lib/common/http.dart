import 'dart:io';
import 'package:dio/dio.dart';
import 'package:myflutterapp/common/config.dart';
import '../base_widgit/showToast.dart';


Future request(url, {formData}) async {
  try {
    print('开始获取数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = "application/x-www-form-urlencoded";
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>$e');
  }
}

Future post(url, {formData}) async {
  try {
    print('开始获取数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType ="application/x-www-form-urlencoded";
    if (formData == null) {
      response = await dio.post(apiUrl + url);
    } else {
      response = await dio.post(apiUrl + url, data: formData);
    }
    if (response.statusCode == 200) {
      //如果返回的结果是issuccess为false
      if(response.data['issuccess'] ==false) {
        showToast(response.data['message']);
      }
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>$e');
  }
}
