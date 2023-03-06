import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:developer';
import 'package:ndialog/ndialog.dart';
import 'dart:io';

Future<bool> mqttConnect(
    String server, String uniqueId, int port, MqttServerClient client) async {
  print("for DEBUG. I got: $client and $uniqueId and $port");
  client.logging(on: true);
  client.setProtocolV311();
  client.keepAlivePeriod = 20;
  client.connectTimeoutPeriod = 2000;
  client.port = port;
  client.onConnected = onConnected;
  client.onDisconnected = onDisconnected;
  client.onSubscribed = onSubscribed;
  client.pongCallback = pong;
  final connMess = MqttConnectMessage()
      .withClientIdentifier(uniqueId)
      .withWillTopic('willtopic') // If you set this you must set a will message
      .withWillMessage('My Will message')
      .startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atLeastOnce);
  print('EXAMPLE::Mosquitto client connecting....');
  client.connectionMessage = connMess;
  try {
    await client.connect();
  } on NoConnectionException catch (e) {
    // Raised by the client when connection fails.
    print('EXAMPLE::client exception - $e');
    client.disconnect();
  } on SocketException catch (e) {
    // Raised by the socket layer
    print('EXAMPLE::socket exception - $e');
    client.disconnect();
  }
  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    print("connected Succesfully");
  } else {
    return false;
  }
  /* const topic = 'testtopic';
    const topic2 = 'testtopic2';
    final builder1 = MqttClientPayloadBuilder();
    builder1.addString('Hello from the other side');
    print('EXAMPLE:: <<<< PUBLISH 1 >>>>');
    client.publishMessage(topic, MqttQos.atLeastOnce, builder1.payload!);
    client.publishMessage(topic, MqttQos.atLeastOnce, "data") */
  client.subscribe('testtopic', MqttQos.atMostOnce);

  return true;
}

void onSubscribed(String topic) {
  print('EXAMPLE::Subscription confirmed for topic $topic');
}

void onConnected() {
  print("Client connection successful");
}

void onDisconnected() {
  print('i ran once');
  print("Client disconnection successful");
  /* isConnected = false; */
}

void pong() {
  print("from pong function!");
}

void sendData(MqttServerClient client, String topic, String msg) {
  final builder1 = MqttClientPayloadBuilder();
  builder1.addString(msg);

  client.publishMessage(topic, MqttQos.atLeastOnce, builder1.payload!);
}

/* _disconnect() {
  client.disconnect();
}
 */