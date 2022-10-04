import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../login_2.dart';
import '../router/app_routes.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();

    verificarToken();
  }

  verificarToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setString("local_token",
    // "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJFRUFTQSIsInVzdWFyaW8iOiJhcm9kcmlndWV6IiwicGVyZmlsIjoiTGVjdG9yIn0.-eFsdqBO5RzvQG3zy9cjfWbDt6-2vlQhLP5OKI10Go9kGXMQZhORNjrzgWpFT630kUSrnQ9LWAv_rIyTNVHDQw");

    var tok = sharedPreferences.get("local_token");

    if (tok == null || tok == "") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ));
    }
  }

  salirApp() {
    Future.delayed(const Duration(milliseconds: 100), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  cerrarSession() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('local_token');
  }

  @override
  Widget build(BuildContext context) {
    final lista = AppRoutes.ListOptions;
    return Scaffold(
      ////////////////////////////////////////////////////////
      //CABECERA
      backgroundColor: const Color.fromARGB(248, 1, 54, 97),

      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 14.0, left: 14.0),
              child: Container(
                child: Image.asset(
                  'assets/images/LOGOE.png',
                  fit: BoxFit.fitHeight,
                  height: 31,
                  width: 31,
                ),
              ),
            ),
            Container(
                //padding: const EdgeInsets.only(right: 40.0),
                child: const Text('App Lecturas EEASA'))
          ],
        ),
/*
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            child: const Text("EEASA Lecturas App",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 23)),
          ),
        ),*/

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
        ),
      ),

      body: ListView(
        children: <Widget>[
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, top: 30),
            child: Row(
              children: <Widget>[
                SizedBox(width: 5.0, height: 60),
                /*Image.asset(
                  'assets/images/LOGOE.png',
                  fit: BoxFit.fitHeight,
                  height: 60,
                  width: 60,
                ),*/
                SizedBox(width: 10.0),
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text('Menú',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0)),
                ),
                SizedBox(width: 10.0),
                Text('Lecturas',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 30.0))
              ],
            ),
          ),
          const SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 239.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              //primary: false,
              padding:
                  const EdgeInsets.only(left: 25.0, right: 20.0, bottom: 50),
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height - 450.0,
                        child: ListView.separated(
                            itemBuilder: (context, i) => ListTile(
                                  leading: Icon(lista[i].icon,
                                      color: const Color.fromARGB(
                                          255, 89, 169, 235)),
                                  title: Text(lista[i].name,
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 1, 54, 96),
                                          fontSize: 20)),
                                  trailing: Icon(lista[i].icon2,
                                      color: const Color.fromARGB(
                                          255, 89, 169, 235)),
                                  onTap: () {
                                    if (lista[i].route == "ExitScreen") {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (_) => AlertDialog(
                                                title: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 90),
                                                  child: Row(children: const [
                                                    Image(
                                                      image: AssetImage(
                                                          'assets/images/logout2.png'),
                                                      height: 60,
                                                      width: 60,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text('')
                                                  ]),
                                                ),
                                                content: const Text(
                                                  'Está seguro que desea salir de la aplicación!',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                  textAlign: TextAlign.center,
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child:
                                                        const Text("Aceptar"),
                                                    onPressed: () {
                                                      cerrarSession();
                                                      salirApp();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text("Cerrar"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              ));
                                      // salirApp();
                                    } else {
                                      Navigator.pushNamed(
                                          context, lista[i].route);
                                    }
                                  },
                                ),
                            separatorBuilder: (_, __) => const Divider(
                                  height: 24,
                                  thickness: 0.1,
                                  indent: 2,
                                  endIndent: 7,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                            itemCount: lista.length))),
                SizedBox(
                  //sheight: deviceHeight * 0.30,

                  child: Column(
                    children: const <Widget>[
                      Image(
                          image: AssetImage('assets/images/eeasa1.png'),
                          height: 80,
                          width: 80,
                          color: Color.fromARGB(176, 255, 255, 255),
                          colorBlendMode: BlendMode.modulate),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
