import 'dart:io';

import 'package:dio/dio.dart';
import 'dart:async';


Future getRequestData(String url, {formData}) async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/json');
    if(formData != null){
      response = await dio.get(url, queryParameters: formData);
    } else {
      response = await dio.get(url);
    }

    if(response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('接口请求错误:${response.statusCode}');
    }
  } catch(e) {
    return print('===================error===========================$e');
  }
}