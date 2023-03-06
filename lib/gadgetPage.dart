import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'addGadgetPage.dart';
import 'dart:convert';
import 'gadgetPage.dart';
import './mqttAsyncConnect.dart';

class GadgetPage extends StatefulWidget {
  final MqttServerClient client;
  final String gadget;

  GadgetPage({required this.client, required this.gadget});

  @override
  _GadgetPageState createState() => _GadgetPageState();
}

class _GadgetPageState extends State<GadgetPage> {
  Map<String, dynamic> gadgetData = {};
  @override
  void initState() {
    super.initState();
    print('widget.gadget: ${widget.gadget}');
    gadgetData = jsonDecode(widget.gadget);
  }

  /*  Map<String, dynamic> jsonData = jsonDecode(widget.gadget); */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gadgetData['name'] + ' (' + gadgetData['type'] + ')'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: gadgetData['commands'].length,
            itemBuilder: (BuildContext context, int index) {
              return ElevatedButton(
                onPressed: () {
                  sendData(
                      widget.client,
                      gadgetData['commands'][index]['topic'],
                      gadgetData['commands'][index]['value']);
                  // do something when the button is pressed
                },
                child: Text(gadgetData['commands'][index]['action']),
              );
            },
          ),
        ),
      ),
    );
  }
}
