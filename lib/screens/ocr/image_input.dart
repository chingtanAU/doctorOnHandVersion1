import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'ocr_process.dart';

class ImageInputScreen extends StatefulWidget {
  const ImageInputScreen({super.key});

  @override
  ImageInputScreenState createState() => ImageInputScreenState();
}

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

class ImageInputScreenState extends State<ImageInputScreen> {
  final _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final selected = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('OCR Feature'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // const Text(
            //   'OCR Feature',
            //   style: TextStyle(
            //     fontFamily: "Roboto",
            //     fontWeight: FontWeight.bold,
            //     fontSize: 30,
            //   ),
            // ),
            // Divider(
            //   color: Colors.grey[300],
            //   thickness: 1,
            // ),
            const SizedBox(height: 10),
            const Text(
              'At DoctorsonHand, we understand the importance of accurate medical information. Our OCR feature helps by converting the text in your medical documents into a digital format. This can then be easily translated to your preferred language or English for a healthcare professional to understand. You can upload an image or take a photo of your medical report, and our app will do the rest!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Select an option to get started:',
              style: TextStyle(
                fontFamily: "Comic Sans",
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => _pickImage(ImageSource.camera),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red.shade100,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3.0,
                                spreadRadius: 3.0,
                                offset: Offset(3.0, 3.0),
                              ),
                            ],
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera,
                                size: 75,
                                color: Colors.teal,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Camera',
                                  style: TextStyle(
                                    fontFamily: "Comic Sans",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => _pickImage(ImageSource.gallery),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red.shade100,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3.0,
                                spreadRadius: 3.0,
                                offset: Offset(3.0, 3.0),
                              ),
                            ],
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_album,
                                size: 75,
                                color: Colors.red,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Gallery',
                                  style: TextStyle(
                                    fontFamily: "Comic Sans",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_imageFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Image.file(File(_imageFile!.path)),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Next'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                OcrProcessingScreen(_imageFile!)));
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
