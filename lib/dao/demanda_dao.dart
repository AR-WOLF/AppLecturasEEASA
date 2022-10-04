import 'package:applect_json/entity/demanda.dart';
import 'package:applect_json/entity/medicion.dart';
import 'package:floor/floor.dart';

@dao
abstract class DemandaDao {
  @insert
  Future<void> insertDemanda(Demanda demanda);

  @insert
  Future<void> insertDemandas(List<Demanda> demandas);

  @Query('SELECT * FROM Demanda')
  Future<List<Demanda>> findAllDemandas();

//-------------------------------------------------
  @Query('SELECT * FROM Demanda d WHERE d.id = :id')
  Future<Demanda?> findByDemandaId(String id); //corregir

  @Query('SELECT * FROM Demanda d WHERE d.id_nueva_medicion = :id_medicion')
  Future<Demanda?> findByMedicionId(int id_medicion); //corregir

  //obtener las mdiciones que no se enviaron al servidor
  @Query('select * from Demanda d where estado_envio = false')
  Future<List<Demanda>> buscarMedicionesNoEnviadas();

  //actualizar estado envio
  @Query('update Demanda set estado_envio = :nuevo_estado where id = :id')
  Future<void> actualizarEstadoEnvio(bool nuevo_estado, int id);
}
