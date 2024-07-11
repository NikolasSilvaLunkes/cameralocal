import 'package:app/components/camera_preview.dart';
import 'package:app/components/es_container.dart';
import 'package:app/infra/repository/clientes_repository.dart';
import 'package:app/pages/camera_controller.dart';
import 'package:flutter/material.dart';

class FotoPage extends StatefulWidget {
  const FotoPage({super.key, required this.title});

  final String title;

  @override
  State<FotoPage> createState() => _FotoPageState();
}

class _FotoPageState extends State<FotoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Foto"),
      ),
      body: ESContainer(
        widgets: [],
      ),
    );
  }
}
