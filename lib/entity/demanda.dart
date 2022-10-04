import 'dart:typed_data';

import 'package:applect_json/entity/medidor.dart';
import 'package:applect_json/entity/nueva_medicion.dart';
import 'package:floor/floor.dart';

//////////////////
/////////////////////////////

@Entity(
  foreignKeys: [
    //////Relacion nueva_medicion-medidor
    ForeignKey(
        childColumns: ['id_nueva_medicion'],
        parentColumns: ['id'],
        entity: NuevaMedicion,
        onDelete: ForeignKeyAction.cascade),
  ],
)
@entity
class Demanda {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'cuenta')
  String cuenta;

  //---------------------------------LECTURA
  @ColumnInfo(name: 'lectura')
  double lectura;

  @ColumnInfo(name: 'foto')
  Uint8List foto;

  @ColumnInfo(name: 'nombreFoto')
  String nombreFoto;
  //---------------------------------

  //relacion
  @ColumnInfo(name: 'id_nueva_medicion')
  int id_nueva_medicion;

  @ColumnInfo(name: 'estado_envio')
  bool estado_envio;

  Demanda(
      {this.id,
      required this.cuenta,
      required this.lectura,
      required this.nombreFoto,
      required this.foto,
      required this.id_nueva_medicion,
      required this.estado_envio});

/*
  factory NuevaMedicion.fromJson(Map<String, dynamic> dataJson) {
    return NuevaMedicion(
      id: dataJson['id'],
      cuenta: dataJson['cuenta'],
      tipo: dataJson['tipo'],
      estado: dataJson['estado'],
    );
  }
*/

  @override
  String toString() {
    return ('$id' + '$lectura');
  }
}
