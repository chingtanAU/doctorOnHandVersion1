import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'image_input.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiKeyInputScreen extends StatefulWidget {
  const ApiKeyInputScreen({Key? key}) : super(key: key); // add a key parameter

  @override
  ApiKeyInputScreenState createState() => ApiKeyInputScreenState();
}

class ApiKeyInputScreenState extends State<ApiKeyInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _storage = const FlutterSecureStorage();

  String _apiKey = '';
  String _apiEndpoint = '';

  @override
  void initState() {
    super.initState();
    _checkForSavedApiKeyAndEndpoint(context);
  }

  void _checkForSavedApiKeyAndEndpoint(BuildContext context) async {
    String? apiKey = await _storage.read(key: 'apiKey');
    String? apiEndpoint = await _storage.read(key: 'apiEndpoint');
    if (context.mounted) {
      if (apiKey != null && apiEndpoint != null) {
        _navigateToImageInputScreen(context);
      }
    }
  }

  void _navigateToImageInputScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ImageInputScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to DoctorsonHand OCR'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text(
                "Our new OCR feature utilizes Microsoft's cognitive services, an advanced AI technology, to provide you with the best medical consultation experience.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                "Why Microsoft Cognitive Services?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Microsoft's cognitive services offer a collection of powerful AI services that provide capabilities such as speech-to-text transcription, language understanding, and even vision-based services like Optical Character Recognition (OCR). All these capabilities are accessible from one single API, making it incredibly convenient and efficient.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "To get started with OCR, we need some information.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'API Key',
                  labelStyle: TextStyle(color: Colors.black),
                  helperText: 'Enter your 32-character API Key',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your API key';
                  }
                  return null;
                },
                onSaved: (value) => _apiKey = value ?? '',
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'API Endpoint',
                  labelStyle: TextStyle(color: Colors.black),
                  helperText: 'Enter your API endpoint',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your API endpoint';
                  }
                  return null;
                },
                onSaved: (value) => _apiEndpoint = value ?? '',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: _saveApiKeyAndEndpoint,
                child: const Text('Save for Future Use'),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                        text:
                            "Note: If you don't have a Microsoft cognitive services account, you can ",
                        style: TextStyle(fontSize: 16)),
                    TextSpan(
                      text: 'Sign up here',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final Uri url = Uri.parse(
                              'https://learn.microsoft.com/en-us/azure/cognitive-services/cognitive-services-apis-create-account?tabs=multiservice%2Canomaly-detector%2Clanguage-service%2Ccomputer-vision%2Cwindows');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw Exception('Could not launch $url');
                          }
                        },
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveApiKeyAndEndpoint() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      // Check if the API key length is correct.
      if (_apiKey.length != 32) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid API Key. Please check and try again.'),
        ));
        return;
      }

      await _storage.write(key: 'apiKey', value: _apiKey);
      await _storage.write(
          key: 'apiEndpoint', value: _apiEndpoint); // Save the API endpoint

      // Navigate to the next screen after saving the API key.
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ImageInputScreen()));
      }
    }
  }
}
