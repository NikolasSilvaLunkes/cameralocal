import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String label;
  final String route;

  MenuItem({required this.label, required this.route});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(route);
        },
        child: Text(label));
  }
}
