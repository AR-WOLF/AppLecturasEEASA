import 'package:applect_json/entity/medidor.dart';

import 'package:floor/floor.dart';

////////////////////////////////////////////

@Entity(
  foreignKeys: [
    //////Relacion medicion-medidor
    ForeignKey(
      childColumns: ['num_medidor'],
      parentColumns: ['num_medidor'],
      entity: Medidor,
    ),
  ],
)
@entity
class Medicion {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'lectura_anterior')
  int lectura_anterior;

  @ColumnInfo(name: 'consumo_promedio')
  int consumo_promedio;

  @ColumnInfo(name: 'tipo_medidor')
  String tipo_medidor;

  @ColumnInfo(name: 'num_medidor')
  String num_medidor;

  //////////////////////////////////////////////

  Medicion({
    this.id,
    required this.lectura_anterior,
    required this.consumo_promedio,
    required this.tipo_medidor,
    required this.num_medidor,
  });

  factory Medicion.fromJson(Map<String, dynamic> dataJson) {
    return Medicion(
      id: dataJson['id'],
      lectura_anterior: dataJson['lectura_anterior'],
      consumo_promedio: dataJson['consumo_promedio'],
      tipo_medidor: dataJson['tipo_medidor'].toString(),
      num_medidor: dataJson['num_medidor'].toString(),
    );
  }

  @override
  String toString() {
    return ('$id' +
        '$lectura_anterior' +
        '$consumo_promedio' +
        '$tipo_medidor' +
        '$num_medidor');
  }
}
