import 'dart:io';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionStatusCheck {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatusCheck _singleton =
      new ConnectionStatusCheck._internal();
  ConnectionStatusCheck._internal();

  //This is what's used to retrieve the instance through the app
  static ConnectionStatusCheck getInstance() => _singleton;

  //This tracks the current connection status
  bool hasConnection = false;

  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController =
      new StreamController.broadcast();

  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  void dispose() {
    connectionChangeController.close();
  }

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  //The test to actually see if there is a connection
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("......................................OK");
        hasConnection = true;
      } else {
        print("......................................NO CONNECTION");
        hasConnection = false;
      }
    } on SocketException catch (_) {
      print("......................................NO CONNECTION");
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}