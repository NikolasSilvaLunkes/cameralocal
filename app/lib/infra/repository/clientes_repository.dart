import 'package:app/infra/model/cliente.dart';
import 'package:app/infra/sqlite.dart';

class ClienteRepository {
  Future<List<Cliente>> buscar(String nome) async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();
    List<Map<String, Object?>> usuarios = await connection.query('clientes',
        where: 'nome LIKE ?',
        whereArgs: ['%$nome%'],
        columns: ['id', 'nome', 'documento', 'telefone', 'email']);

    List<Cliente> usuarioList = [];

    for (final usuario in usuarios) {
      int id = int.parse(usuario['id'].toString());
      String nome = usuario['nome'].toString();
      usuarioList.add(Cliente(
          id: id,
          nome: nome,
          documento: usuario['documento'].toString(),
          telefone: usuario['telefone'].toString(),
          email: usuario['email'].toString()));
    }

    return usuarioList;
  }

  Future<void> salvar(
      String nome, String documento, String telefone, String email) async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();
    await connection.insert('clientes', {
      'nome': nome,
      'documento': documento,
      'telefone': telefone,
      'email': email
    });
  }

  void atualizar() async {
    int id = 1;
    String nome = 'Josnei';
    double valor = 10;

    final sqlite = SqliteConnection();
    final connection = await sqlite.db();

    await connection.update('clientes', {'nome': nome, 'valor': valor},
        where: 'id = 1');
  }

  void deletar(int id) async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();
    await connection.delete('clientes', where: 'id = ${id.toString()}');
  }
}
