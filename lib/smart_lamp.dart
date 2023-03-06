import 'package:flutter/material.dart';

class SmartLampPage extends StatefulWidget {
  const SmartLampPage({Key? key}) : super(key: key);

  @override
  _SmartLampState createState() => _SmartLampState();
}

class _SmartLampState extends State<SmartLampPage> {
  bool isSwitched = false;

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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Smart Lamp'),
        ),
        body: Column(
          children: <Widget>[
            //_fixedBackground(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                title: const Text('ON/OFF Lamp'),
                trailing: Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      print(isSwitched);
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ),
            )
          ],
        ));
  }
}
