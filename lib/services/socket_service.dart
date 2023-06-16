import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    // Dart client
    _socket = IO.io('http://192.168.0.5:3000/', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    /*en chrome
    socket.emit('emitir-mensaje', 'Cristobal');
    socket.emit('emitir-mensaje', {nombre: 'Cristóbal', mensaje: 'hola mundo!'});
    */

    /* _socket.on('nuevo-mensaje', (payload) {
      print('nuevo-mensaje: $payload');
      print('nombre: ' + payload['nombre']);
      print('mensaje: ' + payload['mensaje']);
      print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'no hay');
    }); */

    //_socket.off('nuevo-mensaje');
  }
}

/* import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
//import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  get serverStatus => _serverStatus;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    // Dart client
    IO.Socket socket = IO.io(
        'http://192.168.0.172:3000',
/*         OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .build() */

        {
          'transports': ['websocket'],
          'autoConnect': true
        });

/*     socket.onConnect((_) => print('connect'));
    socket.onDisconnect((_) => print('disconnect'));
 */
    socket.on('connect', (_) {
      print('connect');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
      //socket.emit('msg', 'test');
    });

    socket.on('disconnect', (_) {
      print('disconnect');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
      //socket.emit('msg', 'test');
    });

    //socket.on('event', (data) => print(data));
    //socket.onDisconnect((_) => print('disconnect'));
    //socket.on('fromServer', (_) => print(_));
  }
}
 */