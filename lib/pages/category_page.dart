import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_mall/models/category.dart';
import '../service/service_url.dart';
import '../config/service_url.dart';


class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('分类导航'),),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {

  List itemList = [];

  @override
  void initState() {
    _loadCategoryData();
    super.initState();
  }

  void _loadCategoryData() {

    getRequestData(servicePath['category']).then((data){
      CategoryType categoryData = CategoryType.fromJson(data);
      setState(() {
        this.itemList = categoryData.dataList;
      });
    });
  }

  Widget _categoryItem(int index) {
    return
      InkWell(
        onTap: (){},
        child: Container(
          height: ScreenUtil().setHeight(100),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black26, width: 1))
          ),
          padding: EdgeInsets.only(top: 15, left: 15),
          child:Text(itemList[index].mallCategoryName)
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.black26, width: 1))
      ),
      child: ListView.builder(
        itemCount: itemList == null ? 0 : itemList.length,
        itemBuilder: (context, index){
          return _categoryItem(index);
        },
      ),
    );
  }
}


class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  final List<String> itemList = ['键盘', '鼠标', '显示器', '笔记本', '兼容机', '散热器', 'test'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12)
        )
      ),
      width: ScreenUtil().setWidth(570),
      height: ScreenUtil().setHeight(80),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return _CategoryBtn(itemList[index]);
        },
      ),

    );
  }

  Widget _CategoryBtn(String btnText) {
    return InkWell(
      onTap: (){
        print('1111111');
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(width: 1, color: Colors.black12)
          )
        ),
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
//        height: ScreenUtil().setHeight(80),
        child: Text(btnText, style: TextStyle(fontSize: ScreenUtil().setSp(25.0)),),
      ),
    );
  }
}


