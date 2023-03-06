import 'package:flutter/material.dart';
import 'dart:convert';

class TextFieldForm extends StatefulWidget {
  const TextFieldForm({Key? key}) : super(key: key);

  @override
  _TextFieldFormState createState() => _TextFieldFormState();
}

class _TextFieldFormState extends State<TextFieldForm> {
  var count = 0;
  final formKey = GlobalKey<FormState>();
  String? _selectedItem;
  bool _showForm = false;
  List<Map<String, dynamic>> commands = [];

  List<TextEditingController> _controllersList = [];
  TextEditingController _nameController = TextEditingController();
  final List<String> _dropdownItems = ['Lamp', 'Doorbell', 'IoT Device'];

  void dispose() {
    _controllersList.forEach((controller) => controller.dispose());
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select device and add commands'),
      ),
      body: Center(
        child: _buildDropdown(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            for (int i = 0; i < _controllersList.length; i += 3) {
              commands.add({
                "action": _controllersList[i].text,
                "topic": _controllersList[i + 1].text,
                "value": _controllersList[i + 2].text
              });
            }
            Map<String, dynamic> jsonData = {
              "name": _nameController.text,
              "type": _selectedItem,
              "commands": commands,
            };
            String x = jsonEncode(jsonData);
            /*  _controllersList
                  .forEach((controller) => commands.add(controller.text)); */
            print('sending commands: $x');
            Navigator.pop(context, jsonEncode(jsonData));
          } else {
            print('state 2');
          }
          /*  */
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDropdown() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DropdownButton<String>(
          value: _selectedItem,
          items: _dropdownItems
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Row(
                      children: [
                        Text(item),
                      ],
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedItem = value;
            });
          },
        ),
        Form(
          key: formKey,
          child: Column(
            children: [
              Column(
                children: List.generate(_controllersList.length ~/ 3, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                            controller: _controllersList[index * 3],
                            decoration: InputDecoration(
                                hintText: 'Action ${index + 1}'),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 120,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                            controller: _controllersList[index * 3 + 1],
                            decoration:
                                InputDecoration(hintText: 'Topic ${index + 1}'),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 120,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                            controller: _controllersList[index * 3 + 2],
                            /*  onChanged: (value) => , */
                            decoration:
                                InputDecoration(hintText: 'value ${index + 1}'),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                    controller: _nameController,
                    decoration: InputDecoration(hintText: 'Enter Gadget Name'),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controllersList.removeRange(
                      _controllersList.length - 3, _controllersList.length);
                });
              },
              child: Icon(Icons.delete),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controllersList.add(TextEditingController());
                  _controllersList.add(TextEditingController());
                  _controllersList.add(TextEditingController());
                });
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
