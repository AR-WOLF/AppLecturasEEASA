import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:applect_json/entity/demanda.dart';
import 'package:applect_json/entity/estado.dart';
import 'package:applect_json/entity/medicion.dart';
import 'package:applect_json/screen_2/Map.dart';
import 'package:applect_json/screen_2/envio_api.dart';
import 'package:applect_json/screen_2/table_med_screen_2.dart';
import 'package:http/http.dart' as http;
import 'package:applect_json/entity/medidor.dart';
import 'package:applect_json/entity/nueva_medicion.dart';
import 'package:applect_json/entity/usuario.dart';
import 'package:applect_json/screen_2/info_cliente_screen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:utm/utm.dart';

import '../db.dart';
import 'package:flutter/material.dart';

import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

var medidorController = TextEditingController();
const String medidor_id = "";

var lecturaActivaController = TextEditingController();

//////////////////////
var lecturaReactivaController = TextEditingController();
var demandaController = TextEditingController();
var cuentaController = TextEditingController();

var dropvalor;
//late FToast fToast;

var capturaImagen = "";

Uint8List imagen_activa = Uint8List(0);
Uint8List imagen_reactiva = Uint8List(0);
Uint8List imagen_demanda = Uint8List(0);

String aux_cuenta = "";

bool estado_nv = false;
bool estado_reactiva = false;

late String _numMedidor;

late int _ruta;
late int _sector;

List<Medicion> lista_mediciones = [];

class ActualizarLectura extends StatefulWidget {
  ActualizarLectura({
    Key? key,
    @required num_medidor,
    @required ruta,
    @required sector,
  }) : super(key: key) {
    _numMedidor = num_medidor;
    _ruta = ruta;
    _sector = sector;
  }

  @override
  State<ActualizarLectura> createState() => _LecturaTablaState();
}

class _LecturaTablaState extends State<ActualizarLectura> {
  File? imageFile_activa;
  File? imageFile_reactiva;
  File? imageFile_demanda;

  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  // late List<_Row> _employees;
  // late _DataSource _employeeDataSource;

  @override
  void initState() {
    imagen_activa = Uint8List(0);
    imagen_reactiva = Uint8List(0);
    imagen_demanda = Uint8List(0);

    lecturaActivaController.clear();
    lecturaReactivaController.clear();
    demandaController.clear();

    medidorController.clear();
    cuentaController.clear();

    dropvalor = "00";
    capturaImagen = "";
    imageFile_activa = null;
    estado_nv = false;
    llenarDatos();
    super.initState();
  }

