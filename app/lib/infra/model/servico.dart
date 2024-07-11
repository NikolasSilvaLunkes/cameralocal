import 'dart:ffi';

import 'package:app/infra/model/cliente.dart';
import 'package:app/infra/model/tipo_servico.dart';

class Servico {
  int? id;
  String? descricao;
  double? valor;
  DateTime? dataHora;
  TipoServico? tipoServico;
  Cliente? cliente;
  Servico(
      {this.id,
      this.descricao,
      this.valor,
      this.dataHora,
      this.tipoServico,
      this.cliente});
}
