import 'package:applect_json/entity/nueva_medicion.dart';
import 'package:floor/floor.dart';

@dao
abstract class NuevaMedicionDao {
  @insert
  Future<int> insertNuevaMedicion(NuevaMedicion nuevamedicion);

  @insert
  Future<List<int>> insertNuevaMediciones(List<NuevaMedicion> nuevasmediciones);

  @Query('SELECT * FROM NuevaMedicion')
  Future<List<NuevaMedicion>> findAllNuevaMedicion();

  @Query('select * from NuevaMedicion nm where num_medidor = :num_medidor ')
  Future<List<NuevaMedicion>> findMedicionesOfMedidor(String num_medidor);

  //obtener las mdiciones que no se enviaron al servidor
  @Query('select * from NuevaMedicion nm where estado_envio = false')
  Future<List<NuevaMedicion>> buscarMedicionesNoEnviadas();

  //actualizar estado envio
  @Query('update NuevaMedicion set estado_envio = :nuevo_estado where id = :id')
  Future<void> actualizarEstadoEnvio(bool nuevo_estado, int id);

  //ELIMINAR UNA MEDICION POR num_medidor
  @Query('delete from NuevaMedicion where num_medidor = :num_med')
  Future<void> eliminarMedicionesPorNumMedidor(String num_med);
}
