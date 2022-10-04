//aqui enviamos todos los pendientes al servidor
import 'dart:convert';

import 'package:applect_json/db.dart';
import 'package:applect_json/entity/demanda.dart';
import 'package:applect_json/entity/nueva_medicion.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entity/medicion.dart';
import 'package:http/http.dart' as http;

class sendAll {
  var url_lecturas = Uri.parse(
      "https://pagos.eeasa.com.ec/WSCortes/servicios/lecturas/actualizarLecturas");

  var url_demanda = Uri.parse(
      "https://pagos.eeasa.com.ec/WSCortes/servicios/lecturas/actualizarDemanda");

  Future<void> enviarTodo() async {
    var prefs = await SharedPreferences.getInstance();
    final database =
        await $FloorAppDatabase.databaseBuilder('medidores.db').build();
    final nuevaMedicionDao = database.nuevamedicionDao;
    final demandaDao = database.demandaDao;

    List<NuevaMedicion> listaMediciones =
        await nuevaMedicionDao.buscarMedicionesNoEnviadas();
    List<Demanda> listaDemandas = await demandaDao.buscarMedicionesNoEnviadas();

    for (int i = 0; i < listaMediciones.length; i++) {
      Map<String, dynamic> data = {};
      Map<String, dynamic> _mapMedicion = {
        "cuenta": listaMediciones[i].cuenta,
        "lectura": listaMediciones[i].lectura,
        "tipo": listaMediciones[i].tipo,
        "estado": listaMediciones[i].estado,
        "fecha": listaMediciones[i].fecha,
        "nombreFoto": listaMediciones[i].nombreFoto,
        "foto": listaMediciones[i].foto
      };
      var res = await http
          .post(url_lecturas, body: json.encode(_mapMedicion), headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "token": prefs.getString('local_token').toString()
          })
          .timeout(const Duration(seconds: 5))
          .then((response) async => {
                data = jsonDecode(response.body),
                if (data["response"] == false || data["response"] == null)
                  {
                    print("-----------ERROR AL ENVIAR---------------"),
                  }
                else
                  {
                    print("-----------ENVIO CORRECTO---------------"),
                    print(listaMediciones[i].id),
                    print("-----------ENVIO CORRECTO---------------"),
                    await nuevaMedicionDao.actualizarEstadoEnvio(
                        true, listaMediciones[i].id!)
                  }
              })
          .catchError((error) async => {print(error.toString())});
    }
    //
    for (int i = 0; i < listaDemandas.length; i++) {
      Map<String, dynamic> data = {};
      Map<String, dynamic> _mapDemanda = {
        "cuenta": listaDemandas[i].cuenta,
        "lectura": listaDemandas[i].lectura,
        "nombreFoto": listaDemandas[i].nombreFoto,
        "foto": listaDemandas[i].foto
      };

      var res = await http
          .post(url_demanda, body: json.encode(_mapDemanda), headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "token": prefs.getString('local_token').toString()
          })
          .timeout(const Duration(seconds: 5))
          .then((response) async => {
                data = jsonDecode(response.body),
                if (data["response"] == false || data["response"] == null)
                  {
                    //
                  }
                else
                  {
                    await demandaDao.actualizarEstadoEnvio(
                        true, listaDemandas[i].id!)
                  },
              })
          .catchError((error) async => {print(error.toString())});
    }
  }

  //fin

}
