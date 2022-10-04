import 'dart:io';

import 'package:applect_json/entity/cliente.dart';
import 'package:applect_json/entity/medicion.dart';
import 'package:applect_json/entity/medidor.dart';
import 'package:floor/floor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:applect_json/entity/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db.dart';

class inicializar {
  /*
  void main() async {
    
    var prefs = await SharedPreferences.getInstance();
    final database =
        await $FloorAppDatabase.databaseBuilder('medidores.db').build();
    final daoCliente = await database.clienteDao;
    final daoMedidor = await database.medidorDao;
    final daoMedicion = await database.medicionDao;

    var url = Uri.parse(
        "https://pagos.eeasa.com.ec/WSCortes/servicios/lecturas/listadoUsuariosMedidores?sDesde=1&sHasta=1");
    var res = await http.post(url, headers: {
      "token": prefs.getString('local_token').toString(),
      'Content-Type': 'application/json; charset=UTF-8'
    });

    final Map<String, dynamic> responseJson =
        await Map.from(json.decode(res.body));
    print("-----------------------------");
    print(prefs.getString('local_token').toString());
    print("-----------------------------");
    List<dynamic> lista = await responseJson["response"];
    ///////////////////////////////////////////////////////////////////////////////////

    List<Cliente> listacliente = [];
    List<Medidor> listamedidores = [];
    List<Medicion> listamedicion = [];

    lista.forEach((element) {
      Map<String, dynamic> mapCli = new Map<String, dynamic>();
      Map<String, dynamic> mapMedidor = new Map<String, dynamic>();
      List<dynamic> _mediciones = element["lecturas"];

      mapCli = Map.from(element["cliente"]);
      mapMedidor = Map.from(element["medidor"]);

      Cliente cliente = Cliente(
          cuenta_id: mapCli["clc_cliente_id"],
          cedula: mapCli["clc_cedula"],
          apellido: mapCli["clc_apellido"],
          nombre: mapCli["clc_nombre"],
          direccion: mapCli["clc_direccion"]);

      Medidor medidor = Medidor(
          num_medidor: mapMedidor["clm_medidor"],
          esferas: mapMedidor["clm_esferas"],
          coordenada_x: mapMedidor["clm_coordenada_x"],
          coordenada_y: mapMedidor["clm_coordenada_y"],
          secuencia: mapMedidor["clm_secuencia"],
          ruta: mapMedidor["clm_ruta"],
          sector: mapMedidor["clm_sector"],
          zona: mapMedidor["clm_zona"],
          bloque: mapMedidor["clm_bloque"],
          demanda_facturable: mapMedidor["clm_demanda_facturable"],
          cuenta_id: cliente.cuenta_id);

      _mediciones.forEach((element) {
        Map<String, dynamic> mapMedicion = new Map<String, dynamic>();
        mapMedicion = Map.from(element);
        Medicion medicion = Medicion(
            lectura_anterior: mapMedicion["clm_lectura_anterior"],
            consumo_promedio: mapMedicion["clm_consumo_promedio"],
            tipo_medidor: mapMedicion["clm_tipo"],
            num_medidor: medidor.num_medidor);

        listamedicion.add(medicion);
      });

      listacliente.add(cliente);
      listamedidores.add(medidor);
    });

    await daoCliente.insertClientes(listacliente);
    await daoMedidor.insertMedidores(listamedidores);
    await daoMedicion.insertMediciones(listamedicion);
  }
  */
/*
  void main() async {
    var prefs = await SharedPreferences.getInstance();
    final database =
        await $FloorAppDatabase.databaseBuilder('medidores.db').build();

    final daoMedidor = await database.medidorDao;

    Stream<List<dynamic>> listamedidores =
        await daoMedidor.findAllfindAllRutas();
    listamedidores.listen((event) {
      event.forEach((element) {
        //print(element);
      });
    });
  }*/
}
