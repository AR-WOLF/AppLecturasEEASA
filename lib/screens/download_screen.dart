import 'dart:io';

import 'package:applect_json/entity/cliente.dart';
import 'package:applect_json/entity/medicion.dart';
import 'package:applect_json/entity/medidor.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../db.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';

import '../entity/estado.dart';

class name extends StatelessWidget {
  const name({Key? key}) : super(key: key);
  void main() {
    @override
    Widget build(BuildContext context) {
      return downloadScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class downloadScreen extends StatefulWidget {
  downloadScreen({Key? key}) : super(key: key);

  @override
  State<downloadScreen> createState() => _downloadScreenState();
}

class _downloadScreenState extends State<downloadScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 245, 255),
      appBar: AppBar(
          /*
        leading: IconButton(
            icon: const Icon(
              FontAwesomeIcons.bars,
              color: Colors.white,
            ),
            onPressed: () {}),
          */
          /*
        title: const Text('Descargar Datos',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            )),
        centerTitle: true,*/

          ///////////////////

          title: const Text("EEASA Lecturas",
              style: TextStyle(
                color: Colors.white,
              )),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 53, 103, 252),
                    Color.fromARGB(255, 37, 219, 247),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
/*
       appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/med2.png',
              fit: BoxFit.contain,
              height: 40,
            ),
          ],
        ),
      ),*/
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 15.0),
                const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Descargar Datos:",
                      style: TextStyle(fontSize: 24),
                    )),
                const SizedBox(height: 15.0),

                ///////////////////////////////////////////////////////////

                Card(
                  color: Color.fromARGB(244, 255, 255, 255),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipPath(
                    child: Column(
                      children: [
                        Container(
                          height: 200.0,
                          width: 300.0,
                          child: Column(
                            children: const [
                              SizedBox(height: 20.0),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Image(
                                    image:
                                        AssetImage('assets/images/4895597.png'),
                                    height: 120,
                                    width: 180,
                                    color: Color.fromRGBO(255, 255, 255, 0.6),
                                    colorBlendMode: BlendMode.modulate),
                              ),
                              SizedBox(height: 10.0),
                              Text('Datos Lecturas',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 2, 43, 93))),
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ),
                        Container(
                          height: 33.0,
                          margin: EdgeInsets.all(10),
                          child: RaisedButton(
                            onPressed: () {
                              downloadAll();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xff374ABE),
                                      Color(0xff64B6FF)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Container(
                                constraints: const BoxConstraints(
                                    maxWidth: 170.0, minHeight: 30.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Descargar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32.0),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),

                //////////////////////////////
                /*
                Card(
                  color: Color.fromARGB(244, 255, 255, 255),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipPath(
                    child: Column(
                      children: [
                        Container(
                          height: 200.0,
                          width: 300.0,
                          child: Column(
                            children: const [
                              SizedBox(height: 20.0),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Image(
                                    image:
                                        AssetImage('assets/images/estados.png'),
                                    height: 120,
                                    width: 180,
                                    color: Color.fromRGBO(255, 255, 255, 0.7),
                                    colorBlendMode: BlendMode.modulate),
                              ),
                              SizedBox(height: 10.0),
                              Text('Datos Estados',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 2, 43, 93))),
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ),
                        Container(
                          height: 33.0,
                          margin: EdgeInsets.all(10),
                          child: RaisedButton(
                            onPressed: () {
                              obtenerEstados();
                              Fluttertoast.showToast(
                                  msg:
                                      "Lecturas almacenadas en el dispositivo.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor:
                                      Color.fromARGB(255, 36, 120, 255),
                                  textColor: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 14.0);

                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 90),
                                          child: Row(children: const [
                                            Image(
                                              image: AssetImage(
                                                  'assets/images/oncheck.png'),
                                              height: 40,
                                              width: 40,
                                            ),
                                            SizedBox(width: 10),
                                            Text('')
                                          ]),
                                        ),
                                        content: const Text(
                                          'Descargado con Exito!',
                                          style: TextStyle(fontSize: 18),
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Cerrar"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xff374ABE),
                                      Color(0xff64B6FF)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Container(
                                constraints: const BoxConstraints(
                                    maxWidth: 170.0, minHeight: 30.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Descargar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32.0),

                        //////////////
                      ],
                    ),
                  ),
                ),

                */
              ],
            ),
          ),
        ),
      ),
    );
  }

  inicializar() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      final database =
          await $FloorAppDatabase.databaseBuilder('medidores.db').build();
      final daoCliente = await database.clienteDao;
      final daoMedidor = await database.medidorDao;
      final daoMedicion = await database.medicionDao;

      var url = Uri.parse(
          "https://pagos.eeasa.com.ec/WSCortes/servicios/lecturas/listadoUsuariosMedidores?sDesde=1&sHasta=1");
      var res = await http.get(url, headers: {
        "token": prefs.getString('local_token').toString(),
        'Content-Type': 'application/json; charset=UTF-8'
      });

      Map<String, dynamic> responseJson = await Map.from(json.decode(res.body));

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
            direccion: mapCli["clc_direccion"],
            celular: mapCli["clc_celular"],
            valor: mapCli["clc_Valor"],
            planillas: mapCli["clc_Planillas"]);

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
    } catch (error) {
      print(error.toString());
    }
    //}
  }

  obtenerEstados() async {
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
    } catch (error) {}
  }

  Future<void> descargarTodo() async {
    await obtenerEstados();
    await inicializar();
  }

  void downloadAll() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Descargando datos...')
                ],
              ),
            ),
          );
        });
    descargarTodo().whenComplete(() => {
          Navigator.of(context).pop(),
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => AlertDialog(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 90),
                      child: Row(children: const [
                        Image(
                          image: AssetImage('assets/images/oncheck.png'),
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(width: 10),
                        Text('')
                      ]),
                    ),
                    content: const Text(
                      'Descargado con Exito!',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("Cerrar"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ))
        });
  }

  ///end
}
