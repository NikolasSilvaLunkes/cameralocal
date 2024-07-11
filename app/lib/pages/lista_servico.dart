import 'package:app/components/es_container.dart';
import 'package:app/infra/model/servico.dart';
import 'package:app/infra/repository/servico_repository.dart';
import 'package:flutter/material.dart';

class ListaServicosPage extends StatefulWidget {
  const ListaServicosPage({super.key, required this.title});

  final String title;

  @override
  State<ListaServicosPage> createState() => _ListaServicosPageState();
}

class _ListaServicosPageState extends State<ListaServicosPage> {
  late Future<List<Servico>> _futureServicos;

  @override
  void initState() {
    super.initState();
    _futureServicos = _fetchData();
  }

  Future<List<Servico>> _fetchData() {
    return ServicoRepository().buscarTodos();
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
              Navigator.of(context).pushNamed('/realizarservico');
            },
            child: const Text('Incluir'),
          ),
          Expanded(
            child: FutureBuilder<List<Servico>>(
              future: _futureServicos,
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
                                ? snapshot.data![index]?.descricao ??
                                    "Sem descricao"
                                : "") ??
                            ""),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () async {
                                ServicoRepository()
                                    .deletar(snapshot.data![index].id!);
                                setState(() {
                                  _futureServicos = _fetchData();
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
