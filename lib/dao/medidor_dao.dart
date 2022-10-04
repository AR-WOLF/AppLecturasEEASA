import 'dart:ffi';

import 'package:applect_json/entity/medidor.dart';
import 'package:applect_json/views/ruta_sector.dart';
import 'package:floor/floor.dart';

@dao
abstract class MedidorDao {
  @insert
  Future<void> insertMedidor(Medidor medidor);

  @insert
  Future<void> insertMedidores(List<Medidor> medidores);

  @Query('SELECT * FROM Medidor m WHERE m.num_medidor = :id')
  Stream<Medidor?> findMedidorByIdAll(String id);

  @Query('SELECT * FROM Medidor m WHERE m.num_medidor = :id')
  Future<Medidor?> findMedidorById(String id);

  @Query('SELECT * FROM Medidor')
  Future<List<Medidor>> findAllMedidores();

  //Custom Queries--------------------------------------------

  @Query(
      'select * from Medidor m where m.ruta= :ruta and m.sector= :sector order by m.secuencia ASC ')
  Future<List<Medidor>> findAllMedidoresByRutaSector(int ruta, int sector);

  //Buscar todos los mediidores que no tengan lectura por ruta y sector
  @Query("select m.num_medidor, m.esferas, m.coordenada_x, m.coordenada_y, m.secuencia, " +
      "m.ruta, m.sector, m.zona, m.bloque, m.demanda_facturable, m.cuenta_id " +
      "from Medidor m " +
      "LEFT  JOIN NuevaMedicion nm on m.num_medidor =nm.num_medidor " +
      "where nm.id  is NULL and m.sector = :_sector and m.ruta = :_ruta " +
      "order by m.secuencia asc")
  Future<List<Medidor>> findAllMedidoresNoLectura(int _sector, int _ruta);

  ///METODOS BSUQUEDA PERSONALIZADA

  @Query("select DISTINCT m.num_medidor, m.esferas, m.coordenada_x, m.coordenada_y, m.secuencia, " +
      "m.ruta, m.sector, m.zona, m.bloque, m.demanda_facturable, m.cuenta_id " +
      "from Medidor m " +
      "LEFT  JOIN NuevaMedicion nm on m.num_medidor =nm.num_medidor " +
      "where nm.id  is not NULL and m.sector = :_sector and m.ruta = :_ruta " +
      "order by m.secuencia asc")
  Future<List<Medidor>> buscarTodoLeido(int _sector, int _ruta);

  @Query("select DISTINCT  m.num_medidor, m.esferas, m.coordenada_x, m.coordenada_y, m.secuencia, " +
      "m.ruta, m.sector, m.zona, m.bloque, m.demanda_facturable, m.cuenta_id " +
      "from Medidor m " +
      "LEFT  JOIN NuevaMedicion nm on m.num_medidor =nm.num_medidor " +
      "where m.sector = :_sector and m.ruta = :_ruta " +
      "order by m.secuencia asc")
  Future<List<Medidor>> buscarTodoLNL(int _sector, int _ruta);

  @Query("select m.num_medidor, m.esferas, m.coordenada_x, m.coordenada_y, m.secuencia, " +
      "m.ruta, m.sector, m.zona, m.bloque, m.demanda_facturable, m.cuenta_id " +
      "from Medidor m " +
      "LEFT  JOIN NuevaMedicion nm on m.num_medidor =nm.num_medidor " +
      "where nm.id  is NULL and  m.cuenta_id = :_cuenta and m.sector = :_sector and m.ruta = :_ruta " +
      "order by m.secuencia asc")
  Future<List<Medidor>> buscarNLCadena(int _sector, int _ruta, String _cuenta);

  @Query("select DISTINCT m.num_medidor, m.esferas, m.coordenada_x, m.coordenada_y, m.secuencia, " +
      "m.ruta, m.sector, m.zona, m.bloque, m.demanda_facturable, m.cuenta_id " +
      "from Medidor m " +
      "LEFT  JOIN NuevaMedicion nm on m.num_medidor =nm.num_medidor " +
      "where nm.id is not NULL and  m.cuenta_id = :_cuenta and m.sector = :_sector and m.ruta = :_ruta " +
      "order by m.secuencia asc")
  Future<List<Medidor>> buscarLCadena(int _sector, int _ruta, String _cuenta);

  @Query("select m.num_medidor, m.esferas, m.coordenada_x, m.coordenada_y, m.secuencia, " +
      "m.ruta, m.sector, m.zona, m.bloque, m.demanda_facturable, m.cuenta_id " +
      "from Medidor m " +
      "LEFT  JOIN NuevaMedicion nm on m.num_medidor =nm.num_medidor " +
      "where m.cuenta_id = :_cuenta and m.sector = :_sector and m.ruta = :_ruta " +
      "order by m.secuencia asc")
  Future<List<Medidor>> buscarLNLCadena(int _sector, int _ruta, String _cuenta);

  //---------------------------------------------------------
  //---------------------------------------------------------

  @Query('select DISTINCT m.ruta,  m.sector  from Medidor m')
  Stream<List<dynamic>> findAllfindAllRutas();

  @update
  Future<void> updateMedidor(Medidor medidor);

  @delete
  Future<void> deleteMedidor(Medidor medidor);
}
