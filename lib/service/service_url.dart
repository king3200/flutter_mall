import 'dart:io';

import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url.dart';

Future getHomePageContent() async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/json');
    response = await dio.get(servicePath['homePageContent']);
    if(response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('接口请求错误:${response.statusCode}');
    }
  } catch(e) {
    return print('===================error===========================$e');
  }
}