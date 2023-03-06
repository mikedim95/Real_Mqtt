import 'package:flutter/material.dart';
import 'main.dart';

class MultipleTextInputPopup extends StatefulWidget {
  final DataModel result;
  const MultipleTextInputPopup({Key? key, required this.result})
      : super(
          key: key,
        );
  @override
  _MultipleTextInputPopupState createState() => _MultipleTextInputPopupState();
}

class _MultipleTextInputPopupState extends State<MultipleTextInputPopup> {
  /* String _inputText1 = '';
  String _inputText2 = '';
  String _inputText3 = ''; */
  final _textController_1 = TextEditingController();
  final _textController_2 = TextEditingController();
  final _textController_3 = TextEditingController();
  final _textController_4 = TextEditingController();
  String inputValue_1 = '';
  String inputValue_2 = '';
  String inputValue_3 = '';
  late int inputValue_4;

  @override
  void dispose() {
    _textController_1.dispose();
    _textController_2.dispose();
    _textController_3.dispose();
    _textController_4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                inputValue_1 = value;
              },
              controller: _textController_1,
              decoration: const InputDecoration(
                hintText: 'Alias',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.drive_file_rename_outline),
              ),
            ),
            TextField(
              onChanged: (value) {
                inputValue_2 = value;
              },
              controller: _textController_2,
              decoration: const InputDecoration(
                hintText: 'Server Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.cloud),
              ),
            ),
            TextField(
              onChanged: (value) {
                inputValue_3 = value;
              },
              controller: _textController_3,
              decoration: const InputDecoration(
                hintText: 'UniqueId',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.perm_identity_outlined),
              ),
            ),
            TextField(
              onChanged: (value) {
                inputValue_4 = int.tryParse(value) ?? 0;
              },
              controller: _textController_4,
              decoration: const InputDecoration(
                hintText: 'Port',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.door_front_door_outlined),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DataModel data =
              DataModel(inputValue_1, inputValue_2, inputValue_3, inputValue_4);
          Navigator.pop(context, data);
        },
        tooltip: 'add cluster',
        child: const Icon(Icons.add),
      ),
    );
  }
}
