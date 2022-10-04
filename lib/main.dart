import 'dart:async';
import 'dart:io';

import 'package:applect_json/async/check_internet.dart';
import 'package:applect_json/async/send_all_data.dart';
import 'package:applect_json/get_estado.dart';
import 'package:applect_json/inicializar.dart';
import 'package:applect_json/login_2.dart';
import 'package:applect_json/router/app_routes.dart';
import 'package:applect_json/screens/download_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Future<void> connectionChanged(dynamic hasConnection) async {
    if (hasConnection == true) {
      Fluttertoast.showToast(
          msg: "Vuelves a tener conexion a internet!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromARGB(255, 20, 173, 255),
          textColor: Color.fromARGB(255, 255, 255, 255),
          fontSize: 11.0);
      sendAll sendAllData = sendAll();
      await sendAllData.enviarTodo();
    } else if (hasConnection == false) {
      Fluttertoast.showToast(
          msg: "Sin conexion a internet!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromARGB(255, 20, 173, 255),
          textColor: Color.fromARGB(255, 255, 255, 255),
          fontSize: 11.0);
    }
  }

  StreamSubscription _connectionChangeStream;
  ConnectionStatusCheck connectionStatus = ConnectionStatusCheck.getInstance();
  connectionStatus.initialize();
  _connectionChangeStream =
      connectionStatus.connectionChange.listen(connectionChanged);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //downloadScreen x = downloadScreen();
    // x.main();

    //obtenerEstados y = obtenerEstados();
    // y.main();

    //certificado ssl
    HttpOverrides.global = MyHttpOverrides();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      initialRoute: AppRoutes.mainRoute,
      routes: AppRoutes.getAppRoutes(),
    );
  }
}

//certificado ssl

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