  Widget build(BuildContext context) {
    medidorController.addListener(() {
      actualizarEstados();
    });

    lecturaActivaController.addListener(() {
      actualizarEstados();
    });

    lecturaReactivaController.addListener(() {
      actualizarEstados();
    });

    demandaController.addListener(() {
      actualizarEstados();
    });

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 245, 255),
      ///////////////////////////////////////////////////
      appBar: AppBar(
        /*
        leading: IconButton(
            icon: const Icon(
              FontAwesomeIcons.bars,
              color: Colors.white,
            ),
            onPressed: () {}),
          */
        title: const Text('Actualizar Lectura',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            )),
        centerTitle: true,
      ),

      /////////////////////////////////////////////////

      body: Form(
        key: _formKey,
        child: FutureBuilder(
            future: Future.wait([getEstados()]),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                children = <Widget>[
                  const SizedBox(height: 15.0),

                  //Expanded(

                  SizedBox(
                    height: 340.0,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 0, 30, 0),
                        //const SizedBox(height: 10.0),
                        ///////////////////////////////////////////////////

                        child: Column(children: [
                          const SizedBox(height: 25.0),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Datos del Medidor:",
                                style: TextStyle(fontSize: 25),
                              )),
                          const SizedBox(height: 35.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: TextFormField(
                                    enabled: false,
                                    controller: medidorController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      icon: const Icon(
                                        Icons.table_rows,
                                        size: 25.0,
                                        color: Color.fromARGB(255, 8, 123, 255),
                                      ),
                                      // hintText: '000000',
                                      labelText: '# Medidor',
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(13),
                                    ),
                                    //keyboardType: TextInputType.number,
                                    //inputFormatters: [FilteringTextInputFormatter.digitsOnly]
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true, signed: true),

                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]')),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 0.0),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 0.0),
                                  child: TextFormField(
                                    onChanged: (String value) {
                                      setState(() {});
                                    },
                                    enabled: false,
                                    controller: cuentaController,
                                    decoration: InputDecoration(
                                      //errorText: _validateDem ? 'Ingrese un valor!' : null,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),

                                      //hintText: '000000',
                                      labelText: '# Cuenta',
                                      isDense: true,
                                      contentPadding: const EdgeInsets.all(14),
                                    ),
                                    //keyboardType: TextInputType.number,
                                    //inputFormatters: [FilteringTextInputFormatter.digitsOnly]
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true, signed: true),

                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]')),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: TextFormField(
                                    onChanged: (String value) {
                                      setState(() {});
                                    },
                                    enabled: estado_nv,
                                    controller: lecturaActivaController,
                                    decoration: InputDecoration(
                                      errorText: _validate
                                          ? 'Ingrese un valor!'
                                          : null,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      icon: const Icon(
                                        Icons.edit_note,
                                        size: 25.0,
                                        color: Color.fromARGB(255, 8, 123, 255),
                                      ),
                                      hintText: '000000',
                                      labelText: 'Lectura Activa',
                                      isDense: true,
                                      contentPadding: const EdgeInsets.all(14),
                                    ),
                                    //keyboardType: TextInputType.number,
                                    //inputFormatters: [FilteringTextInputFormatter.digitsOnly]
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true, signed: true),

                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]')),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 0.0),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 0.0),
                                  child: TextFormField(
                                    onChanged: (String value) {
                                      setState(() {});
                                    },
                                    enabled: estado_reactiva,
                                    controller: lecturaReactivaController,
                                    decoration: InputDecoration(
                                      //errorText: _validateDem ? 'Ingrese un valor!' : null,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),

                                      hintText: '000000',
                                      labelText: 'Lectura Reactiva',
                                      isDense: true,
                                      contentPadding: const EdgeInsets.all(14),
                                    ),
                                    //keyboardType: TextInputType.number,
                                    //inputFormatters: [FilteringTextInputFormatter.digitsOnly]
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true, signed: true),

                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]')),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Icon(
                                Icons.edit_note_rounded,
                                size: 25.0,
                                color: Color.fromARGB(255, 8, 123, 255),
                              ),
                              //editar+++++++++++++++++++++++++++++++++++++++++++++++++++
                              const SizedBox(width: 15.0),

                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 00, right: 0.0),
                                  child: TextFormField(
                                    onChanged: (String value) {
                                      setState(() {});
                                    },
                                    enabled: estado_reactiva,
                                    controller: demandaController,
                                    decoration: InputDecoration(
                                      //errorText: _validateDem ? 'Ingrese un valor!' : null,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),

                                      hintText: '0.00001',
                                      labelText: 'Demanda',
                                      isDense: true,
                                      contentPadding: const EdgeInsets.all(14),
                                    ),
                                    //keyboardType: TextInputType.number,
                                    //inputFormatters: [FilteringTextInputFormatter.digitsOnly]
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: false, signed: true),

                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9.]')),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15.0),

                              Container(
                                height: 50.0,
                                width: 200.0,
                                child: DropdownButton(
                                  isExpanded: true,
                                  elevation: 24,
                                  icon: Icon(Icons.arrow_drop_down),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 16.0),
                                  underline: Container(
                                    height: 1,
                                    color: Color.fromARGB(255, 8, 123, 255),
                                  ),
                                  menuMaxHeight: 300.0,

                                  value: dropvalor,
                                  items: snapshot.data[0],
                                  onChanged: (value) {
                                    cambiarEstado(value.toString());
                                    setState(() {
                                      dropvalor = value;
                                    });
                                  },
                                  // value: selectedType,

                                  hint: const Text(
                                    'Estado',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 8, 123, 255),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            height: 42.0,
                            width: 190.0,
                            child: Center(
                              child: ElevatedButton(
                                child: const SizedBox(
                                  // height: 45.0,
                                  //width: 220.0,

                                  child: Center(
                                    child: Text(
                                      'Guardar',
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Color.fromARGB(
                                              255, 254, 254, 254)),
                                    ),
                                  ),
                                ),
                                onPressed: enableSaveButton() == false
                                    ? null
                                    : () {
                                        rangoNuevaMedicion();
                                      },
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromARGB(255, 7, 128, 221)),
                              ),
                            ),
                          ),
                        ])),
                  ),

                  //),
                ];
              } else {
                children = const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 320, left: 180),
                    child: CircularProgressIndicator(),

                    /*
                      child: Text('Cargando Datos...'),*/
                  )

                  /*
                    Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),*/

                  /*ESTADO
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Cargando Datos...'),
                    )*/
                ];
              }

              return Column(
                //mainAxisAlignment : MainAxisAlignment.start,
                children: children,
              );
            }),
      ),

      floatingActionButton: SpeedDial(
          heroTag: "Camara",
          icon: Icons.camera_alt_outlined,
          backgroundColor: const Color.fromARGB(255, 0, 55, 138),
          children: [
            if (lista_mediciones.length >= 2)
              SpeedDialChild(
                  child: const Icon(Icons.broken_image,
                      size: 24, color: Color.fromARGB(255, 255, 255, 255)),
                  label: 'Demanda',
                  backgroundColor: Color.fromARGB(255, 4, 125, 255),
                  onTap: () {
                    setState(() {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => AlertDialog(
                          actions: <Widget>[
                            Column(
                              children: <Widget>[
                                if (imageFile_demanda != null)
                                  Container(
                                    width: 420,
                                    height: 320,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      image: DecorationImage(
                                          image: FileImage(imageFile_demanda!),
                                          fit: BoxFit.cover),
                                      border: Border.all(
                                          width: 8, color: Colors.black),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  )
                                else if (imagen_demanda.isNotEmpty)
                                  Container(
                                    width: 420,
                                    height: 320,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      image: DecorationImage(
                                          image: MemoryImage(imagen_demanda),
                                          fit: BoxFit.cover),
                                      border: Border.all(
                                          width: 8, color: Colors.black),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  )
                                else
                                  Container(
                                    width: 420,
                                    height: 320,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      border: Border.all(
                                          width: 8, color: Colors.black12),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: const Text(
                                      'No hay Imagen!',
                                      style: TextStyle(fontSize: 26),
                                    ),
                                  ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 130),
                              child: Row(
                                children: [
                                  TextButton(
                                    child: const Text('Tomar Foto'),
                                    onPressed: () => getFotoDemanda(
                                        source: ImageSource.camera),
                                  ),
                                  TextButton(
                                    child: const Text('Cerrar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  }),
            if (lista_mediciones.length >= 2)
              SpeedDialChild(
                child: const Icon(Icons.image_outlined,
                    size: 24, color: Color.fromARGB(255, 255, 255, 255)),
                label: 'Lectura Reactiva',
                backgroundColor: Color.fromARGB(255, 4, 125, 255),
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => AlertDialog(
                      actions: <Widget>[
                        Column(
                          children: <Widget>[
                            if (imageFile_reactiva != null)
                              Container(
                                width: 420,
                                height: 320,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  image: DecorationImage(
                                      image: FileImage(imageFile_reactiva!),
                                      fit: BoxFit.cover),
                                  border:
                                      Border.all(width: 8, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              )
                            else if (imagen_reactiva.isNotEmpty)
                              Container(
                                width: 420,
                                height: 320,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  image: DecorationImage(
                                      image: MemoryImage(imagen_reactiva),
                                      fit: BoxFit.cover),
                                  border:
                                      Border.all(width: 8, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              )
                            else
                              Container(
                                width: 420,
                                height: 320,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(
                                      width: 8, color: Colors.black12),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: const Text(
                                  'No hay Imagen!',
                                  style: TextStyle(fontSize: 26),
                                ),
                              ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 130),
                          child: Row(
                            children: [
                              TextButton(
                                child: const Text('Tomar Foto'),
                                onPressed: () =>
                                    getFotoReactiva(source: ImageSource.camera),
                              ),
                              TextButton(
                                child: const Text('Cerrar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            if (lista_mediciones.isNotEmpty)
              SpeedDialChild(
                child: const Icon(Icons.photo_size_select_actual_rounded,
                    size: 24, color: Color.fromARGB(255, 255, 255, 255)),
                label: 'Lectura Activa',
                backgroundColor: Color.fromARGB(255, 4, 125, 255),
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => AlertDialog(
                      actions: <Widget>[
                        Column(
                          children: <Widget>[
                            if (imageFile_activa != null)
                              Container(
                                width: 420,
                                height: 320,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  image: DecorationImage(
                                      image: FileImage(imageFile_activa!),
                                      fit: BoxFit.cover),
                                  border:
                                      Border.all(width: 8, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              )
                            else if (imagen_activa.isNotEmpty)
                              Container(
                                width: 420,
                                height: 320,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  image: DecorationImage(
                                      image: MemoryImage(imagen_activa),
                                      fit: BoxFit.cover),
                                  border:
                                      Border.all(width: 8, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              )
                            else
                              Container(
                                width: 420,
                                height: 320,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(
                                      width: 8, color: Colors.black12),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: const Text(
                                  'No hay Imagen!',
                                  style: TextStyle(fontSize: 26),
                                ),
                              )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 130),
                          child: Row(
                            children: [
                              TextButton(
                                child: const Text('Tomar Foto'),
                                onPressed: () =>
                                    getFotoActiva(source: ImageSource.camera),
                              ),
                              TextButton(
                                child: const Text('Cerrar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
          ]),

      ///////////////////////////////////////////
    );
  }

  //FUNCION ACTIVAR DESACTIVAR BOTON GUARDAR

  bool enableSaveButton() {
    if (lista_mediciones.length == 1) {
      if (lecturaActivaController.text != "" &&
          lecturaActivaController.text != null &&
          imagen_activa.length > 0 &&
          dropvalor != "") {
        return true;
      } else {
        return false;
      }
    } else if (lista_mediciones.length == 2) {
      print("----------------2mdiciones-------------------");
      print(lecturaActivaController.text);
      print(lecturaReactivaController.text);
      print(demandaController.text);
      print(imagen_activa.length);
      print(imagen_reactiva.length);
      print(imagen_demanda.length);
      print(dropvalor);
      print("----------------2mdiciones-------------------");

      if (lecturaActivaController.text != "" &&
          lecturaActivaController.text != null &&
          lecturaReactivaController.text != "" &&
          lecturaReactivaController.text != null &&
          demandaController.text != "" &&
          demandaController.text != null &&
          imagen_activa.length > 0 &&
          imagen_reactiva.length > 0 &&
          imagen_demanda.length > 0 &&
          dropvalor != "") {
        print("-------------------T");
        return true;
      } else {
        print("-------------------F");
        return false;
      }
    } else {
      return false;
    }
  }

  //////////////////////
  Future rangoNuevaMedicion() async {
    if (dropvalor != "99") {
      nuevoRegistro();
    } else {
      if (lista_mediciones.length == 1) {
        Medicion _medicion = lista_mediciones[0];

        int nuevaLecturaActiva = int.parse(lecturaActivaController.text);
        int cp_a = _medicion.consumo_promedio;
        int vc = nuevaLecturaActiva - _medicion.lectura_anterior;

        double min = cp_a * 0.8;
        double max = cp_a * 2;

        if (vc > max) {
          mostrarAlertas(
              "EL valor de la lectura activa exede del valor promedio!", "");
        } else if (vc < min) {
          mostrarAlertas(
              "EL valor de la lectura activa es menor al valor promedio!", "");
        } else {
          nuevoRegistro();
        }
      } else if (lista_mediciones.length == 2) {
        String _altertaActiva = "";
        String _altertaReactiva = "";

        Medicion _medicionActiva = lista_mediciones[0];
        Medicion _medicionReactiva = lista_mediciones[1];

        int nuevaLecturaActiva = int.parse(lecturaActivaController.text);
        int nuevaLecturaReactiva = int.parse(lecturaReactivaController.text);

        int cp_a = _medicionActiva.consumo_promedio;
        int cp_r = _medicionReactiva.consumo_promedio;

        int vc_a = nuevaLecturaActiva - _medicionActiva.lectura_anterior;
        int vc_r = nuevaLecturaReactiva - _medicionReactiva.lectura_anterior;

        double min_a = cp_a * 0.8;
        double max_a = cp_a * 2;

        double min_r = cp_r * 0.8;
        double max_r = cp_r * 2;

        if (vc_a > max_a) {
          _altertaActiva =
              "EL valor de la lectura activa exede del valor promedio!";
        } else if (vc_a < min_a) {
          _altertaActiva =
              "EL valor de la lectura activa es menor al valor promedio!";
        }

        if (vc_r > max_r) {
          _altertaReactiva =
              "EL valor de la lectura reactiva exede del valor promedio!";
        } else if (vc_r < min_r) {
          _altertaReactiva =
              "EL valor de la lectura reactiva es menor al valor promedio!";
        }

        if (_altertaActiva == "" && _altertaReactiva == "") {
          nuevoRegistro();
        } else {
          mostrarAlertas(_altertaActiva, _altertaReactiva);
        }
      }
    }
  }
  //////////////////////

  void mostrarAlertas(String _textoActiva, String _textoReactiva) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              title: Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Row(children: const [
                  Image(
                    image: AssetImage('assets/images/alert1.png'),
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(width: 10),
                  Text('Aviso!')
                ]),
              ),
              content: SizedBox(
                height: 80,
                child: Column(children: [
                  Text(_textoActiva.toString(), style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text(_textoReactiva.toString(),
                      style: TextStyle(fontSize: 18)),
                ]),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("Guardar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    nuevoRegistro();
                  },
                ),
                TextButton(
                  child: const Text("Cerrar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  //////////////////////////////////////////////////////////////////////////////////
  ///Guardar

  /// Obtener datos en tabla

  Future<List<DropdownMenuItem<Object>>> getEstados() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('medidores.db').build();
    final estadoDao = database.estadoDao;

    List<Estado> lista_estados = await estadoDao.findAllEstados();
    List<DropdownMenuItem<Object>> listadropdown = await lista_estados
        .map((_estado) => DropdownMenuItem(
              value: _estado.codigo,
              child: Text(_estado.descripcion),
            ))
        .toList();
    return listadropdown;
  }

  //camara

  void getFotoActiva({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1360,
        maxHeight: 768,
        imageQuality: 50 //0 - 100
        );

    if (file?.path != null) {
      setState(() {
        imageFile_activa = File(file!.path);
        imagen_activa = imageFile_activa!.readAsBytesSync();
      });

      Navigator.pop(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          actions: <Widget>[
            Column(
              children: <Widget>[
                if (imageFile_activa != null)
                  Container(
                    width: 420,
                    height: 320,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      image: DecorationImage(
                          image: FileImage(imageFile_activa!),
                          fit: BoxFit.cover),
                      border: Border.all(width: 8, color: Colors.black),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  )
                else
                  Container(
                    width: 420,
                    height: 320,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(width: 8, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Text(
                      'La fotografia aparecera aqui!',
                      style: TextStyle(fontSize: 26),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  TextButton(
                    child: const Text('Tomar Foto'),
                    onPressed: () => getFotoActiva(source: ImageSource.camera),
                  ),
                  TextButton(
                    child: const Text('Cerrar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  void getFotoReactiva({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1360,
        maxHeight: 768,
        imageQuality: 50 //0 - 100
        );

    if (file?.path != null) {
      setState(() {
        imageFile_reactiva = File(file!.path);
        imagen_reactiva = imageFile_reactiva!.readAsBytesSync();
      });
      Navigator.pop(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          actions: <Widget>[
            Column(
              children: <Widget>[
                if (imageFile_reactiva != null)
                  Container(
                    width: 420,
                    height: 320,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      image: DecorationImage(
                          image: FileImage(imageFile_reactiva!),
                          fit: BoxFit.cover),
                      border: Border.all(width: 8, color: Colors.black),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  )
                else
                  Container(
                    width: 420,
                    height: 320,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(width: 8, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Text(
                      'No hay Imagen!',
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 130),
              child: Row(
                children: [
                  TextButton(
                    child: const Text('Tomar Foto'),
                    onPressed: () =>
                        getFotoReactiva(source: ImageSource.camera),
                  ),
                  TextButton(
                    child: const Text('Cerrar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  void getFotoDemanda({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1360,
        maxHeight: 768,
        imageQuality: 50 //0 - 100
        );

    if (file?.path != null) {
      setState(() {
        imageFile_demanda = File(file!.path);
        imagen_demanda = imageFile_demanda!.readAsBytesSync();
      });
      Navigator.pop(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          actions: <Widget>[
            Column(
              children: <Widget>[
                if (imageFile_demanda != null)
                  Container(
                    width: 420,
                    height: 320,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      image: DecorationImage(
                          image: FileImage(imageFile_demanda!),
                          fit: BoxFit.cover),
                      border: Border.all(width: 8, color: Colors.black),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  )
                else
                  Container(
                    width: 420,
                    height: 320,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(width: 8, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Text(
                      'No hay Imagen!',
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 130),
              child: Row(
                children: [
                  TextButton(
                    child: const Text('Tomar Foto'),
                    onPressed: () => getFotoDemanda(source: ImageSource.camera),
                  ),
                  TextButton(
                    child: const Text('Cerrar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  /////////Obtener Fecha Sistema
  String getDate() {
    DateTime fecha = DateTime.now();
    return fecha.toString();
  }

  String customFormatDateImage(String _fecha) {
    DateTime fecha = DateTime.parse(_fecha);
    List<String> _arrayFecha = _fecha.toString().split(" ");
    List<String> _arrayFecha2 = _arrayFecha[0].split("-");
    List<String> _arrayTiempo = _arrayFecha[1].split(":");

    return '${_arrayFecha2[2]}${_arrayFecha2[1]}${_arrayFecha2[0]}${_arrayTiempo[0]}${_arrayTiempo[1]}';
  }

  String customFormatDate(String _fecha) {
    DateTime fecha = DateTime.parse(_fecha);
    List<String> _arrayFecha = _fecha.toString().split(" ");
    return _arrayFecha[0];
  }

  void nuevoRegistro() {
    EnvioAPI conexionApi = EnvioAPI();
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
                  Text('Guardando datos...')
                ],
              ),
            ),
          );
        });

    List<NuevaMedicion> lista = [];
    if (lista_mediciones.length == 1) {
      String _fecha = getDate();
      NuevaMedicion _act = NuevaMedicion(
          cuenta: cuentaController.text,
          tipo: lista_mediciones[0].tipo_medidor,
          estado: dropvalor,
          estado_envio: false,
          fecha: customFormatDate(_fecha),
          foto: imagen_activa,
          lectura: int.parse(lecturaActivaController.text),
          nombreFoto:
              '${cuentaController.text}_${medidorController.text}_${lista_mediciones[0].tipo_medidor}_${customFormatDateImage(_fecha)}.png',
          num_medidor: medidorController.text);
      lista.add(_act);
      conexionApi.guardarMediciones(lista, null).whenComplete(() => {
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => TablaAllMedidores(
                          ruta: _ruta,
                          sector: _sector,
                        ))),
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => TablaAllMedidores(
                          ruta: _ruta,
                          sector: _sector,
                        ))),
            limpiarCampos()
          });
    } else if (lista_mediciones.length == 2) {
      String _fecha = getDate();
      NuevaMedicion _act = NuevaMedicion(
          cuenta: cuentaController.text,
          tipo: lista_mediciones[0].tipo_medidor,
          estado: dropvalor,
          estado_envio: false,
          fecha: customFormatDate(_fecha),
          foto: imagen_activa,
          lectura: int.parse(lecturaActivaController.text),
          nombreFoto:
              '${cuentaController.text}_${medidorController.text}_${lista_mediciones[0].tipo_medidor}_${customFormatDateImage(_fecha)}.png',
          num_medidor: medidorController.text);
      NuevaMedicion _reac = NuevaMedicion(
          cuenta: cuentaController.text,
          tipo: lista_mediciones[1].tipo_medidor,
          estado: dropvalor,
          estado_envio: false,
          fecha: customFormatDate(_fecha),
          foto: imagen_reactiva,
          lectura: int.parse(lecturaReactivaController.text),
          nombreFoto:
              '${cuentaController.text}_${medidorController.text}_${lista_mediciones[1].tipo_medidor}_${customFormatDateImage(_fecha)}.png',
          num_medidor: medidorController.text);
      lista.add(_act);
      lista.add(_reac);
      Demanda _dem = Demanda(
          cuenta: cuentaController.text,
          lectura: double.parse(demandaController.text),
          nombreFoto:
              '${cuentaController.text}_${medidorController.text}_DM_${customFormatDateImage(_fecha)}.png',
          foto: imagen_demanda,
          id_nueva_medicion: 0,
          estado_envio: false);
      conexionApi.guardarMediciones(lista, _dem).whenComplete(() => {
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => TablaAllMedidores(
                          ruta: _ruta,
                          sector: _sector,
                        ))),
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => TablaAllMedidores(
                          ruta: _ruta,
                          sector: _sector,
                        ))),
            limpiarCampos()
          });
    }
  }

  void limpiarCampos() {
    print("--------------------LIMPIARCAMPOS");
    lecturaActivaController.text = "";
    lecturaReactivaController.text = "";
    demandaController.text = "";

    imageFile_activa = null;
    imageFile_reactiva = null;
    imageFile_demanda = null;

    imagen_activa = Uint8List(0);
    imagen_reactiva = Uint8List(0);
    imagen_demanda = Uint8List(0);
    setState(() {});
  }

  void cambiarEstado(String _estado) {
    if (_estado != "99") {
      if (lista_mediciones.length == 1) {
        estado_nv = false;
        estado_reactiva = false;
        lecturaActivaController.text = "0";
        lecturaReactivaController.text = "";
        demandaController.text = "";
      } else if (lista_mediciones.length == 2) {
        estado_nv = false;
        estado_reactiva = false;
        lecturaActivaController.text = "0";
        lecturaReactivaController.text = "0";
        demandaController.text = "0";
      }
    } else {
      if (lista_mediciones.length == 1) {
        estado_nv = true;
        estado_reactiva = false;
        lecturaActivaController.text = "";
        lecturaReactivaController.text = "";
        demandaController.text = "";
      } else if (lista_mediciones.length == 2) {
        estado_nv = true;
        estado_reactiva = true;
        lecturaActivaController.text = "";
        lecturaReactivaController.text = "";
        demandaController.text = "";
      }
    }
  }

  void actualizarEstados() {
    setState(() {});
  }

  Map<String, dynamic> convertMap(double coordenada_x, double coordenada_y) {
    final latlon = UTM.fromUtm(
      easting: coordenada_x,
      northing: coordenada_y,
      zoneNumber: 17,
      zoneLetter: 'M',
    );

    Map<String, dynamic> coordenadas = {
      "coordenada_x": latlon.lat,
      "coordenada_y": latlon.lon
    };
    return coordenadas;
  }

  activarCajas() {
    if (lista_mediciones.length == 1) {
      estado_reactiva = false;
      estado_nv = true;
    } else if (lista_mediciones.length == 2) {
      estado_reactiva = true;
      estado_nv = true;
    } else if (lista_mediciones.isEmpty) {
      estado_reactiva = false;
      estado_nv = false;
    }
  }

  Future<void> llenarDatos() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('medidores.db').build();
    //DAO MEDIDOR
    final medidorDao = database.medidorDao;

    //DAO LISTA MEDICIONES
    final medicionesDao = database.medicionDao;

    //DAO NUEVA MEDICION
    final nuevaMedicionDao = database.nuevamedicionDao;

    //DAO DEMANDA
    final demandaDao = database.demandaDao;

    //llenar MEDIDOR CUENTA
    Medidor? _dataMedidor = await medidorDao.findMedidorById(_numMedidor);
    lista_mediciones = await medicionesDao.findMedicionesOfMedidor(_numMedidor);

    //LEBAR CAJAS DE TEXTO MEDIDOR CUENTA
    medidorController.text = await _dataMedidor!.num_medidor;
    cuentaController.text = await _dataMedidor!.cuenta_id;

    //LLENAR MEDICIONES TOMADAS
    List<NuevaMedicion> _medicionesTomadas =
        await nuevaMedicionDao.findMedicionesOfMedidor(_numMedidor);
    _medicionesTomadas.forEach((_med) async {
      if (_med.tipo == 'EA') {
        dropvalor = _med.estado;
        lecturaActivaController.text = _med.lectura.toString();
        imagen_activa = _med.foto;
      } else {
        lecturaReactivaController.text = _med.lectura.toString();
        imagen_reactiva = _med.foto;
        Demanda? _demandaTomada = await demandaDao.findByMedicionId(_med.id!);
        demandaController.text = _demandaTomada!.lectura.toString();
        imagen_demanda = _demandaTomada!.foto;
      }
      activarCajas();
    });
  }
}

////////////////////////////////////////////////////////////////////
