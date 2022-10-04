import 'dart:typed_data';

import 'package:applect_json/entity/medidor.dart';
import 'package:floor/floor.dart';

////////////////////////////////////////////

@Entity(
  foreignKeys: [
    //////Relacion nueva_medicion-medidor
    ForeignKey(
        childColumns: ['num_medidor'],
        parentColumns: ['num_medidor'],
        entity: Medidor,
        onDelete: ForeignKeyAction.cascade),
  ],
)
@entity
class NuevaMedicion {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'cuenta')
  String cuenta;

  @ColumnInfo(name: 'tipo')
  String tipo;

  @ColumnInfo(name: 'estado')
  String estado;

  @ColumnInfo(name: 'fecha')
  String fecha;

  //---------------------------------LECTURA ACTIVA
  @ColumnInfo(name: 'lectura')
  int lectura;

  @ColumnInfo(name: 'foto')
  Uint8List foto;

  @ColumnInfo(name: 'nombreFoto')
  String nombreFoto;
  //---------------------------------

  //relacion
  @ColumnInfo(name: 'num_medidor')
  String num_medidor;

  @ColumnInfo(name: 'estado_envio')
  bool estado_envio;

  NuevaMedicion(
      {this.id,
      required this.cuenta,
      required this.tipo,
      required this.estado,
      required this.fecha,
      required this.lectura,
      required this.nombreFoto,
      required this.foto,
      required this.num_medidor,
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
