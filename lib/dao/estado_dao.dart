import 'package:applect_json/entity/estado.dart';
import 'package:floor/floor.dart';

@dao
abstract class EstadoDao {
  @insert
  Future<void> insertEstado(Estado estado);

  @insert
  Future<void> insertEstados(List<Estado> clientes);

  @Query('SELECT *FROM Estado')
  Future<List<Estado>> findAllEstados();
}
