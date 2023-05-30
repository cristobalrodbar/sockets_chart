import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sockets_chart/models/input_values.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<InputValues> inputValues = [
    InputValues(id: '1', name: 'Los Acosta', votes: 3),
    InputValues(id: '2', name: 'Mi Banda El Mexicano', votes: 6),
    InputValues(id: '3', name: 'Rufus du Sol', votes: 2),
    InputValues(id: '4', name: 'Arctic Macacos', votes: 8),
  ];

  @override
  Widget build(BuildContext context) {
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
        ),
        body: ListView.builder(
            itemCount: inputValues.length,
            itemBuilder: (context, i) => _inputValueTile(inputValues[i])));
  }

  Widget _inputValueTile(InputValues inputValue) {
    return Dismissible(
      key: Key(inputValue.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        //TO
        print('direction: $direction');
        print('inputValues: ${inputValue.id}');
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
          print(inputValue.name);
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
              title: Text('New Input Value'),
              content: TextField(controller: textcontroller),
              actions: [
                MaterialButton(
                    child: Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () =>
                        addNewInputvalueToList(textcontroller.text))
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
      inputValues.add(
          InputValues(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
