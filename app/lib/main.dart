import 'package:app/camera.dart';
import 'package:app/pages/camera_controller.dart';
import 'package:app/pages/foto_page.dart';
import 'package:app/pages/cadastro_servico.dart';
import 'package:app/pages/cadastro_tipos_servico.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/lista_clientes_page.dart';
import 'package:app/pages/lista_servico.dart';
import 'package:app/pages/lista_tipos_servico_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serviços',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      ),
      routes: {
        '/': (context) => const MyHomePage(title: 'Home'),
        '/foto': (context) => FotoPage(title: 'Foto'),
      },
    );
  }
}
