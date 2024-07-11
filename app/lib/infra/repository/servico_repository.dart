import 'dart:ffi';

import 'package:app/infra/model/cliente.dart';
import 'package:app/infra/model/servico.dart';
import 'package:app/infra/model/tipo_servico.dart';
import 'package:app/infra/sqlite.dart';

class ServicoRepository {
  Future<List<Servico>> buscarTodos() async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();
    List<Map<String, Object?>> servicos = await connection.query('servico',
        columns: [
          'id',
          'descricao',
          'valor',
          'dataHora',
          'id_tipo_servico',
          'id_cliente'
        ]);

    List<Servico> servicoList = [];

    for (final servico in servicos) {
      int id = int.parse(servico['id'].toString());
      String descricao = servico['descricao'].toString();
      double valor = double.parse(servico['valor'].toString());
      DateTime dataHora =
          DateTime.tryParse(servico['dataHora'].toString()) ?? DateTime.now();
      TipoServico tipoServico =
          TipoServico(id: int.parse(servico['id_tipo_servico'].toString()));
      Cliente cliente =
          Cliente(id: int.parse(servico['id_cliente'].toString()));

      servicoList.add(Servico(
          id: id,
          descricao: descricao,
          valor: valor,
          dataHora: dataHora,
          tipoServico: tipoServico,
          cliente: cliente));
    }

    return servicoList;
  }

  Future<void> salvar(Servico servico) async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();

    await connection.insert('servico', {
      'descricao': servico.descricao,
      'valor': servico.valor,
      'dataHora': servico.dataHora.toString(),
      'id_tipo_servico': servico.tipoServico?.id,
      'id_cliente': servico.cliente?.id,
    });
  }

  void atualizar(Servico servico) async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();

    await connection.update(
        'servico',
        {
          'descricao': servico.descricao,
          'valor': servico.valor,
          'dataHora': servico.dataHora.toString(),
          'id_tipo_servico': servico.tipoServico?.id,
          'id_cliente': servico.cliente?.id,
        },
        where: 'id = ?',
        whereArgs: [servico.id]);
  }

  void deletar(int id) async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();
    await connection.delete('servico', where: 'id = ?', whereArgs: [id]);
  }
}
