import 'package:flutter/material.dart';
import '../service/service_url.dart';
import '../config/service_url.dart';


class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  void initState() {
    _loadCategoryData();
    super.initState();
  }

  void _loadCategoryData() async {
    var data = await getRequestData(servicePath['category']);
    print('分类数据加载完成${data.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('分类页面'),
      ),
    );
  }
}

