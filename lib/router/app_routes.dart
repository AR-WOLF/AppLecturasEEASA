import 'package:applect_json/models/menu_option.dart';
import 'package:applect_json/screens/download_screen.dart';
import 'package:applect_json/screens/lect_med_screen.dart';

import 'package:applect_json/screens/menu_screen.dart';
import 'package:applect_json/screens/table_med__screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const mainRoute = 'menu';

  static final ListOptions = <MainMenu>[
    MainMenu(
      route: 'Lecturas',
      icon: Icons.list_alt,
      name: 'Registro Mediciones',
      screen: Lecturas(),
      icon2: Icons.keyboard_arrow_right_rounded,
    ),
    MainMenu(
      route: 'TablaMedidores',
      icon: Icons.view_list_outlined,
      name: 'Lista Medidores',
      screen: TablaMedidores(),
      icon2: Icons.keyboard_arrow_right_rounded,
    ),
    MainMenu(
      route: 'downloadScreen',
      icon: Icons.download,
      name: 'Descargar Datos',
      screen: downloadScreen(),
      icon2: Icons.keyboard_arrow_right_rounded,
    ),
    MainMenu(
      route: 'ExitScreen',
      icon: Icons.exit_to_app,
      name: 'Salir',
      icon2: Icons.keyboard_arrow_right_rounded,
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    /////Routes
    Map<String, Widget Function(BuildContext)> Routes = {};
    Routes.addAll({'menu': (BuildContext context) => MenuScreen()});

    for (final option in ListOptions) {
      Routes.addAll({option.route: (BuildContext context) => option.screen!});
    }

    return Routes;
  }
}
