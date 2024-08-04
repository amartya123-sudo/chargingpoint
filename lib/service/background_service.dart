import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class BackendService {
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final GenerativeModel model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: 'AIzaSyDisFMqEcQdjiY72JarhFxCCwY3mGAYOzY',  // Replace with your actual API key
  );

  bool _isListening = false;
  String _text = '';

  BackendService() {
    _initTts();
  }

  void _initTts() {
    flutterTts.setLanguage('en-US');
    flutterTts.setSpeechRate(0.5);
    flutterTts.setVolume(1.0);
    flutterTts.setPitch(1.0);
    print("Text-to-Speech initialized.");
  }

  void listen(Function(String) onResult, Function() onError) async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => onError(),
      );
      if (available) {
        _isListening = true;
        print("Listening...");
        _speech.listen(
          onResult: (val) {
            _text = val.recognizedWords;
            if (val.finalResult) {
              print("Recognized text: $_text");
              onResult(_text);
              _isListening = false;
            }
          },
        );
      } else {
        print("Speech recognition not available.");
      }
    } else {
      _isListening = false;
      _speech.stop();
      print("Stopped listening.");
    }
  }

  Future<void> getResponse(String userInput, Function(String) onResponse, Function(String) onError) async {
    final content = [Content.text(userInput)];
    try {
      final response = await model.generateContent(content);
      if (response.text != null && response.text!.isNotEmpty) {
        String geminiReply = response.text!;
        print("Response from Gemini: $geminiReply");
        onResponse(geminiReply);
      } else {
        onError("Received empty response from Gemini API.");
      }
    } catch (e) {
      onError("Error getting response from Gemini API: $e");
    }
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
    print("Speaking: $text");
  }
}
