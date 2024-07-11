import 'package:app/components/menuItem.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final List<MenuItem> items;

  const Menu({required this.items});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[for (var item in items) item]));
  }
}
