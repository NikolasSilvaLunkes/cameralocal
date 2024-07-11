import 'package:app/components/es_container.dart';
import 'package:app/infra/repository/tipo_servico_repository.dart';
import 'package:flutter/material.dart';

class CadastroTiposServicoPage extends StatefulWidget {
  const CadastroTiposServicoPage({super.key, required this.title});

  final String title;

  @override
  State<CadastroTiposServicoPage> createState() =>
      _CadastroTiposServcoPageState();
}

class _CadastroTiposServcoPageState extends State<CadastroTiposServicoPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController documentoController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void salvar(BuildContext context) async {
    final tipoServicoRepository = TipoServicoRepository();
    await tipoServicoRepository.salvar(nomeController.text);

    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed('/tiposservicos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ESContainer(
        widgets: [
          TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(hintText: 'Nome')),
          ElevatedButton(
              onPressed: () {
                salvar(context);
              },
              child: const Text('Salvar'))
        ],
      ),
    );
  }
}
