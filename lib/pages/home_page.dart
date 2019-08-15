import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../service/service_url.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/service_url.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print('1111111111111111');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    print('屏幕像素密度${ScreenUtil.pixelRatio}');
//    print('屏幕宽度${ScreenUtil.screenWidth}');
//    print('屏幕高度${ScreenUtil.screenHeight}');

    return Scaffold(
      appBar: AppBar(
        title: Text('12320预约体检'),
      ),
      body: FutureBuilder(
        future: getRequestData(servicePath['homePageContent']),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map> swiperData = (snapshot.data['swiper_data'] as List).cast();
            List categoryData = (snapshot.data['category_data'] as List).cast();
            String adPicture = snapshot.data['ad_banner'];
            Map<String, dynamic> phoneBanner =
                snapshot.data['phone_banner'] as Map<String, dynamic>;
            List<Map> recommandData = (snapshot.data['recommand'] as List).cast();
            Map<String, dynamic> floorData = snapshot.data['floor_data'];
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TDSwiper(swiperData: swiperData),
                  CategoryBtnGroup(categoryData: categoryData),
                  AdBanner(
                    adPicture: adPicture,
                  ),
                  PhoneBanner(
                    phoneBannerPhone: phoneBanner['phone_num'],
                    phoneBannerPic: phoneBanner['img'],
                  ),
                  RecommandBanner(recommandData: recommandData),
                  FloorBanner(floorData: floorData),
                  HotAreaBanner(),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('正在加载数据'),
            );
          }
        },
      ),
    );
  }
}

// 轮播组件
class TDSwiper extends StatelessWidget {
  final List swiperData;

  TDSwiper({this.swiperData}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiperData.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperData[index]['img']}",
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//导航组件
class CategoryBtnGroup extends StatelessWidget {
  List categoryData;

  CategoryBtnGroup({Key key, this.categoryData}) : super(key: key);

  Widget _btnGroupItem(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('你点击了${item['name']}');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['img'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['name']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: categoryData.map((item) {
          return _btnGroupItem(context, item);
        }).toList(),
      ),
    );
  }
}

//广告区域
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(100),
      child: Image.network(adPicture),
    );
  }
}

//电话区域
class PhoneBanner extends StatelessWidget {
  final String phoneBannerPic;
  final String phoneBannerPhone;

  PhoneBanner({Key key, this.phoneBannerPic, this.phoneBannerPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _onTap,
        child: Image.network(this.phoneBannerPic),
      ),
    );
  }

  void _onTap() async {
    String url = 'tel:' + this.phoneBannerPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw Exception('url有误不能调用打开电话界面');
    }
  }
}

//商品推荐
class RecommandBanner extends StatelessWidget {
  List<Map> recommandData;

  RecommandBanner({Key key, this.recommandData}) : super(key: key);

  Widget _recommandText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pinkAccent),
      ),
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
    );
  }

  Widget _recommandItem(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        child: Column(
          children: <Widget>[
            Image.network(recommandData[index]['img']),
            Text('${recommandData[index]['price']}'),
            Text(
              '${recommandData[index]['price_origin']}',
              style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ItemList() {
    return Container(
      height: ScreenUtil().setHeight(350),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _recommandItem(index);
        },
        itemCount: recommandData.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_recommandText(), _ItemList()],
      ),
    );
  }
}

//楼层组件
class FloorBanner extends StatelessWidget {
  Map floorData;

  FloorBanner({Key key, this.floorData}) : super(key: key);

  Widget _getHeader() {
    String headImgUrl = floorData['header']['img'];
    return Container(
      width: ScreenUtil().setWidth(750.0),
      child: Image.network(headImgUrl),
    );
  }

  Widget _getFloorItem(Map itemData) {
    return Container(
      width: ScreenUtil().setWidth(375.0),
      child: Column(
        children: <Widget>[Image.network(itemData['img'])],
      ),
    );
  }

  Widget _getFloor1() {
    Map mainData = floorData['main'];
    List otherData = floorData['other'];

    return Container(
      width: ScreenUtil().setWidth(750.0),
      child: Row(
        children: <Widget>[
          _getFloorItem(mainData),
          Column(
            children: <Widget>[
              _getFloorItem(otherData[0]),
              _getFloorItem(otherData[1]),
            ],
          )
        ],
      ),
    );
  }

  Widget _getFloor2() {
    List otherData = floorData['other'];

    return Container(
      width: ScreenUtil().setWidth(750.0),
      child: Row(
        children: <Widget>[_getFloorItem(otherData[2]), _getFloorItem(otherData[3])],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _getHeader(),
          _getFloor1(),
          _getFloor2(),
        ],
      ),
    );
  }
}


class HotAreaBanner extends StatefulWidget {
  @override
  _HotAreaBannerState createState() => _HotAreaBannerState();
}

class _HotAreaBannerState extends State<HotAreaBanner> {

  int page = 0;
  List itemList = [];

  @override
  void initState() {
    getRequestData(servicePath['hotContent'], formData: {'page': page}).then((val){
      print('火爆专区数据获取完成:${val}');
      setState(() {
        itemList.addAll(val);
      });
    });

    super.initState();
  }

  Widget _getHeader() {
    return Container(
      alignment: Alignment.center,
      child: Text('火爆专区'),
    );
  }

  List<Widget> _getWrapList() {

    if(itemList.length > 0) {
      List<Widget> warpList = itemList.map((val){
        return InkWell(
          onTap: (){},
          child: Container(
            width: ScreenUtil().setWidth(372),
            child: Column(
              children: <Widget>[
                Text(val['title']),
                Image.network(
                  val['img'],
                  width: ScreenUtil().setWidth(370),
                  height: ScreenUtil().setHeight(370),
                ),
                Text(val['price']),
                Text(
                  val['price'],
                  style: TextStyle(
                      color: Colors.black12,
                      decoration: TextDecoration.lineThrough
                  ),
                )
              ],
            ),
          ),
        );
      }).toList();
      return warpList;
    } else {
      return [Text('数据加载中')];
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: <Widget>[
          _getHeader(),
          Wrap(
            spacing: 2,
            children: _getWrapList()
          )
        ],
      )
    );

  }
}
