import 'dart:io';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

class SqliteConnection {
  Future<sql.Database> db() async {
    String databasesPath = await sql.getDatabasesPath();
    String path = join(databasesPath, 'servicos.db');

    return sql.openDatabase(
      'servicos.db',
      version: 3,
      onCreate: (sql.Database database, int version) async {
        await createTables(database, version);
      },
    );
  }

  Future<void> createTables(sql.Database database, int version) async {
    await database.execute("""CREATE TABLE clientes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome TEXT,
        documento TEXT,
        telefone TEXT,
        email TEXT
      );
      """);
    await database.execute("""
      CREATE TABLE tipo_servico(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome TEXT
      );
      """);

    await database.execute("""
      CREATE TABLE servico(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        id_cliente INTEGER,
        id_tipo_servico INTEGER,
        descricao TEXT,
        dataHora TEXT,
        horas REAL,
        valor REAL,
        data TEXT,
        FOREIGN KEY(id_cliente) REFERENCES clientes(id),
        FOREIGN KEY(id_tipo_servico) REFERENCES tipo_servico(id)
      );
      """);
  }
}
