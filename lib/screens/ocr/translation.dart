import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
//import 'package:dropdown_search/dropdown_search.dart';
import 'config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TranslationScreen extends StatefulWidget {
  final String textToTranslate;
  final String imagePath;
  final String extractedText;

  const TranslationScreen({
    Key? key,
    required this.textToTranslate,
    required this.imagePath,
    required this.extractedText,
  }) : super(key: key);

  @override
  TranslationScreenState createState() => TranslationScreenState();
}

class TranslationScreenState extends State<TranslationScreen> {
  final _storage = const FlutterSecureStorage();
  String? _translatedText;
  bool _isLoading = false;
  String? _detectedLanguage;

  // Declare a TextEditingController
  late TextEditingController _textEditingController;

  // Define a list of languages and their codes
  Map<String, String> languages = {
    'English': 'en',
    'Mandarin': 'zh',
    'Hindi': 'hi',
    'Spanish': 'es',
    'Arabic': 'ar',
    'French': 'fr',
    'Bengali': 'bn',
    'Russian': 'ru',
    'Portuguese': 'pt',
    'Urdu': 'ur',
  };

  // Add this map
  Map<String, String> languageCodes = {
    'en': 'English',
    'zh-Hans': 'Mandarin', //Chinese (Simplified)
    'zh-Hant': 'Mandarin', //Chinese (Traditional)
    'hi': 'Hindi',
    'es': 'Spanish',
    'ar': 'Standard Arabic',
    'fr': 'French',
    'bn': 'Bengali',
    'ru': 'Russian',
    'pt': 'Portuguese',
    'ur': 'Urdu',
  };

  // Define a variable to hold the currently selected language
  String? currentLanguage;

  @override
  void initState() {
    super.initState();
    // Set the initial language to English
    currentLanguage = languages.keys.first;
    _translateText();
    // Initialize the TextEditingController
    _textEditingController = TextEditingController();
  }

