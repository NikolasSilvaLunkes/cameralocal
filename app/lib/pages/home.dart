import 'package:app/components/menu.dart';
import 'package:app/components/menuItem.dart';
import 'package:app/pages/foto_page.dart';

import 'package:app/components/es_container.dart';
import 'package:app/components/es_menu.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ESContainer(
        widgets: [ESMenu()],
      ),
    );
  }
}
