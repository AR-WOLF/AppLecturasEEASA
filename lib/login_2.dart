import 'package:applect_json/screens/menu_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  var _visible = false;
  var _loader = true;

  Future<String> SingIn(String usuario, String contrasena) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse(
          "https://pagos.eeasa.com.ec/WSCortes/servicios/lecturas/login");

      final body = {"usuario": usuario, "contrasena": contrasena};
      dynamic jsonResponse;
      var res = await http.post(url,
          body: jsonEncode(body),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      //estatus
      if (res.statusCode >= 200 && res.statusCode <= 299) {
        jsonResponse = json.decode(res.body);
        if (jsonResponse["response"] != null) {
          sharedPreferences.setString("local_token", jsonResponse["response"]);
          //last login
          sharedPreferences.setString("username", usuario);
          sharedPreferences.setString("password", contrasena);
          sharedPreferences.setString("last_token", jsonResponse["response"]);
          //

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => MenuScreen()),
              (Route<dynamic> route) => false);

          return "OK";
        } else {
          return "EI";
        }
      } else {
        if (sharedPreferences.getString('username') == null ||
            sharedPreferences.getString('username') == '' ||
            sharedPreferences.getString('password') == null ||
            sharedPreferences.getString('password') == '' ||
            sharedPreferences.getString('last_token') == null ||
            sharedPreferences.getString('last_token') == '') {
          return "SE";
        } else {
          if (usuario == sharedPreferences.getString('username') &&
              contrasena == sharedPreferences.getString('password')) {
            sharedPreferences.setString(
                "local_token", sharedPreferences.getString('last_token')!);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => MenuScreen()),
                (Route<dynamic> route) => false);
            return "OK";
          } else {
            return "EI";
          }
        }
      }
    } catch (error) {
      if (sharedPreferences.getString('username') == null ||
          sharedPreferences.getString('username') == '' ||
          sharedPreferences.getString('password') == null ||
          sharedPreferences.getString('password') == '' ||
          sharedPreferences.getString('last_token') == null ||
          sharedPreferences.getString('last_token') == '') {
        return "SE";
      } else {
        if (usuario == sharedPreferences.getString('username') &&
            contrasena == sharedPreferences.getString('password')) {
          sharedPreferences.setString(
              "local_token", sharedPreferences.getString('last_token')!);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => MenuScreen()),
              (Route<dynamic> route) => false);
          return "OK";
        } else {
          return "EI";
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    //  final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              //sheight: deviceHeight * 0.30,
              child: Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Column(
                  children: const <Widget>[
                    Image(
                      image: AssetImage('assets/images/med23.jpg'),
                      height: 220,
                      width: 220,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: deviceHeight * 0.63,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'EEASA Lecturas',
                      style:
                          TextStyle(fontSize: 39, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.15,
                    ),
                    const Text('Ingrese el nombre de usuario y la contraseña'),
                    SizedBox(
                      height: constraints.maxHeight * 0.08,
                    ),

                    //////////////////////////////////////////////////////////
                    Container(
                      height: constraints.maxHeight * 0.11,
                      decoration: BoxDecoration(
                        color: const Color(0xffB4B4B4).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Center(
                          child: TextFormField(
                            enabled: _loader,
                            controller: _usuarioController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Usuario',
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: constraints.maxHeight * 0.04,
                    ),

                    //////////////////////////////////////////////////////////////////////////////////
                    Container(
                      height: constraints.maxHeight * 0.11,
                      decoration: BoxDecoration(
                        color: const Color(0xffB4B4B4).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Center(
                            child: TextFormField(
                          enabled: _loader,
                          controller: _contrasenaController,
                          obscureText: _visible ? false : true,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _visible = !_visible;
                                  });
                                },
                                icon: Icon(
                                  _visible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                )),
                            border: InputBorder.none,
                            hintText: 'Contraseña',
                          ),
                        )),
                      ),
                    ),

                    ///////////////////////////////////////////////////////

                    Container(
                      width: double.infinity,
                      height: constraints.maxHeight * 0.12,
                      margin: EdgeInsets.only(
                        top: constraints.maxHeight * 0.05,
                      ),
                      child: ElevatedButton(
                          onPressed: _loader == false
                              ? null
                              : () {
                                  _loader = false;
                                  setState(() {});
                                  SingIn(_usuarioController.text,
                                          _contrasenaController.text)
                                      .then((_isLoading) => {
                                            if (_isLoading == "EI")
                                              {
                                                setState(() {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          AlertDialog(
                                                            title: const Text(
                                                                'El Usuario y/o la Contraseña no son Correctas, Intentelo de Nuevo'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: const Text(
                                                                    'Cerrar'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              )
                                                            ],
                                                          ));
                                                })
                                              }
                                            else if (_isLoading == "SE")
                                              {
                                                setState(() {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          AlertDialog(
                                                            title: const Text(
                                                                'Error al conectarse con el servidor'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: const Text(
                                                                    'Cerrar'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              )
                                                            ],
                                                          ));
                                                })
                                              }
                                            else if (_isLoading == "OK")
                                              {
                                                SingIn(_usuarioController.text,
                                                    _contrasenaController.text)
                                              }
                                          })
                                      .then((_) =>
                                          {_loader = true, setState(() {})});
                                },
                          child: const Text(
                            'Ingresar',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 0, 127, 254),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ))),
                    ),

                    SizedBox(
                      height: constraints.maxHeight * 0.12,
                    ),

                    RichText(
                      text: const TextSpan(
                        text: '© 2022 Radioactive Labs LLC',
                        style: TextStyle(
                          color: Color.fromARGB(186, 0, 17, 250),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
