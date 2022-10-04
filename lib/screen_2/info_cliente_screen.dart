import 'package:url_launcher/url_launcher.dart';
import 'package:applect_json/db.dart';
import 'package:applect_json/entity/medidor.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:utm/utm.dart';

///////////////////////////////////////////////////////////\
final _formKey = GlobalKey<FormState>();

final clienteController = TextEditingController();
final direccionController = TextEditingController();
final medidorIdController = TextEditingController();
final zonaController = TextEditingController();
final sectorController = TextEditingController();
final rutaController = TextEditingController();
final secuenciaController = TextEditingController();
final promedioController = TextEditingController();
final demandfController = TextEditingController();
final coordxController = TextEditingController();
final coordyController = TextEditingController();

late String medidor_id;
late double xl = 0.0;
late double yl = 0.0;

class InformacionCliente extends StatefulWidget {
  InformacionCliente({Key? key, @required medidorId}) : super(key: key) {
    medidor_id = medidorId;
  }

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<InformacionCliente> {
  openMapsSheet(context) async {
    try {
      Map<String, dynamic> coordenadas = convertMap(
          double.parse(coordxController.text),
          double.parse(coordyController.text));

      dynamic x = coordenadas['coordenada_x'];
      dynamic y = coordenadas['coordenada_y'];
      final coords = Coords(x, y);
      final title = "Ruta";
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  late AppDatabase database;
  @override
  void initState() {
    super.initState();
    llenarCampos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 241, 247, 253),

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
          title: const Text('Información Cliente',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
              )),
          centerTitle: true,
        ),

        /////////////////////////////////////////////////

        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              // padding: const EdgeInsets.all(20),

              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  //const SizedBox(height: 10.0),
                  ///////////////////////////////////////////////////

                  child: Column(
                    children: [
                      SizedBox(
                        //sheight: deviceHeight * 0.30,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            children: const <Widget>[
                              Image(
                                  image: AssetImage('assets/images/user2.png'),
                                  height: 80,
                                  width: 80,
                                  color: Color.fromRGBO(255, 255, 255, 0.8),
                                  colorBlendMode: BlendMode.modulate),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Apellido & Nombre:",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          )),
                      const SizedBox(height: 12.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: TextFormField(
                          controller: clienteController,
                          decoration: InputDecoration(
                            enabled: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0)),

                            hintText: 'Apellidos Nombres',
                            // labelText: 'Cliente',
                            isDense: true,
                            contentPadding: const EdgeInsets.all(13),
                          ),
                          keyboardType: TextInputType.text,
                          /*inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],*/
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Direccón:",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          )),
                      const SizedBox(height: 12.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: TextFormField(
                          enabled: false,
                          controller: direccionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0)),

                            hintText: 'JOSE J. OLMEDO 02 53 Y MONTALVO',
                            //labelText: 'Direccion',
                            isDense: true,
                            contentPadding: EdgeInsets.all(13),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Medidor:",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          )),
                      const SizedBox(height: 12.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 260.0),
                        child: TextFormField(
                          enabled: false,
                          controller: medidorIdController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0)),

                            hintText: '00000',
                            //labelText: 'Medidor',
                            isDense: true,
                            contentPadding: EdgeInsets.all(13),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(height: 15.0),

                      //////////////////////////////////////////////////////////////////
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          SizedBox(width: 0.0),
                          Text(
                            "Zona:",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          SizedBox(width: 93.0),
                          Text(
                            "Sector:",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          SizedBox(width: 35.0),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Ruta:",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Sec:",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          SizedBox(width: 0.0),
                        ],
                      ),

                      const SizedBox(height: 7.0),
                      ///////////////////////////////////////////////////////////
                      ///    fila 4inputs

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 0.0, left: 0.0),
                              child: TextFormField(
                                enabled: false,
                                controller: zonaController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.0)),

                                  hintText: 'A(AMB.URB)-B1',
                                  // labelText: 'Cliente',
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(13),
                                ),
                                keyboardType: TextInputType.text,
                                /*inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],*/
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 00.0,
                          ),
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 45.0, right: 0.0),
                              child: TextFormField(
                                enabled: false,
                                controller: sectorController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.0)),

                                  hintText: '0',
                                  // labelText: 'Cliente',
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(13),
                                ),
                                keyboardType: TextInputType.number,
                                /*inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],*/
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 0.0,
                          ),
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 45.0, right: 0.0),
                              child: TextFormField(
                                enabled: false,
                                controller: rutaController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.0)),

                                  hintText: '0',
                                  // labelText: 'Cliente',
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(13),
                                ),
                                keyboardType: TextInputType.number,
                                /*inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],*/
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 0.0,
                          ),
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 25.0, right: 0.0),
                              child: TextFormField(
                                enabled: false,
                                controller: secuenciaController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.0)),

                                  hintText: '0',
                                  // labelText: 'Cliente',
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(13),
                                ),
                                keyboardType: TextInputType.number,
                                /*inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],*/
                              ),
                            ),
                          ),
                        ],
                      ),

                      //////////////////////////////////////////////////////////////////////

                      const SizedBox(height: 20.0),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          SizedBox(width: 0.0),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Coordenada X:",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )),
                          SizedBox(width: 32.0),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Coordenada Y:",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )),
                          SizedBox(width: 10.0),
                        ],
                      ),

                      const SizedBox(height: 15.0),
                      ///////////////////////////////////////////////////////////

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 22.0),
                              child: TextFormField(
                                enabled: false,
                                controller: coordxController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.0)),

                                  hintText: '000000.0000',
                                  // labelText: 'Cliente',
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(13),
                                ),
                                keyboardType: TextInputType.number,
                                /*inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],*/
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: TextFormField(
                                enabled: false,
                                controller: coordyController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.0)),

                                  hintText: '0000000.000',
                                  // labelText: 'Cliente',
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(13),
                                ),
                                keyboardType: TextInputType.number,
                                /*inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],*/
                              ),
                            ),
                          ),
                          const SizedBox(width: 0.0),
                          /*
                          SizedBox(
                            height: 45.0,
                            width: 45.0,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: FloatingActionButton(
                                  // heroTag: "btn2",
                                  // mini: true,
                                  child: const Icon(Icons.location_on_outlined,
                                      size: 24),
                                  backgroundColor:
                                      Color.fromARGB(255, 54, 141, 240),
                                  onPressed: () {
                                    openMap();
                                  }),
                            ),
                          ),
                          */

                          const SizedBox(width: 8.0),
                          SizedBox(
                            height: 45.0,
                            width: 45.0,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: FloatingActionButton(
                                  // heroTag: "btn2",
                                  // mini: true,
                                  child: const Icon(Icons.pin_drop_sharp,
                                      size: 24),
                                  backgroundColor:
                                      Color.fromARGB(255, 54, 141, 240),
                                  onPressed: () => openMapsSheet(context)),
                            ),
                          ),
                          const SizedBox(width: 0.0),
                        ],
                      ),

                      ////////////////////////////////////////////////////////////////////////
                    ],
                  )),

              //////////////////////////////////////////////////
            )));
  }

  Future<void> llenarCampos() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('medidores.db').build();
    final medidorDao = database.medidorDao;
    final clienteDao = database.clienteDao;
    final medicionDao = database.medicionDao;

    final _medidor = await medidorDao.findMedidorById(medidor_id);
    //final _medicion = await medicionDao.findByMedidorId(medidor_id); //**ESTA CONSULTA DEVUELVE UNA LISTA!!!
    final _cliente = await clienteDao.findClienteById(_medidor!.cuenta_id);
    print("%%%%%%%%%%");
    print(_medidor.toString());
    print(_cliente.toString());
    print("%%%%%%%%%%");

    clienteController.text = _cliente!.apellido + " " + _cliente.nombre;
    direccionController.text = _cliente.direccion;
    medidorIdController.text = _medidor.num_medidor;
    zonaController.text = _medidor.zona!;
    sectorController.text = _medidor.sector.toString();
    rutaController.text = _medidor.ruta.toString();
    secuenciaController.text = _medidor.secuencia.toString();

    //promedioController.text = _medicion!.consumo_promedio.toString();
    //demandfController.text = _medidor.demanda_facturable.toString();
    coordxController.text = _medidor.coordenada_x.toString();
    coordyController.text = _medidor.coordenada_y.toString();
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

  Future<void> openMap() async {
    Map<String, dynamic> coordenadas = convertMap(
        double.parse(coordxController.text),
        double.parse(coordyController.text));

    dynamic x = coordenadas['coordenada_x'];
    dynamic y = coordenadas['coordenada_y'];

    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$x,$y';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'No se puede abrir el mapa.';
    }
  }
}
