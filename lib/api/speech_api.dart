import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechApi {
  static final _speech = stt.SpeechToText();

  static Future<bool> toggleRecording({
    @required Function(String text) onResult,
    @required ValueChanged<bool> onListening,
  }) async {
    if (_speech.isListening == true) {
      _speech.stop();
      return true;
    }
    
    final isAvailable = await _speech.initialize(
      onStatus: (status) => onListening(_speech.isListening),
      onError: (e) => print("Error: $e"),
    );

    if (isAvailable) {
      _speech.listen(
        onResult: (value) => onResult(value.recognizedWords),
        // localeId: "ar_SA",
        localeId: "in_ID",
      );
      // 7:13 last
    }

    return isAvailable;
  }
}