  Future<void> _translateText() async {
    setState(() {
      _isLoading = true;
    });

    // final apiKey = await _storage.read(key: 'apiKey');
    // final apiEndpoint = await _storage.read(key: 'apiEndpoint');
    const apiKey = apiKeys;
    const apiEndpoint = apiEndpoints;

    final languageCode = languages[currentLanguage!];
    if (languageCode == null) {
      throw Exception('Language code not found');
    }

    final requestHeaders = {
      'Ocp-Apim-Subscription-Key': apiKey,
      'Content-Type': 'application/json',
    };

    final requestBody = jsonEncode([
      {'Text': widget.textToTranslate},
    ]);

    final response = await http.post(
      Uri.parse(
          '$apiEndpoint/translator/text/v3.0/translate?api-version=3.0&to=$languageCode'),
      headers: requestHeaders,
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      //print('Result response body: $responseBody');

      setState(() {
        _detectedLanguage =
            languageCodes[responseBody[0]['detectedLanguage']['language']];
        _translatedText = responseBody[0]['translations'][0]['text'];
      });
    } else {
      throw Exception(
          'Failed to translate text. Status code: ${response.statusCode}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveScan() async {
    final prefs = await SharedPreferences.getInstance();
    final scans = prefs.getStringList('scans') ?? [];
    final newScan = {
      'imagePath': widget.imagePath,
      'text': widget.extractedText,
      'translatedText': _translatedText,
      'title': 'Scan ${scans.length + 1}',
      'date': DateTime.now().toString().substring(0, 10),
    };
    scans.add(jsonEncode(newScan));
    await prefs.setStringList('scans', scans);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Text('Translated Text'),
      //   backgroundColor: const Color.fromRGBO(36, 86, 43, 1),
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 60,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              '$_detectedLanguage',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          width: 50,
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: currentLanguage,
                              onChanged: (String? newValue) {
                                setState(() {
                                  currentLanguage = newValue!;
                                  _translateText();
                                });
                              },
                              items: languages.keys
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        value,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      const VerticalDivider(
                                        color: Colors.black,
                                      ),
                                      SvgPicture.asset(
                                        'assets/dropdown_arrow.svg', // replace with your asset path
                                        height: 16,
                                        width: 16,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.textToTranslate,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _translatedText != null
                      ? TextField(
                          controller: _textEditingController
                            ..text = _translatedText!,
                          maxLines: null,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          cursorColor: const Color.fromRGBO(36, 86, 43, 1),
                          decoration: const InputDecoration(
                            labelText: 'Translated Text',
                            border: OutlineInputBorder(),
                          ),
                        )
                      : const Text(
                          'Failed to translate text. Please try again.',
                          style: TextStyle(color: Colors.red),
                        ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors
                              .teal, //const Color.fromRGBO(36, 86, 43, 1),
                        ),
                        onPressed: () async {
                          setState(() {
                            _translatedText = _textEditingController.text;
                          });
                          await _saveScan();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Saved text!')),
                          );
                        },
                        child: const Text('Save Text'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.teal),
                        //const Color.fromRGBO(36, 86, 43, 1)),
                        onPressed: () async {
                          await Share.share(_translatedText!);
                        },
                        child: const Text('Share Text'),
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
//         title: const Text('Translated Text'),
//         backgroundColor: const Color.fromRGBO(36, 86, 43, 1),
//       ),
//       body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // const Text(
//                   //   'Translation Feature',
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
//                   const SizedBox(height: 10),
//                   Text(
//                     widget.textToTranslate,
//                     style: const TextStyle(fontSize: 16.0),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Detected language: $_detectedLanguage',
//                     style: const TextStyle(
//                         fontSize: 16.0, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   DropdownButton<String>(
//                     value: currentLanguage,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         currentLanguage = newValue!;
//                         _translateText();
//                       });
//                     },
//                     items: languages.keys
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 20),
//                   _translatedText != null
//                       ? TextField(
//                           controller: _textEditingController
//                             ..text = _translatedText!,
//                           maxLines:
//                               null, // Allows the TextField to expand vertically as the text grows
//                           style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 16.0,
//                           ),
//                           cursorColor: Colors.blue,
//                           decoration: const InputDecoration(
//                             labelText: 'Translated Text',
//                             border: OutlineInputBorder(),
//                           ),
//                         )
//                       : const Text(
//                           'Failed to translate text. Please try again.',
//                           style: TextStyle(color: Colors.red),
//                         ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: const Color.fromRGBO(36, 86, 43, 1),
//                         ),
//                         onPressed: () async {
//                           setState(() {
//                             _translatedText = _textEditingController.text;
//                           });
//                           await _saveScan();
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Saved text!')),
//                           );
//                         },
//                         child: const Text('Save Text'),
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             foregroundColor: Colors.white,
//                             backgroundColor:
//                                 const Color.fromRGBO(36, 86, 43, 1)),
//                         onPressed: () async {
//                           await Share.share(_translatedText!);
//                         },
//                         child: const Text('Share Text'),
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
//         title: const Text('Translated Text'),
//       ),
//       body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   // Display the original text
//                   Text(
//                     widget.textToTranslate,
//                     style: const TextStyle(fontSize: 16.0),
//                   ),
//                   // Display the detected language
//                   Text(
//                     'Detected language: $_detectedLanguage',
//                     style: const TextStyle(fontSize: 16.0),
//                   ),
//                   // Display the dropdown button to select the language
//                   DropdownButton<String>(
//                     value: currentLanguage,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         currentLanguage = newValue!;
//                         _translateText();
//                       });
//                     },
//                     items: languages.keys
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                   _translatedText != null
//                       ? TextField(
//                           controller: _textEditingController
//                             ..text = _translatedText!,
//                           maxLines:
//                               null, // Allows the TextField to expand vertically as the text grows
//                           //minLines: 5, // Starts off with 5 lines
//                           style: const TextStyle(
//                               color: Colors.black, fontSize: 16.0),
//                           cursorColor: Colors.blue,
//                         )
//                       : const Text(
//                           'Failed to translate text. Please try again.'),
//                   ElevatedButton(
//                     onPressed: () async {
//                       // Save the text
//                       setState(() {
//                         _translatedText = _textEditingController.text;
//                       });
//                     },
//                     child: const Text('Save Text'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       // Share the text
//                       await Share.share(_translatedText!);
//                     },
//                     child: const Text('Share Text'),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
