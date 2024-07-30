import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
//import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'translation.dart';
import 'dart:math';
import 'config.dart';

class OcrProcessingScreen extends StatefulWidget {
  final XFile imageFile;

  const OcrProcessingScreen(this.imageFile, {super.key});

  @override
  OcrProcessingScreenState createState() => OcrProcessingScreenState();
}

class OcrProcessingScreenState extends State<OcrProcessingScreen> {
  final _storage = const FlutterSecureStorage();
  String? _extractedText;
  //String? _detectedLanguage;
  bool _isLoading = false;

  // Declare a TextEditingController
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _extractText();

    // Initialize the TextEditingController
    _textEditingController = TextEditingController();
  }

  Future<void> _extractText() async {
    setState(() {
      _isLoading = true;
    });

    const apiKey = apiKeys;
    const apiEndpoint = apiEndpoints;

    // Concatenate the endpoint with the rest of the URL
    const requestUrl =
        '$apiEndpoint/formrecognizer/documentModels/prebuilt-document:analyze?api-version=2022-08-31';
    final imageBytes = await widget.imageFile.readAsBytes();

    final requestHeaders = {
      'Content-Type': 'application/octet-stream',
      'Ocp-Apim-Subscription-Key': apiKey,
    };

    try {
      final response = await http.post(
        Uri.parse(requestUrl),
        headers: requestHeaders,
        body: imageBytes,
      );

      if (response.statusCode == 202) {
        final operationLocation = response.headers['operation-location'];
        //print to the screen
        //print('Operation location: $operationLocation');

        if (operationLocation == null) {
          throw Exception(
              'Operation location not found in the response headers');
        }

        while (true) {
          final resultResponse = await http.get(
            Uri.parse(operationLocation),
            headers: {
              'Ocp-Apim-Subscription-Key': apiKey,
            },
          );

          if (resultResponse.statusCode == 200) {
            final resultResponseBody = jsonDecode(resultResponse.body);
            //('Result response body: $resultResponseBody');

            if (resultResponseBody['status'] == 'succeeded') {
              if (resultResponseBody['analyzeResult'] != null &&
                  resultResponseBody['analyzeResult']['content'] != null) {
                final text = resultResponseBody['analyzeResult']['content'];

                setState(() {
                  _extractedText = text;
                });
              } else {
                debugPrint('Expected data not found in the response');
              }

              break;
            } else if (resultResponseBody['status'] == 'failed') {
              throw Exception(
                  'Failed to extract text. Status: ${resultResponseBody['status']}');
            }
          } else {
            throw Exception(
                'Failed to get result. Status code: ${resultResponse.statusCode}');
          }

          await Future.delayed(const Duration(seconds: 1));
        }
      } else {
        throw Exception(
            'Failed to analyze layout. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Failed to extract text: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Future<String> detectLanguage(String text) async {
  //   final apiEndpoint = await _storage.read(key: 'apiEndpoint');
  //   //print('api endpoint: $apiEndpoint');

  //   // Check if the endpoint key exists
  //   if (apiEndpoint == null) {
  //     throw Exception('API endpoint not found');
  //   }

  //   // Concatenate the endpoint with the rest of the URL
  //   final requestUrl =
  //       '$apiEndpoint/language/:analyze-text?api-version=2022-05-01';
  //   //final requestUrl = 'https://doctorsonhand.cognitiveservices.azure.com/language/:analyze-text?api-version=2022-05-01';
  //   final apiKey = await _storage.read(key: 'apiKey');
  //   if (apiKey == null) {
  //     throw Exception('API key not found');
  //   }

  //   final requestHeaders = {
  //     'Content-Type': 'application/json',
  //     'Ocp-Apim-Subscription-Key': apiKey,
  //   };

  //   final requestBody = jsonEncode({
  //     "kind": "LanguageDetection",
  //     "parameters": {"modelVersion": "latest"},
  //     "analysisInput": {
  //       "documents": [
  //         {"id": "1", "text": text}
  //       ]
  //     }
  //   });

  //   final response = await http.post(
  //     Uri.parse(requestUrl),
  //     headers: requestHeaders,
  //     body: requestBody,
  //   );

  //   if (response.statusCode == 200) {
  //     final responseBody = jsonDecode(response.body);
  //     //print('Result response body: $responseBody');
  //     final language =
  //         responseBody['results']['documents'][0]['detectedLanguage']['name'];
  //     setState(() {
  //       _detectedLanguage = language;
  //     });
  //     return language;
  //   } else {
  //     throw Exception(
  //         'Failed to detect language. Status code: ${response.statusCode}');
  //   }
  // }

  @override
  void dispose() {
    // Dispose of the TextEditingController when it's no longer needed.
    _textEditingController.dispose();

    super.dispose();
  }

  List<String> funFacts = [
    "Did you know? Laughing is good for the heart and can increase blood flow by 20 percent.",
    "Interesting Fact: Your heart will beat about 115,000 times each day.",
    "Surprising Health Fact: Humans have the ability to regrow damaged liver tissue.",
    "Did you know? The human body has more than 60,000 miles of blood vessels.",
    "Amazing Fact: Your body has over 200 different types of cells.",
    "Fascinating Health Fact: Regular physical activity can reduce the risk of various health conditions, including heart disease and stroke.",
    "Did you know? The human body contains enough fat to make seven bars of soap.",
    "Interesting Fact: The human body contains enough iron to make a 3-inch nail.",
    "Did you know? About 70% of the immune system is located in the digestive tract.",
    "Interesting Fact: The human brain is the most energy-consuming organ, using up to 20% of the body's total haul.",
    "Did you know? The human body contains 30,000 billion red blood cells.",
    "Did you know? Eating a high-fiber diet can help lower risk for heart disease by 40%."
  ];

  // Future<void> _saveScan() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final scans = prefs.getStringList('scans') ?? [];
  //   scans.add(jsonEncode(
  //       {'imagePath': widget.imageFile.path, 'text': _extractedText}));
  //   await prefs.setStringList('scans', scans);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: const Text('Extracted Text'),
      //     backgroundColor: const Color.fromRGBO(36, 86, 43, 1)),
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
      body: _isLoading
          ? LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      const Text(
                        'Processing your image...',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth * 0.8),
                        child: Text(
                          funFacts[Random().nextInt(funFacts.length)],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Image.file(
                    File(widget.imageFile.path),
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.grey),
                    //   borderRadius: BorderRadius.circular(5),
                    // ),
                    child: _extractedText != null
                        ? TextField(
                            controller: _textEditingController
                              ..text = _extractedText!,
                            maxLines: null,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16.0),
                            cursorColor: Colors.blue,
                            decoration: const InputDecoration(
                              labelText: 'Extracted Text',
                              border: OutlineInputBorder(),
                            ),
                          )
                        : const Text(
                            'Failed to extract text. Please try again.'),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     setState(() {
                      //       _extractedText = _textEditingController.text;
                      //     });
                      //     await _saveScan();
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(content: Text('Saved text!')),
                      //     );
                      //   },
                      //   child: const Text('Save Text'),
                      // ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.teal,
                        ),
                        onPressed: () async {
                          setState(() {
                            _extractedText = _textEditingController.text;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TranslationScreen(
                                textToTranslate: _extractedText!,
                                imagePath: widget.imageFile.path,
                                extractedText: _extractedText!,
                              ),
                            ),
                          );
                        },
                        child: const Text('Translate'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Extracted Text'),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   // Text(
//                   //   'Extracted Text',
//                   //   style: TextStyle(
//                   //     fontFamily: "Roboto",
//                   //     fontWeight: FontWeight.bold,
//                   //     fontSize: 30,
//                   //   ),
//                   // ),
//                   // Divider(
//                   //   color: Colors.grey[300],
//                   //   thickness: 1,
//                   // ),
//                   // const SizedBox(height: 10),
//                   // Text(
//                   //   'The text extracted from your image:',
//                   //   style: TextStyle(fontSize: 16),
//                   // ),
//                   const SizedBox(height: 20),
//                   Image.file(
//                     File(widget.imageFile.path),
//                     fit: BoxFit.contain,
//                   ),
//                   const SizedBox(height: 20),
//                   Container(
//                     padding: const EdgeInsets.all(10.0),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: _extractedText != null
//                         ? TextField(
//                             controller: _textEditingController
//                               ..text = _extractedText!,
//                             maxLines: null,
//                             style: const TextStyle(
//                                 color: Colors.black, fontSize: 16.0),
//                             cursorColor: Colors.blue,
//                           )
//                         : const Text(
//                             'Failed to extract text. Please try again.'),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () async {
//                           setState(() {
//                             _extractedText = _textEditingController.text;
//                           });
//                         },
//                         child: const Text('Save Text'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => TranslationScreen(
//                                   textToTranslate: _extractedText!),
//                             ),
//                           );
//                         },
//                         child: const Text('Translate'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Extracted Text'),
//       ),
//       body: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(
//                 color: Theme.of(context).primaryColor,
//                 strokeWidth: 2,
//               ),
//             )
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: <Widget>[
//                   Image.file(
//                     File(widget.imageFile.path),
//                     fit: BoxFit.contain,
//                   ),
//                   _extractedText != null
//                       ? Card(
//                           elevation: 5,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: TextField(
//                               controller: _textEditingController
//                                 ..text = _extractedText!,
//                               maxLines: null,
//                               style: const TextStyle(
//                                   color: Colors.black, fontSize: 16.0),
//                               cursorColor: Colors.blue,
//                             ),
//                           ),
//                         )
//                       : const Text('Failed to extract text. Please try again.'),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment.spaceEvenly, // Align buttons
//                     children: [
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white, backgroundColor: Colors.blue,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           textStyle: const TextStyle(fontSize: 20),
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _extractedText = _textEditingController.text;
//                           });
//                         },
//                         child: const Text('Save Text'),
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white, backgroundColor: Colors.green,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           textStyle: const TextStyle(fontSize: 20),
//                         ),
//                         child: const Text('Translate'),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => TranslationScreen(
//                                   textToTranslate: _extractedText!),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Extracted Text'),
//       ),
//       body: _isLoading
//           ? const Center(
//               child:
//                   CircularProgressIndicator()) // Center the CircularProgressIndicator for better appearance
//           : SingleChildScrollView(
//               // Makes the text scrollable
//               padding: const EdgeInsets.all(
//                   16.0), // Adds some padding around the text
//               child: Column(
//                 children: <Widget>[
//                   // Display the image
//                   Image.file(
//                     File(widget.imageFile.path),
//                     fit: BoxFit
//                         .contain, // Ensures the image will be shown in the app
//                   ),
//                   // Display the extracted text
//                   _extractedText != null
//                       ? TextField(
//                           controller: _textEditingController
//                             ..text = _extractedText!,
//                           maxLines:
//                               null, // Allows the TextField to expand vertically as the text grows
//                           //minLines: 5, // Starts off with 5 lines
//                           style: const TextStyle(
//                               color: Colors.black, fontSize: 16.0),
//                           cursorColor: Colors.blue,
//                         )
//                       : const Text('Failed to extract text. Please try again.'),
//                   // if (_detectedLanguage != null)
//                   //   Text('Detected language: $_detectedLanguage',
//                   //       style: const TextStyle(
//                   //           color: Colors.blue, fontSize: 18.0)),
//                   ElevatedButton(
//                     onPressed: () async {
//                       // Save the text
//                       setState(() {
//                         _extractedText = _textEditingController.text;
//                       });

//                       // Detect the language of the text
//                       // try {
//                       //   _detectedLanguage =
//                       //       await detectLanguage(_extractedText!);
//                       //   setState(
//                       //       () {}); // Trigger a rebuild to update the displayed language
//                       // } catch (e) {
//                       //   debugPrint('Failed to detect language: $e');
//                       //   return;
//                       // }

//                       // debugPrint('Detected language: $_detectedLanguage');
//                     },
//                     child: const Text('Save Text'),
//                   ),
//                   ElevatedButton(
//                     child: const Text('Translate'),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => TranslationScreen(
//                               textToTranslate: _extractedText!),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
