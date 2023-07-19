import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanScreen extends StatefulWidget {
  final Map<String, dynamic> scan;

  const ScanScreen(this.scan, {Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late TextEditingController _textController;
  late TextEditingController _translatedTextController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.scan['text']);
    _translatedTextController =
        TextEditingController(text: widget.scan['translatedText']);
  }

  Future<void> _saveText() async {
    final prefs = await SharedPreferences.getInstance();
    final scans = prefs.getStringList('scans') ?? [];
    final updatedScan = {
      ...widget.scan,
      'text': _textController.text,
      'translatedText': _translatedTextController.text,
    };
    final index = scans.indexWhere(
        (scan) => jsonDecode(scan)['imagePath'] == widget.scan['imagePath']);
    scans[index] = jsonEncode(updatedScan);
    await prefs.setStringList('scans', scans);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved text!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.scan['title']),
          backgroundColor: const Color.fromRGBO(36, 86, 43, 1)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Image.file(File(widget.scan['imagePath'])),
            const SizedBox(height: 20.0),
            TextField(
              maxLines: null,
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Text',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              maxLines: null,
              controller: _translatedTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Translated Text',
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Container(
                width: 100, // Set the width as per your requirement
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(36, 86, 43, 1),
                  ),
                  onPressed: _saveText,
                  child: const Text('Save Text'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
