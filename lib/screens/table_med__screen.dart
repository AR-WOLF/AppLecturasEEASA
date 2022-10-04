import 'package:applect_json/entity/medidor.dart';
import 'package:applect_json/entity/usuario.dart';
import 'package:applect_json/screen_2/info_cliente_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../db.dart';
import '../screen_2/lect_med_2_screen.dart';
import '../screen_2/table_med_screen_2.dart';

class TablaMedidores extends StatefulWidget {
  TablaMedidores({Key? key}) : super(key: key);

  @override
  State<TablaMedidores> createState() => _LecturaTablaState();
}

class _LecturaTablaState extends State<TablaMedidores> {
  // late List<_Row> _employees;
  // late _DataSource _employeeDataSource;

  @override
  void initState() {
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
        title: const Text('Lista Rutas',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            )),
        centerTitle: true,
        /*actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add_a_photo,
                size: 27.0,
                color: Color.fromARGB(255, 236, 243, 255),
              ),
              onPressed: () {},
            ),
          ],*/
      ),

      /////////////////////////////////////////////////

      body: Form(
        child: FutureBuilder(
            future: getDataSource(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                children = <Widget>[
                  Flexible(
                    child: SizedBox(
                      height: 545.0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 50.0, right: 40.0, top: 0.0),
                        child: ListView(
                          padding: const EdgeInsets.all(8),
                          children: <Widget>[
                            /* Theme(
                                  data: Theme.of(context).copyWith(
                                    cardColor: Color.fromARGB(255, 255, 255, 255),
                                    dividerColor:
                                        Color.fromARGB(255, 111, 111, 112),
                                  ),*/

                            PaginatedDataTable(
                              //header: const Text('Rutas:'),
                              columns: const [
                                DataColumn(
                                    label: SizedBox(
                                  child: Text('Sector',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 10, 105, 221))),
                                )),
                                DataColumn(
                                    label: Text('Ruta',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 10, 105, 221)))),
                              ],
                              columnSpacing: 45,
                              horizontalMargin: 30,
                              rowsPerPage: 9,
                              showCheckboxColumn: false,
                              source: snapshot.data,
                              dataRowHeight: 45.0,
                              //showFirstLastButtons: true,

                              //arrowHead:false,

                              arrowHeadColor: Color.fromARGB(255, 7, 97, 233),
                              //headingRowHeight: 25.0,
                            ),
                          ],
                        ),
                      ),

                      //Expanded(
                    ),
                  ),
                  SizedBox(
                    //sheight: deviceHeight * 0.30,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: const <Widget>[
                          Image(
                              image: AssetImage('assets/images/4895597.png'),
                              height: 100,
                              width: 140,
                              color: Color.fromRGBO(255, 255, 255, 0.6),
                              colorBlendMode: BlendMode.modulate),
                        ],
                      ),
                    ),
                  ),
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

                  /*
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Cargando Datos...'),
                    )*/
                ];
              }

              return Container(
                child: Column(
                  //mainAxisAlignment : MainAxisAlignment.start,
                  children: children,
                ),
              );
            }),
      ),

      ///////////////////////////////////////////
    );
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<_DataSource> getDataSource() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('medidores.db').build();
    final medidorDao = database.medidorDao;

    Stream<List<dynamic>> _stream_listamedidores =
        await medidorDao.findAllfindAllRutas();
    List<dynamic> rutas =
        await _stream_listamedidores.firstWhere((element) => true);

    Iterable<dynamic> listred = await rutas.map((e) => _Row(e[0], e[1]));

    List<_Row> listafinal = await List.from(listred);
    return _DataSource(context, listafinal);
  }
}

////////////////////////////////////////////////////////////////////

class _Row {
  _Row(this.sector, this.ruta);

  final int sector;
  final int ruta;

  bool selected = false;

  @override
  String toString() {
    return ("$sector" + " " + "$ruta");
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
      selected: false,
      onSelectChanged: (bool? value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TablaAllMedidores(ruta: row.sector, sector: row.ruta)));
      },
      cells: [
        DataCell(Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child:
              Text(row.sector.toString(), style: const TextStyle(fontSize: 18)),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child:
              Text(row.ruta.toString(), style: const TextStyle(fontSize: 18)),
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
}
