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



  // Detect the language of the text
                      // try {
                      //   _detectedLanguage =
                      //       await detectLanguage(_extractedText!);
                      //   setState(
                      //       () {}); // Trigger a rebuild to update the displayed language
                      // } catch (e) {
                      //   debugPrint('Failed to detect language: $e');
                      //   return;
                      // }

                      // debugPrint('Detected language: $_detectedLanguage');