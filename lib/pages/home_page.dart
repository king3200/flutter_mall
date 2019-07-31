import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../service/service_url.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  @override
  void initState() {
    getHomePageContent().then((val) {
      setState(() {
        print(val);
        this.homePageContent = val.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(homePageContent),
      ),
    );
  }
}


class TDSwiper extends StatelessWidget {

  final List<String> swiperData;

  TDSwiper({Key key, this.swiperData}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333,
      child: Swiper(
        itemCount: swiperData.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network('');
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
