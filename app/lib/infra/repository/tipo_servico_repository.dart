import 'package:app/infra/model/tipo_servico.dart';
import 'package:app/infra/sqlite.dart';

class TipoServicoRepository {
  Future<List<TipoServico>> buscar(String nome) async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();
    List<Map<String, Object?>> servicos = await connection.query('tipo_servico',
        where: 'nome LIKE ?', whereArgs: ['%$nome%'], columns: ['id', 'nome']);

    List<TipoServico> servicoList = [];

    for (final servico in servicos) {
      int id = int.parse(servico['id'].toString());
      String nome = servico['nome'].toString();
      servicoList.add(TipoServico(id: id, nome: nome));
    }

    return servicoList;
  }

  Future<List<TipoServico>> buscarTodos() async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();
    List<Map<String, Object?>> servicos =
        await connection.query('tipo_servico', columns: ['id', 'nome']);

    List<TipoServico> servicoList = [];

    for (final servico in servicos) {
      int id = int.parse(servico['id'].toString());
      String nome = servico['nome'].toString();
      servicoList.add(TipoServico(id: id, nome: nome));
    }

    return servicoList;
  }

  Future<void> salvar(String nome) async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();

    await connection.insert('tipo_servico', {
      'nome': nome,
    });
  }

  void atualizar(int id, String nome) async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();

    await connection.update('tipo_servico', {'nome': nome},
        where: 'id = ?', whereArgs: [id]);
  }

  void deletar(int id) async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();
    await connection.delete('tipo_servico', where: 'id = ?', whereArgs: [id]);
  }
}
