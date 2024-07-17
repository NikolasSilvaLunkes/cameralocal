import 'package:app/pages/foto_page.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/lista_imagens.dart';
import 'package:app/pages/mapa.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      title: 'Serviços',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const MyHomePage(title: 'Home'),
        '/foto': (context) => const FotoPage(title: 'Foto'),
        '/mapa': (context) => const MapaPage(title: 'Mapa'),
        '/lista': (context) => const ListaImagensPage(title: 'Lista'),
      },
    );
  }
}
