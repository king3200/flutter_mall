import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_mall/providers/counter/counter.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
