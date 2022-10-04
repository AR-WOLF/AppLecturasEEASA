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

class EnvioAPI {
  var url_lecturas = Uri.parse(
      "https://pagos.eeasa.com.ec/WSCortes/servicios/lecturas/actualizarLecturas");

  var url_demanda = Uri.parse(
      "https://pagos.eeasa.com.ec/WSCortes/servicios/lecturas/actualizarDemanda");

  Future<void> guardarMediciones(
      List<NuevaMedicion> _listaMediciones, Demanda? _demanda) async {
    Fluttertoast.showToast(
        msg: "Lecturas almacenadas en el dispositivo.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Color.fromARGB(255, 20, 173, 255),
        textColor: Color.fromARGB(255, 255, 255, 255),
        fontSize: 11.0);
    var prefs = await SharedPreferences.getInstance();
    final database =
        await $FloorAppDatabase.databaseBuilder('medidores.db').build();
    final nuevaMedicionDao = database.nuevamedicionDao;
    await nuevaMedicionDao
        .eliminarMedicionesPorNumMedidor(_listaMediciones[0].num_medidor);

    for (int i = 0; i < _listaMediciones.length; i++) {
      print("---------");
      print(i);
      print("---------");

      Map<String, dynamic> data = {}; //para capturar el valor del response

      Map<String, dynamic> _mapMedicion = {
        "cuenta": _listaMediciones[i].cuenta,
        "lectura": _listaMediciones[i].lectura,
        "tipo": _listaMediciones[i].tipo,
        "estado": _listaMediciones[i].estado,
        "fecha": _listaMediciones[i].fecha,
        "nombreFoto": _listaMediciones[i].nombreFoto,
        "foto": _listaMediciones[i].foto
      };
      print("//////////////////////////");
      print(_mapMedicion);
      print(json.encode(_mapMedicion));
      print("//////////////////////////");

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
                    print(
                        "*/*/*/*/*/*/*/*/*ENVIO  fallido**************************"),
                    _listaMediciones[i].estado_envio = false,
                  }
                else
                  {
                    print("*/*/*/*/*/*/*/*/*ENVIO CON EXITO"),
                    _listaMediciones[i].estado_envio = true,
                  },
                await nuevaMedicionDao
                    .insertNuevaMedicion(_listaMediciones[i])
                    .then((value) async => {
                          if (_listaMediciones[i].tipo == "ER")
                            {
                              _demanda!.id_nueva_medicion = value,
                              await guardarDemanda(_demanda)
                            }
                        })
              })
          // ignore: invalid_return_type_for_catch_error
          .catchError((error) async => {
                print("------------------ERROR--------------------------"),
                print(error.toString()),
                print("------------------ERROR--------------------------"),
                _listaMediciones[i].estado_envio = false,
                await nuevaMedicionDao
                    .insertNuevaMedicion(_listaMediciones[i])
                    .then((value) async => {
                          if (_listaMediciones[i].tipo == "ER")
                            {
                              _demanda!.id_nueva_medicion = value,
                              await guardarDemanda(_demanda)
                            }
                        })
              });
    }
  }

  Future<void> guardarDemanda(Demanda _demanda) async {
    var prefs = await SharedPreferences.getInstance();
    print("---------------D1");
    final database =
        await $FloorAppDatabase.databaseBuilder('medidores.db').build();
    final demandaDao = database.demandaDao;

    Map<String, dynamic> data = {};

    Map<String, dynamic> _mapDemanda = {
      "cuenta": _demanda.cuenta,
      "lectura": _demanda.lectura,
      "nombreFoto": _demanda.nombreFoto,
      "foto": _demanda.foto
    };
    print("---------------D2");
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
                  _demanda.estado_envio = false,
                }
              else
                {
                  _demanda.estado_envio = true,
                },
              await demandaDao.insertDemanda(_demanda),
              print("---------------D3Fin")
            })
        .catchError((error) async => {
              _demanda.estado_envio = false,
              await demandaDao.insertDemanda(_demanda),
              print("---------------D3Fin")
            });
  }
}
