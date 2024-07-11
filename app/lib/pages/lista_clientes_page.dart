import 'package:app/components/es_container.dart';
import 'package:app/infra/model/cliente.dart';
import 'package:app/infra/repository/clientes_repository.dart';
import 'package:flutter/material.dart';

class ListaClientesPage extends StatefulWidget {
  const ListaClientesPage({super.key, required this.title});

  final String title;

  @override
  State<ListaClientesPage> createState() => _ListaClientesPageState();
}

class _ListaClientesPageState extends State<ListaClientesPage> {
  late Future<List<Cliente>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = _fetchData();
  }

  Future<List<Cliente>> _fetchData() {
    return ClienteRepository().buscar("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Cadastro"),
      ),
      body: ESContainer(widgets: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/clientescadastro');
          },
          child: const Text('Incluir'),
        ),
        Expanded(
          child: FutureBuilder<List<Cliente>>(
            future: _futureUsers,
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
                      title: Text(snapshot.data != null
                          ? """${(snapshot.data![index]?.nome ?? "")} - ${snapshot.data![index]?.documento ?? ""} - ${snapshot.data![index]?.email ?? ""} - ${snapshot.data![index]?.telefone ?? ""}"""
                          : ""),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () async {
                              ClienteRepository()
                                  .deletar(snapshot.data![index].id!);
                              setState(() {
                                _futureUsers = _fetchData();
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
      ]),
    );
  }
}
