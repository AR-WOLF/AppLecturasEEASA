import 'package:applect_json/entity/cliente.dart';
import 'package:floor/floor.dart';

@Entity(foreignKeys: [
  //////Relacion medidor-cliente
  ForeignKey(
    childColumns: ['cuenta_id'],
    parentColumns: ['cuenta_id'],
    entity: Cliente,
  ),
])
@entity
class Medidor {
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: 'num_medidor')
  String num_medidor;

  @ColumnInfo(name: 'esferas')
  int esferas;

  @ColumnInfo(name: 'coordenada_x')
  double coordenada_x;

  @ColumnInfo(name: 'coordenada_y')
  double coordenada_y;

  @ColumnInfo(name: 'secuencia')
  int secuencia;

  @ColumnInfo(name: 'ruta')
  int ruta;

  @ColumnInfo(name: 'sector')
  int sector;

  @ColumnInfo(name: 'zona')
  String? zona;

  @ColumnInfo(name: 'bloque')
  int bloque;

  @ColumnInfo(name: 'demanda_facturable')
  double? demanda_facturable;

  ////////////////////////////////////////////////////////////////
  @ColumnInfo(name: 'cuenta_id')
  String cuenta_id;

  Medidor({
    required this.num_medidor,
    required this.esferas,
    required this.coordenada_x,
    required this.coordenada_y,
    required this.secuencia,
    required this.ruta,
    required this.sector,
    required this.zona,
    required this.bloque,
    this.demanda_facturable,
    required this.cuenta_id,
  });

  factory Medidor.fromJson(Map<String, dynamic> dataJson) {
    return Medidor(
      num_medidor: dataJson['medidor_id'].toString(),
      esferas: dataJson['esferas'],
      coordenada_x: dataJson['coordenada_x'].toDouble(),
      coordenada_y: dataJson['coordenada_y'].toDouble(),
      secuencia: dataJson['secuencia'],
      ruta: dataJson['ruta'],
      sector: dataJson['sector'],
      zona: dataJson['zona'].toString(),
      bloque: dataJson['bloque'],
      demanda_facturable: dataJson['demanda_facturable'].toDouble(),
      cuenta_id: dataJson['cliente_id'],
    );
  }

  @override
  String toString() {
    return ('$num_medidor' +
        '$esferas' +
        '$coordenada_x' +
        '$coordenada_y' +
        '$secuencia' +
        '$ruta' +
        '$sector' +
        '$zona' +
        '$bloque' +
        '$demanda_facturable' +
        '$cuenta_id');
  }
}
