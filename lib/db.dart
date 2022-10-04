import 'dart:async';

import 'dart:typed_data';

import 'package:applect_json/dao/cliente_dao.dart';
import 'package:applect_json/dao/demanda_dao.dart';
import 'package:applect_json/dao/estado_dao.dart';
import 'package:applect_json/dao/medicion_dao.dart';
import 'package:applect_json/dao/medidor_dao.dart';
import 'package:applect_json/dao/nueva_medicion_dao.dart';
import 'package:applect_json/dao/usuario_dao.dart';

import 'package:applect_json/entity/cliente.dart';
import 'package:applect_json/entity/demanda.dart';
import 'package:applect_json/entity/estado.dart';
import 'package:applect_json/entity/medicion.dart';
import 'package:applect_json/entity/medidor.dart';
import 'package:applect_json/entity/nueva_medicion.dart';

import 'package:applect_json/entity/usuario.dart';
import 'package:floor/floor.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'db.g.dart';

@Database(version: 1, entities: [
  Cliente,
  Usuario,
  Estado,
  Medidor,
  Medicion,
  NuevaMedicion,
  Demanda
])
abstract class AppDatabase extends FloorDatabase {
  ClienteDao get clienteDao;
  UsuarioDao get usuarioDao;
  EstadoDao get estadoDao;
  MedidorDao get medidorDao;
  MedicionDao get medicionDao;
  NuevaMedicionDao get nuevamedicionDao;
  DemandaDao get demandaDao;
}


///////////////////////////////////////////////////////////////////////
///
///lista rutas
/*  @override
  Stream<List<dynamic>> findAllfindAllRutas() {
    return _queryAdapter.queryListStream(
        'select DISTINCT m.ruta,  m.sector  from Medidor m',
        mapper: (Map<String, dynamic> row) =>
            [row['ruta'] as int, row['sector'] as int],
        queryableName: 'Bills',
        isView: false);
  }*/
