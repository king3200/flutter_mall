import 'package:flutter/material.dart';
import 'package:test_mall/providers/counter/counter.dart';
import './pages/index_page.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterModel>(builder: (context) => CounterModel()),
      ],
      child: MyApp(),
    )
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: MaterialApp(
        title: '泰达的项目!',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}