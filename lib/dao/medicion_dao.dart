import 'package:applect_json/entity/medicion.dart';
import 'package:floor/floor.dart';

@dao
abstract class MedicionDao {
  @insert
  Future<void> insertMedicion(Medicion medicion);

  @insert
  Future<void> insertMediciones(List<Medicion> mediciones);

  @Query('SELECT * FROM Medicion')
  Future<List<Medicion>> findAllMediciones();

//-------------------------------------------------
  //esta funcion produce erro porque puede regresar mas de un registro
  @Query('SELECT * FROM Medicion m WHERE m.num_medidor = :id')
  Future<Medicion?> findByMedidorId(String id);

  @Query(
      'SELECT * FROM Medicion m WHERE m.num_medidor = :id ORDER BY m.tipo_medidor ASC')
  Future<List<Medicion>> findMedicionesOfMedidor(String id);

  @Query('SELECT * FROM Medicion m WHERE m.id = :id')
  Future<Medicion?> findByMedicionId(String id);
}
