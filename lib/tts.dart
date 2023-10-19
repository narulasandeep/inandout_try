import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  static FlutterTts tts = FlutterTts();

  static initTTS()async {
    print("7-->> ${ await   tts.getLanguages}");
    tts.setLanguage("hi-IN");

  }
  static speak( String text){
    tts.speak(text);
  }

}