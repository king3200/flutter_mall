import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_mall/providers/counter/counter.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('购物车'),),
      body: Center(
        child: Column(
          children: <Widget>[
            Number(),
            IncreseButton()
          ],
        ),
      ),
    );
  }
}


class Number extends StatelessWidget {

  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 200),
      child: Center(
        child: Consumer<CounterModel>(
          builder: (context, counter, child) {
            return Text('${counter.value}');
          },
        ),
      ),
    );
  }
}


class IncreseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: () {
            Provider.of<CounterModel>(context).increase();
          },
          child: Text('++++'),
        ),
      ),
    );
  }
}


