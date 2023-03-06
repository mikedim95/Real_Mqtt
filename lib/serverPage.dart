import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'addGadgetPage.dart';
import 'dart:convert';
import 'gadgetPage.dart';

class ServerPage extends StatefulWidget {
  final MqttServerClient client;
  final String alias;

  ServerPage({required this.client, required this.alias});

  @override
  _ServerPageState createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  List<Map<String, dynamic>> gadgets = [];
  void deleteItem(int index) {
    setState(() {
      gadgets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.alias),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: gadgets.length /* gadgets.length */,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(gadgets[index]["name"].toString()),
                subtitle: Text(gadgets[index]["type"].toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => deleteItem(index),
                      child: Icon(Icons.delete),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GadgetPage(
                                client: widget.client,
                                gadget: jsonEncode(gadgets[index])),
                          ),
                        );
                      },
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
                onTap: () {
                  // Do something when the list item is tapped
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateAndDisplaySelection(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void addItem(String data) {
    print('adding item:');
    print(data);

    Map<String, dynamic> jsonData = jsonDecode(data);
    print(jsonDecode(data).runtimeType);
    print(gadgets.runtimeType);
    setState(() {
      gadgets.add(jsonDecode(data));
    });
    String x = jsonEncode(gadgets);

    print('now the gadgets look like this: $x');
    /* print('length $gadgets.length'); */
  }

  Future<void> _navigateAndDisplaySelection(
    BuildContext context,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TextFieldForm()),
    );
    addItem(result);
  }
}
