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
      appBar: AppBar(
        title: const Text('DoctorsonHand'),
        backgroundColor: const Color.fromRGBO(36, 86, 43, 1),
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
                                  color: Color.fromRGBO(248, 248, 248, 1),
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
                                          child: Container(
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
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(
                                                  _scannedTexts[index]['date']
                                                          as String? ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.grey),
                                                ),
                                                SizedBox(height: 10.0),
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
                                                        icon: Icon(
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
                                                        icon: Icon(Icons.edit),
                                                        iconSize: 20,
                                                        onPressed: () {
                                                          _editTitle(index);
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon:
                                                            Icon(Icons.delete),
                                                        iconSize: 20,
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                              title: Text(
                                                                  'Delete scan?'),
                                                              content: Text(
                                                                  'Are you sure you want to delete this scan?'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: Text(
                                                                      'Cancel'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  child: Text(
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
                                                        icon: Icon(
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
                        color: const Color.fromRGBO(36, 86, 43, 1),
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


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select an Image'),
//       ),
//       body: Stack(
//         children: <Widget>[
//           Center(
//               child: _scannedTexts.isEmpty // If no scanned texts
//                   ? Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Image.asset(
//                           'assets/converter.png',
//                           height: 70,
//                         ),
//                         //create space between image and text
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           "No scans yet!",
//                           style: TextStyle(
//                               fontSize: 24, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           "Take a photo or select from gallery to scan",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ],
//                     )
//                   : ListView.builder(
//                       itemCount: _scannedTexts.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           leading: Image.file(
//                             File(_scannedTexts[index]['imagePath']!),
//                             width: 50,
//                           ),
//                           title: Text(_scannedTexts[index]['text']!),
//                         );
//                       },
//                     )),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Container(
//                 width: 150,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 child: IntrinsicHeight(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       IconButton(
//                         icon: Icon(Icons.camera_alt),
//                         onPressed: () => _pickImage(ImageSource.camera),
//                       ),
//                       VerticalDivider(
//                         color: Colors.grey,
//                         thickness: 0.5,
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.photo_library),
//                         onPressed: () => _pickImage(ImageSource.gallery),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ImageInputScreenState extends State<ImageInputScreen> {
//   final _picker = ImagePicker();
//   XFile? _imageFile;

//   Future<void> _pickImage(ImageSource source) async {
//     final selected = await _picker.pickImage(source: source);
//     setState(() {
//       _imageFile = selected;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select an Image'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             if (_imageFile != null)
//               Image.file(
//                 File(_imageFile!.path),
//               ),
//             Row(
//               children: <Widget>[
//                 TextButton(
//                   child: const Text('Camera'),
//                   onPressed: () => _pickImage(ImageSource.camera),
//                 ),
//                 TextButton(
//                   child: const Text('Gallery'),
//                   onPressed: () => _pickImage(ImageSource.gallery),
//                 ),
//               ],
//             ),
//             if (_imageFile != null)
//               ElevatedButton(
//                 child: const Text('Next'),
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => OcrProcessingScreen(_imageFile!)));
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ImageInputScreenState extends State<ImageInputScreen> {
//   final _picker = ImagePicker();
//   XFile? _imageFile;

//   Future<void> _pickImage(ImageSource source) async {
//     final selected = await _picker.pickImage(source: source);
//     setState(() {
//       _imageFile = selected;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: const Text('OCR Feature'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             // const Text(
//             //   'OCR Feature',
//             //   style: TextStyle(
//             //     fontFamily: "Roboto",
//             //     fontWeight: FontWeight.bold,
//             //     fontSize: 30,
//             //   ),
//             // ),
//             // Divider(
//             //   color: Colors.grey[300],
//             //   thickness: 1,
//             // ),
//             // const SizedBox(height: 10),
//             // const Text(
//             //   'At DoctorsonHand, we understand the importance of accurate medical information. Our OCR feature helps by converting the text in your medical documents into a digital format. This can then be easily translated to your preferred language or English for a healthcare professional to understand. You can upload an image or take a photo of your medical report, and our app will do the rest!',
//             //   style: TextStyle(fontSize: 16),
//             //   textAlign: TextAlign.center,
//             // ),
//             const SizedBox(height: 20),
//             const Text(
//               'Select an option to get started:',
//               style: TextStyle(
//                 fontFamily: "Comic Sans",
//                 fontWeight: FontWeight.bold,
//                 fontSize: 25,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Expanded(
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: InkWell(
//                         onTap: () => _pickImage(ImageSource.camera),
//                         child: Container(
//                           height: MediaQuery.of(context).size.height * 0.2,
//                           width: MediaQuery.of(context).size.width * 0.42,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: Colors.red.shade100,
//                             boxShadow: const [
//                               BoxShadow(
//                                 color: Colors.grey,
//                                 blurRadius: 3.0,
//                                 spreadRadius: 3.0,
//                                 offset: Offset(3.0, 3.0),
//                               ),
//                             ],
//                           ),
//                           child: const Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.camera,
//                                 size: 75,
//                                 color: Colors.teal,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Camera',
//                                   style: TextStyle(
//                                     fontFamily: "Comic Sans",
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: InkWell(
//                         onTap: () => _pickImage(ImageSource.gallery),
//                         child: Container(
//                           height: MediaQuery.of(context).size.height * 0.2,
//                           width: MediaQuery.of(context).size.width * 0.42,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: Colors.red.shade100,
//                             boxShadow: const [
//                               BoxShadow(
//                                 color: Colors.grey,
//                                 blurRadius: 3.0,
//                                 spreadRadius: 3.0,
//                                 offset: Offset(3.0, 3.0),
//                               ),
//                             ],
//                           ),
//                           child: const Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.photo_album,
//                                 size: 75,
//                                 color: Colors.red,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Gallery',
//                                   style: TextStyle(
//                                     fontFamily: "Comic Sans",
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             if (_imageFile != null)
//               Padding(
//                 padding: const EdgeInsets.only(top: 20.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // SizedBox(
//                     //   width: MediaQuery.of(context).size.width,
//                     //   height: MediaQuery.of(context).size.height * 0.5,
//                     //   child: Image.file(File(_imageFile!.path)),
//                     // ),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.green,
//                       ),
//                       child: const Text('Next'),
//                       onPressed: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) =>
//                                 OcrProcessingScreen(_imageFile!)));
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
