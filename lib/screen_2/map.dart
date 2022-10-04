import 'package:applect_json/db.dart';
import 'package:applect_json/entity/medidor.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:utm/utm.dart';

late int _ruta;
late int _sector;

class ScreenMaps extends StatefulWidget {
  ScreenMaps({
    Key? key,
    @required sector,
    @required ruta,
  }) : super(key: key) {
    _ruta = ruta;
    _sector = sector;
  }

  @override
  State<ScreenMaps> createState() => _ScreenMapsState();
}

class _ScreenMapsState extends State<ScreenMaps> {
  Future<Iterable<Marker>> obtenerPuntos() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('medidores.db').build();
    final medidorDao = database.medidorDao;
    List<Medidor> _lista_medidores =
        await medidorDao.findAllMedidoresByRutaSector(_ruta, _sector);

    List<Marker> _makers = [];
    _lista_medidores.forEach((_med) {
      if (_med.coordenada_x == 0.0 ||
          _med.coordenada_x == 0 ||
          _med.coordenada_y == 0.0 ||
          _med.coordenada_y == 0 ||
          _med == null) {
      } else {
        Map<String, dynamic> _coords =
            convertMap(_med.coordenada_x, _med.coordenada_y);
        Marker _ruta = Marker(
            markerId: MarkerId(_med.num_medidor),
            position: LatLng(_coords["coordenada_x"], _coords["coordenada_y"]),
            infoWindow: InfoWindow(
                title:
                    'Secuencia: ${_med.secuencia} - Medidor: ${_med.num_medidor}'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
        _makers.add(_ruta);
      }
    });

    return await _makers;
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

  final _initialCameraPosition = const CameraPosition(
    target: LatLng(-1.242044, -78.624503),
    zoom: 12,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:

              //padding: const EdgeInsets.only(right: 40.0),
              const Text('Mapa'),
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
          ),
        ),
        body: FutureBuilder(
            future: obtenerPuntos(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              Widget dibujo;
              if (snapshot.hasData) {
                dibujo = GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  markers: Set.from(snapshot.data),
                );
              } else {
                dibujo = const Padding(
                    padding: EdgeInsets.only(top: 320, left: 180),
                    child: CircularProgressIndicator());
              }
              return dibujo;
            }));
  }
}
