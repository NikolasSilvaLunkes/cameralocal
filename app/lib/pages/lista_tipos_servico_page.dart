import 'package:app/components/es_container.dart';
import 'package:app/infra/model/tipo_servico.dart';
import 'package:app/infra/repository/tipo_servico_repository.dart';
import 'package:flutter/material.dart';

class ListaTiposServicoPage extends StatefulWidget {
  const ListaTiposServicoPage({super.key, required this.title});

  final String title;

  @override
  State<ListaTiposServicoPage> createState() => _ListaTiposServicoPageState();
}

class _ListaTiposServicoPageState extends State<ListaTiposServicoPage> {
  late Future<List<TipoServico>> _futureTipoServicos;

  @override
  void initState() {
    super.initState();
    _futureTipoServicos = _fetchData();
  }

  Future<List<TipoServico>> _fetchData() {
    return TipoServicoRepository().buscarTodos();
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
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/tiposservicoscadastro');
            },
            child: const Text('Incluir'),
          ),
          Expanded(
            child: FutureBuilder<List<TipoServico>>(
              future: _futureTipoServicos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text((snapshot.data != null
                                ? snapshot.data![index]?.nome ?? "Sem nome"
                                : "") ??
                            ""),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () async {
                                TipoServicoRepository()
                                    .deletar(snapshot.data![index].id!);
                                setState(() {
                                  _futureTipoServicos = _fetchData();
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
