import 'package:floor/floor.dart';

@entity
class Cliente {
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: 'cuenta_id')
  String cuenta_id;

  @ColumnInfo(name: 'cedula')
  String cedula;

  @ColumnInfo(name: 'nombre')
  String nombre;

  @ColumnInfo(name: 'apellido')
  String apellido;

  @ColumnInfo(name: 'direccion')
  String direccion;

  @ColumnInfo(name: 'celular')
  String celular;

  @ColumnInfo(name: 'valor')
  double valor;

  @ColumnInfo(name: 'planillas')
  int planillas;

  Cliente(
      {required this.cuenta_id,
      required this.cedula,
      required this.nombre,
      required this.apellido,
      required this.direccion,
      required this.celular,
      required this.valor,
      required this.planillas});

  factory Cliente.fromJson(Map<String, dynamic> dataJson) {
    return Cliente(
        cuenta_id: dataJson['cuenta_id'].toString(),
        cedula: dataJson['cedula'].toString(),
        nombre: dataJson['nombre'].toString(),
        apellido: dataJson['apellido'].toString(),
        direccion: dataJson['direccion'].toString(),
        celular: dataJson['celular'].toString(),
        valor: dataJson['valor'],
        planillas: dataJson['planillas']);
  }

  @override
  String toString() {
    return ('$cuenta_id' + '$cedula' + '$nombre' + '$apellido' + '$direccion');
  }
}
