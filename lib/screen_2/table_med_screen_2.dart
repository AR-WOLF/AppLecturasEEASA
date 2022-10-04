import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:applect_json/screen_2/actualizar_lectura.dart';
import 'package:http/http.dart' as http;
import 'package:applect_json/entity/medidor.dart';
import 'package:applect_json/entity/nueva_medicion.dart';
import 'package:applect_json/entity/usuario.dart';
import 'package:applect_json/screen_2/info_cliente_screen.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../db.dart';

var medidorController = TextEditingController();
var buscarmedidor = TextEditingController();

late int _ruta;
late int _sector;

class TablaAllMedidores extends StatefulWidget {
  TablaAllMedidores({Key? key, @required sector, @required ruta})
      : super(key: key) {
    _ruta = ruta;
    _sector = sector;
  }

  @override
  State<TablaAllMedidores> createState() => _LecturaTablaState();
}

class _LecturaTablaState extends State<TablaAllMedidores> {
  File? imageFile;
  final _formKey = GlobalKey<FormState>();

  // late List<_Row> _employees;
  // late _DataSource _employeeDataSource;

  @override
  void initState() {
    medidorController.clear();
    buscarmedidor.clear();
    super.initState();
  }

  Widget build(BuildContext context) {
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
        title: const Text('Lista Medidores',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            )),
        centerTitle: true,
      ),

      /////////////////////////////////////////////////

      body: Form(
        key: _formKey,
        child: FutureBuilder(
            future: getDataSource(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                children = <Widget>[
                  const SizedBox(height: 20.0),

                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 80.0,
                            top: 5.0,
                          ),
                          child: Container(
                            child: DropdownButton(
                                value: selectedValue,
                                underline: Container(
                                  height: 1,
                                  color: Color.fromARGB(255, 8, 123, 255),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue!;

                                    setState(() {});
                                  });
                                },
                                items: dropdownItems),
                          ),
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 40.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 50.0),
                            child: TextFormField(
                              controller: buscarmedidor,
                              onChanged: (text) {
                                print("/////////////////");
                                print(text);
                                print("/////////////////");
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.search),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                ),
                                hintText: 'Buscar',
                                //slabelText: 'Consumo Promedio',
                                isDense: true,
                                contentPadding: EdgeInsets.all(14),
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
                      ),
                    ],
                  ),

                  const SizedBox(height: 15.0),
                  Expanded(
                    child: SizedBox(
                      height: 600.0,
                      child: ListView(
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        children: [
                          PaginatedDataTable(
                            columns: const [
                              DataColumn(
                                  label: Text('#',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 10, 105, 221)))),
                              DataColumn(
                                  label: Text('Cuenta',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 10, 105, 221)))),
                              DataColumn(
                                  label: Text('Secuencia',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 10, 105, 221)))),
                              DataColumn(
                                  label: Text('Medidor',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 10, 105, 221)))),
                            ],
                            columnSpacing: 35,
                            horizontalMargin: 10,
                            rowsPerPage: 11,
                            showCheckboxColumn: false,
                            source: snapshot.data,
                            showFirstLastButtons: true,
                            arrowHeadColor: Color.fromARGB(245, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
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

      ///////////////////////////////////////////
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("TODOS"), value: "0"),
      DropdownMenuItem(child: Text("LEIDOS"), value: "1"),
      DropdownMenuItem(child: Text("NO LEIDOS"), value: "2")
    ];
    return menuItems;
  }

  String selectedValue = "0";

  //////////////////////////////////////////////////////////////////////////////////
  ///Guardar

  /// Obtener datos en tabla

  Future<_DataSource> getDataSource() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('medidores.db').build();
    final medidorDao = database.medidorDao;

    late List<Medidor> lista_medidores;
    print("---------------------------inicio");
    if (selectedValue == "0") {
      print("---------------------------0");
      print(buscarmedidor.text);
      if (buscarmedidor.text == "") {
        lista_medidores = await medidorDao.buscarTodoLNL(_ruta, _sector);
      } else {
        lista_medidores = await medidorDao.buscarLNLCadena(
            _ruta, _sector, buscarmedidor.text);
      }
    }
    if (selectedValue == "1") {
      print("---------------------------1");
      if (buscarmedidor.text == "") {
        print("---------------------------1 sin campo");
        lista_medidores = await medidorDao.buscarTodoLeido(_ruta, _sector);
      } else {
        print("---------------------------1 con campo");
        lista_medidores =
            await medidorDao.buscarLCadena(_ruta, _sector, buscarmedidor.text);
      }
    }
    if (selectedValue == "2") {
      print("---------------------------2");
      if (buscarmedidor.text == "") {
        lista_medidores =
            await medidorDao.findAllMedidoresNoLectura(_ruta, _sector);
      } else {
        lista_medidores =
            await medidorDao.buscarNLCadena(_ruta, _sector, buscarmedidor.text);
      }
    }

    Iterable<dynamic> listred1 = await lista_medidores;
    /*
          .where((e) => e.num_medidor.contains(buscarmedidor.text))
          .toList();
*/
    Iterable<dynamic> listred = await listred1.map((e) => _Row(
          e.cuenta_id,
          e.secuencia,
          e.num_medidor,
        ));

    List<_Row> listafinal = await List.from(listred);
    print(listafinal.length);
    return _DataSource(context, listafinal);
  }
}

////////////////////////////////////////////////////////////////////

class _Row {
  _Row(
    this.cuenta,
    this.secuencia,
    this.num_medidor,
  );

  final String cuenta;
  final int secuencia;
  final String num_medidor;

  bool selected = false;

  @override
  String toString() {
    return ("$num_medidor" + " " + "$cuenta");
  }
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, List<_Row> _listaMedidores) {
    _rows = _listaMedidores;
  }

  final BuildContext context;
  late List<_Row> _rows;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (bool? value) {
        /*
        _rows.forEach((_allrows) {
          _allrows.selected = false;
        });
      
        row.selected = value!;
        notifyListeners();
        medidorController.text = row.num_medidor.toString();
        */ ////
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ActualizarLectura(
                      num_medidor: row.num_medidor,
                      ruta: _ruta,
                      sector: _sector,
                    )));
      },
      cells: [
        DataCell(Padding(
          padding: const EdgeInsets.only(left: 17.0),
          child: Text((index + 1).toString(),
              style: const TextStyle(fontSize: 16)),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child:
              Text(row.cuenta.toString(), style: const TextStyle(fontSize: 16)),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(row.secuencia.toString(),
              style: const TextStyle(fontSize: 16)),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(row.num_medidor.toString(),
              style: const TextStyle(fontSize: 16)),
        )),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

/*
  Future<List<_Row>> getData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('medidores.db').build();
    final medidorDao = database.medidorDao;
    List<Medidor> lista_medidores = await medidorDao.findAllMedidores();
    Iterable<dynamic> listred = await lista_medidores
        .map((e) => _Row(e.sector, e.ruta, e.secuencia, e.num_medidor));
    List<_Row> listafinal = await List.from(listred);
    return listafinal;
  }
*/

}
