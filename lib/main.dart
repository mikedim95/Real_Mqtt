import 'dart:developer';
import './mqttAsyncConnect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:async';
import 'dart:io';
import 'package:ndialog/ndialog.dart';
import 'pop_up_window.dart';
import 'serverPage.dart';

void main() {
  runApp(const MyApp());
}

class DataModel {
  String alias = '';
  String server = '';
  String uniqueId = '';
  late int port;

  DataModel(String v1, String v2, String v3, int v4) {
    alias = v1;
    server = v2;
    uniqueId = v3;
    port = v4;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RealMQTT',
      theme: ThemeData(
        canvasColor: Color.fromARGB(255, 95, 188, 193),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 35, 165, 172),
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
        backgroundColor: const Color.fromARGB(255, 35, 165, 172),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MqttServerClient client;
  var isConnected;
  String Variable = "title";
  final List<DataModel> myServerList = [];
  void addItem(DataModel data) {
    print('adding item:');
    print(data.alias);
    print(data.port);
    print(data.server);
    print(data.uniqueId);
    setState(() {
      myServerList.add(data);
    });
  }

  void deleteItem(int index) {
    setState(() {
      myServerList.removeAt(index);
    });
  }

  /*  void deleteItem(int index) {
    setState(() {
      myServerList.removeAt(index);
    });
  } */

  void testfunc1() {
    print('tap1');
  }

  void testfunc2() {
    print('tap2');
  }

  Widget _fixedBackground() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.683, -0.784),
            end: Alignment(1.528, 1.184),
            colors: <Color>[
              Color.fromARGB(173, 101, 198, 230),
              Color(0xb20b6060)
            ],
            stops: <double>[0.139, 0.952],
          ),
          image: DecorationImage(
              image: AssetImage('assets/images/enapter-cloud.png')),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('starting widget');
    return Scaffold(
      appBar: AppBar(title: Text('Real MQTT')),
      body: Stack(
        children: <Widget>[
          _fixedBackground(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: myServerList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(myServerList[index].alias),
                  subtitle: Text(myServerList[index].server),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => deleteItem(index),
                        child: Icon(Icons.delete),
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: () async {
                          client = await onConnect(index);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServerPage(
                                  client: client,
                                  alias: myServerList[index].alias),
                            ),
                          );
                        },
                        child: Icon(Icons.arrow_forward),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DataModel result = DataModel('1', '2', '3', 4);
          _navigateAndDisplaySelection(context, result);
        },
        tooltip: 'add cluster',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _navigateAndDisplaySelection(
      BuildContext context, DataModel resultData) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MultipleTextInputPopup(result: resultData)),
    );
    addItem(result);
  }

  onConnect(int index) async {
    print('connection...');
    MqttServerClient client = MqttServerClient(
        myServerList[index].server, myServerList[index].uniqueId);
    ProgressDialog progressDialog = ProgressDialog(
      context,
      blur: 0,
      dialogTransitionType: DialogTransitionType.Shrink,
      /* title: const Text('title'),
      message: const Text('Message'), */
      dismissable: true,
      /* onDismiss: () => print("Do something onDismiss"), */
    );

    //Set loading with red circular progress indicator
    progressDialog.setLoadingWidget(const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.red),
    ));
    progressDialog
        .setMessage(Text('connecting to: ' + myServerList[index].alias));
    progressDialog.setTitle(Text(myServerList[index].server));
    //Show dialog

    progressDialog.show();
    isConnected = await mqttConnect(myServerList[index].server,
        myServerList[index].uniqueId, myServerList[index].port, client);
    progressDialog.dismiss();
    return client;
  }

  testFunc(int index) async {
    client = await onConnect(index);
    return client;
  }
}
 /* bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 35, 171, 189),
        items: const [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(color: Colors.black, Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'add',
            icon: Icon(Icons.add),
          ),
        ],
      ), */
