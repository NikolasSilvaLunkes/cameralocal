import 'dart:ffi';

import 'package:app/components/es_container.dart';
import 'package:app/infra/flutter/packages/flutter/lib/src/material/date_picker.dart';
import 'package:app/infra/flutter/packages/flutter/lib/src/material/text_field.dart';
import 'package:app/infra/model/cliente.dart';
import 'package:app/infra/model/servico.dart';
import 'package:app/infra/model/tipo_servico.dart';
import 'package:app/infra/repository/clientes_repository.dart';
import 'package:app/infra/repository/servico_repository.dart';
import 'package:app/infra/repository/tipo_servico_repository.dart';
import 'package:flutter/material.dart';

class CadastroServicoPage extends StatefulWidget {
  const CadastroServicoPage({super.key, required this.title});

  final String title;

  @override
  State<CadastroServicoPage> createState() => _CadastroServicoPageState();
}

class _CadastroServicoPageState extends State<CadastroServicoPage> {
  TextEditingController descricaoController = TextEditingController();
  TextEditingController valorController = TextEditingController();
  TextEditingController dataHoraController = TextEditingController();
  TipoServicoRepository tipooServicoRepository = TipoServicoRepository();
  ClienteRepository clienteRepository = ClienteRepository();
  List<TipoServico> allTipoServico = [];
  List<Cliente> allClientes = [];
  TipoServico? selectedTipoServico;
  Cliente? selectedCliente;
  DateTime? selectedDataHora;
  Double? selectedValor;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    allTipoServico = await tipooServicoRepository.buscarTodos();
    allClientes = await clienteRepository.buscar("");
    setState(() {});
  }

  void salvar(BuildContext context) async {
    final servicoRepository = ServicoRepository();
    await servicoRepository.salvar(Servico(
      descricao: descricaoController.text,
      valor: double.tryParse(valorController.text) ?? 0.0,
      dataHora: DateTime.tryParse(dataHoraController.text) ?? DateTime.now(),
      tipoServico: selectedTipoServico,
      cliente: selectedCliente,
    ));

    Navigator.of(context).pop();
    Navigator.of(context).pushNamed('/servicosrealizados');
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
              controller: descricaoController,
              decoration: const InputDecoration(hintText: 'Descricao')),
          TextFormField(
              controller: valorController,
              decoration: const InputDecoration(hintText: 'Valor')),
          Autocomplete<TipoServico>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return allTipoServico;
              }
              return allTipoServico.where((TipoServico option) {
                return option.nome
                        ?.contains(textEditingValue.text.toLowerCase()) ??
                    false;
              });
            },
            displayStringForOption: (TipoServico option) => option.nome ?? '',
            onSelected: (TipoServico selection) {
              selectedTipoServico = selection;
            },
          ),
          Autocomplete<Cliente>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<Cliente>.empty();
              }
              return allClientes.where((Cliente option) {
                return option.nome
                        ?.contains(textEditingValue.text.toLowerCase()) ??
                    false;
              });
            },
            displayStringForOption: (Cliente option) => option.nome ?? '',
            onSelected: (Cliente selection) {
              selectedCliente = selection;
            },
          ),
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
