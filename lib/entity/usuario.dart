import 'package:floor/floor.dart';

@entity
class Usuario {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'usuario')
  String usuario;

  @ColumnInfo(name: 'clave')
  String clave;

  Usuario({
    this.id,
    required this.usuario,
    required this.clave,
  });

  factory Usuario.fromJson(Map<String, dynamic> dataJson) {
    return Usuario(
      id: dataJson['id'],
      usuario: dataJson['usuario'].toString(),
      clave: dataJson['clave'].toString(),
    );
  }

  @override
  String toString() {
    return ('$id' + '$usuario' + '$clave');
  }
}