/* 
class MQTTClient extends StatefulWidget {
  const MQTTClient({Key? key}) : super(key: key);

  @override
  _MQTTClientState createState() => _MQTTClientState();
}

class _MQTTClientState extends State<MQTTClient> {
  //----------------- my vars
  /* final client = MqttServerClient('test.mosquitto.org', '');
  int port = 1883; */
  var client;
  var server;
  var port;
  var uniqueId;
  bool isConnected = false;
  String topic = 'testtopic';
  String topic2 = 'testtopic2';
  TextEditingController idTextController = TextEditingController();
  /* final MqttServerClient client = MqttServerClient('test.mosquitto.org', ''); */

  var pongCount = 0; // Pong counter
  @override
  void dispose() {
    idTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [body(), footer()],
        ),
      ),
    );
  }

  Widget header() {
    return Expanded(
      child: Container(
        child: Text(
          'ESP32CAM Viewer\n- AWS IoT -',
          style: TextStyle(
              fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      flex: 3,
    );
  }

  Widget body() {
    return Expanded(
      flex: 20,
      child: Container(
        color: Colors.black26,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.black,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextFormField(
                          enabled: !isConnected,
                          controller: idTextController,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'MQTT Client Id',
                              labelStyle: TextStyle(fontSize: 10),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.subdirectory_arrow_left),
                                onPressed: () {
                                  onConnect();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => serverPage(
                                            client)), /* class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key, required this.todos}); */
                                  );
                                },
                              ))),
                    ),
                    isConnected
                        ? TextButton(
                            onPressed: onDisconnect, child: Text('Disconnect'))
                        : Container(),
                    ElevatedButton(
                        onPressed: () {
                          final builder1 = MqttClientPayloadBuilder();
                          builder1.addString('Hello from the other side');
                          print('EXAMPLE:: <<<< PUBLISH 1 >>>>');
                          client.publishMessage(
                              topic, MqttQos.atLeastOnce, builder1.payload!);
                          ;
                        },
                        child: const Text('Press'))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(color: Colors.white),
              flex: 7,
            )
          ],
        ),
      ),
    );
  }

  Widget footer() {
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: Text(
          statusText,
          style: TextStyle(
              fontWeight: FontWeight.normal, color: Colors.amberAccent),
        ),
      ),
      flex: 1,
    );
  }

  onConnect(String server, int port, String uniqueId) async {
    client = MqttServerClient(server, uniqueId);
    ProgressDialog progressDialog = ProgressDialog(
      context,
      blur: 0,
      dialogTransitionType: DialogTransitionType.Shrink,
      title: const Text('title'),
      message: const Text('Message'),
      dismissable: false,
      /* onDismiss: () => print("Do something onDismiss"), */
    );

    //Set loading with red circular progress indicator
    progressDialog.setLoadingWidget(CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.red),
    ));
    progressDialog.setMessage(const Text('Connecting'));
    progressDialog.setTitle(const Text('data'));
    //Show dialog

    progressDialog.show();
    isConnected = await mqttConnect(server, uniqueId, port, client);
    progressDialog.dismiss();
  }

  onDisconnect() {
    client.disconnect();
  }
}



 */













/* 
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String variable = 'Test variable';
  String buttonLabel = 'not Clicked';
  myFunc(String test) {
    print("from function call (myFunc) $test");
  }

  List<String> quotes = ['1234', '5678', '9123'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* backgroundColor: Color.fromARGB(255, 151, 39, 39), */
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Real MQTT'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          /* children: quotes.map((quotes) {
            return Text(quotes);
          }).toList(), */
          children: [
            ElevatedButton.icon(
                onPressed: (() {
                  setState(() {
                    buttonLabel = 'clicked!';
                  });
                }),
                icon: const Icon(Icons.cloud),
                label: Text(buttonLabel))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          myFunc(variable);
        },
        child: const Text('+'),
        backgroundColor: Colors.orange,
      ),
      /* body: Scrollbar(
        child: ListView(
          restorationId: 'list_demo_list_view',
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            for (int index = 1; index < 21; index++)
              ListTile(
                leading: ExcludeSemantics(
                  child: CircleAvatar(child: Text('$index')),
                ),
                title: Text('$index'),
              ),
            ElevatedButton(onPressed: () {}, child: const Text('test text'))
          ],
        ),
      ), */
    );
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(
        controller: this.controller,
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.cloud), labelText: 'test'),
      ),
      Text('controller.text')
    ]);
  }
}
 */