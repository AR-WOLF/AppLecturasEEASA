import 'package:floor/floor.dart';

@entity
class Estado {
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: 'codigo')
  String codigo;

  @ColumnInfo(name: 'descripcion')
  String descripcion;

  Estado({
    required this.codigo,
    required this.descripcion,
  });

  factory Estado.fromJson(Map<String, dynamic> dataJson) {
    return Estado(
      codigo: dataJson['codigo'].toString(),
      descripcion: dataJson['descripcion'].toString(),
    );
  }

  @override
  String toString() {
    return ('$codigo' + '$descripcion');
  }
}
