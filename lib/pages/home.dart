import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sockets_chart/models/input_value.dart';
import 'package:sockets_chart/services/socket_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<InputValue> inputValues = [
    /*  InputValue(id: '1', name: 'Los Acosta', votes: 3),
    InputValue(id: '2', name: 'Mi Banda El Mexicano', votes: 6),
    InputValue(id: '3', name: 'Rufus du Sol', votes: 2),
    InputValue(id: '4', name: 'Arctic Macacos', votes: 8), */
  ];

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-values', (payload) {
      //print(payload);
      inputValues = (payload as List)
          .map((inputValue) => InputValue.fromMap(inputValue))
          .toList();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('active-values');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: addNewInputvalue,
          elevation: 1,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            'Inputvalues',
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 10),
                child: (socketService.serverStatus == ServerStatus.Online)
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.blue[300],
                      )
                    : const Icon(
                        Icons.offline_bolt,
                        color: Colors.red,
                      ))
          ],
        ),
        body: ListView.builder(
            itemCount: inputValues.length,
            itemBuilder: (context, i) => _inputValueTile(inputValues[i])));
  }

  Widget _inputValueTile(InputValue inputValue) {
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(inputValue.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        socketService.socket.emit('delete-input', {'id': inputValue.id});
        //print('direction: $direction');
        //print('inputValues: ${inputValue.id}');
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            )),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(inputValue.name.substring(0, 2)),
        ),
        title: Text(inputValue.name),
        trailing: Text(
          '${inputValue.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          socketService.socket.emit('vote-input', {'id': inputValue.id});
          print(inputValue.id);
          //print(inputValue.name);
        },
      ),
    );
  }

  addNewInputvalue() {
    final textcontroller = TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('New Input Value'),
              content: TextField(controller: textcontroller),
              actions: [
                MaterialButton(
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () =>
                        addNewInputvalueToList(textcontroller.text),
                    child: const Text('Add'))
              ],
            );
          });
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('New Input Value'),
            content: CupertinoTextField(
              controller: textcontroller,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => addNewInputvalueToList(textcontroller.text),
                child: const Text('Add'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context),
                child: const Text('Dismiss'),
              )
            ],
          );
        });
  }

  void addNewInputvalueToList(String name) {
    print(name);
    if (name.length > 1) {
      //inputValues.add(InputValue(id: DateTime.now().toString(), name: name, votes: 0));
      //setState(() {});
      final socketService = Provider.of<SocketService>(context, listen: false);

      socketService.socket.emit('add-input', {'name': name});
    }
    Navigator.pop(context);
  }
}
