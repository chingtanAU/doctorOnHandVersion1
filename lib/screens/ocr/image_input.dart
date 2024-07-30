import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'ocr_process.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'scan_screen.dart';
import 'package:share_plus/share_plus.dart';

class ImageInputScreen extends StatefulWidget {
  const ImageInputScreen({super.key});

  @override
  ImageInputScreenState createState() => ImageInputScreenState();
}

class ImageInputScreenState extends State<ImageInputScreen> {
  final _picker = ImagePicker();
  XFile? _imageFile;
  List<Map<String, dynamic>> _scannedTexts = [];

  Future<void> _pickImage(ImageSource source) async {
    final selected = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
    if (_imageFile != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OcrProcessingScreen(_imageFile!)));
    }
  }

  Future<List<Map<String, dynamic>>> _loadScans() async {
    final prefs = await SharedPreferences.getInstance();
    final scans = prefs.getStringList('scans') ?? [];
    return scans
        .map((scan) => jsonDecode(scan) as Map<String, dynamic>)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _loadScans().then((scans) {
      setState(() {
        _scannedTexts = scans;
      });
    });
  }

  Future<void> _deleteScan(int index) async {
    // Remove the scan from the list
    _scannedTexts.removeAt(index);

    // Convert the updated list to JSON
    List<String> scansJson =
        _scannedTexts.map((scan) => jsonEncode(scan)).toList();

    // Save the updated list to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('scans', scansJson);

    // Update the UI
    setState(() {});
  }

  Future<void> _editTitle(int index) async {
    final TextEditingController controller = TextEditingController();
    // Show a dialog with a TextField
    await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit title'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Title',
            hintText: 'Enter the new title',
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
          ),
        ],
      ),
    );

    String newTitle = controller.text;

    // If the user entered a new title, update the scan
    if (newTitle.isNotEmpty) {
      _scannedTexts[index]['title'] = newTitle;

      // Convert the updated list to JSON
      List<String> scansJson =
          _scannedTexts.map((scan) => jsonEncode(scan)).toList();

      // Save the updated list to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('scans', scansJson);

      // Update the UI
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('DoctorsonHand'),
      //   backgroundColor: Color.fromRGBO(36, 86, 43, 1),
      // ),
      appBar: AppBar(
        elevation: 9,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.6,
            ],
            colors: [
              Colors.blue,
              Colors.teal,
            ],
          )),
        ),
        title: const Align(
            alignment: Alignment.centerLeft, child: Text("Doctors On Hand")),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadScans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            _scannedTexts = snapshot.data!;
            return Stack(
              children: <Widget>[
                Center(
                  child: _scannedTexts.isEmpty // If no scanned texts
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/converter.png',
                              height: 70,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "No scans yet!",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Take a photo or select from gallery to scan",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ListView.builder(
                            itemCount: _scannedTexts.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ScanScreen(_scannedTexts[index]),
                                  ));
                                },
                                child: Card(
                                  color: const Color.fromRGBO(248, 248, 248, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    // side: const BorderSide(
                                    //   color: Color.fromRGBO(36, 86, 43, 1),
                                    //   width: 0.5,
                                    // ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: <Widget>[
                                        Image.file(
                                          File(_scannedTexts[index]['imagePath']
                                                  as String? ??
                                              ''),
                                          width: 130,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(width: 15.0),
                                        Expanded(
                                          child: SizedBox(
                                            //color: Colors.blueGrey[50],
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5, // adjust the width as needed
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  _scannedTexts[index]['title']
                                                          as String? ??
                                                      '',
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5.0),
                                                Text(
                                                  _scannedTexts[index]['date']
                                                          as String? ??
                                                      '',
                                                  style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.grey),
                                                ),
                                                const SizedBox(height: 10.0),
                                                Container(
                                                  //make sure the icons start from the same point as the title and date
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  transform:
                                                      Matrix4.translationValues(
                                                          -15, 0, 0),

                                                  child: Row(
                                                    children: <Widget>[
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.ios_share),
                                                        iconSize: 20,
                                                        onPressed: () async {
                                                          await Share.share(
                                                              _scannedTexts[
                                                                      index][
                                                                  'translatedText']);
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(Icons.edit),
                                                        iconSize: 20,
                                                        onPressed: () {
                                                          _editTitle(index);
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon:
                                                            const Icon(Icons.delete),
                                                        iconSize: 20,
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                              title: const Text(
                                                                  'Delete scan?'),
                                                              content: const Text(
                                                                  'Are you sure you want to delete this scan?'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: const Text(
                                                                      'Cancel'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  child: const Text(
                                                                      'Delete'),
                                                                  onPressed:
                                                                      () {
                                                                    // Delete the scan
                                                                    _deleteScan(
                                                                        index);

                                                                    // Close the dialog
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.more_vert),
                                                        iconSize: 20,
                                                        onPressed: () {
                                                          // Add code to show more options...
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15.0),
                        //color: const Color.fromRGBO(36, 86, 43, 1),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [0.1, 0.6],
                          colors: [Colors.blue, Colors.teal],
                        ),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.camera_alt),
                              color: Colors.white,
                              onPressed: () => _pickImage(ImageSource.camera),
                            ),
                            const VerticalDivider(
                              color: Colors.grey,
                              thickness: 0.5,
                            ),
                            IconButton(
                              icon: const Icon(Icons.photo_library),
                              color: Colors.white,
                              onPressed: () => _pickImage(ImageSource.gallery),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
