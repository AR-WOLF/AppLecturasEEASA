import 'dart:io';
import 'package:applect_json/entity/estado.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'db.dart';

class obtenerEstados {
  void main() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      final database =
          await $FloorAppDatabase.databaseBuilder('medidores.db').build();
      final daoEstado = await database.estadoDao;

      var url = Uri.parse(
          "https://pagos.eeasa.com.ec/WSCortes/servicios/lecturas/estadosLectura");
      var res = await http.get(url,
          headers: {"token": prefs.getString('local_token').toString()});

      final Map<String, dynamic> responseJson =
          await Map.from(json.decode(res.body));

      List<dynamic> lista = responseJson["response"];
      ///////////////////////////////////////////////////////////////////////////////////

      List<Estado> listaestado = [];

      lista.forEach((element) {
        Map<String, dynamic> mapEstado = Map.from(element);
        Estado estado = Estado(
          codigo: mapEstado["cle_codigo"],
          descripcion: mapEstado["cle_descripcion"],
        );

        listaestado.add(estado);
      });
      daoEstado.insertEstados(listaestado);
      print("------------------------");
      //await daoEstado.insertEstados(listaestado);
    } catch (error) {
      print(error.toString());
    }
  }
}
