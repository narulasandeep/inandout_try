// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';
//
//
//
// class SpeechSampleApp extends StatefulWidget {
//   const SpeechSampleApp({Key? key}) : super(key: key);
//
//   @override
//   State<SpeechSampleApp> createState() => _SpeechSampleAppState();
// }
// class _SpeechSampleAppState extends State<SpeechSampleApp> {
//   bool _hasSpeech = false;
//   bool _logEvents = false;
//   bool _onDevice = false;
//   double level = 0.0;
//   double minSoundLevel = 50000;
//   double maxSoundLevel = -50000;
//   String lastWords = '';
//   String lastError = '';
//   String lastStatus = '';
//   String _currentLocaleId = '';
//   final SpeechToText speech = SpeechToText();
//   Future<void> initSpeechState() async {
//     //_logEvent('Initialize');
//     try {
//       var hasSpeech = await speech.initialize(
//        // onError: errorListener,
//         onStatus: statusListener,
//         debugLogging: _logEvents,
//       );
//       if (hasSpeech) {
//         var systemLocale = await speech.systemLocale();
//         _currentLocaleId = systemLocale?.localeId ?? '';
//       }
//       if (!mounted) return;
//
//       setState(() {
//         _hasSpeech = hasSpeech;
//       });
//     } catch (e) {
//       setState(() {
//         lastError = 'Speech recognition failed: ${e.toString()}';
//         _hasSpeech = false;
//       });
//     }
//   }
//   @override
//   void initState() {
//     super.initState();
//     initSpeechState();
//
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Speech to Text Example'),
//         ),
//         body: Column(children: [
//           Container(
//             height: 150,
//             child: RecognitionResultsWidget(lastWords: lastWords, level: level),
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           SpeechControlWidget(_hasSpeech, speech.isListening,
//               startListening, stopListening, cancelListening),
//         ]),
//       ),
//     );
//   }
//
//   void startListening() {
//     lastWords = '';
//     lastError = '';
//
//     speech.listen(
//       onResult: resultListener,
//       partialResults: true,
//       localeId: _currentLocaleId,
//       cancelOnError: true,
//       listenMode: ListenMode.confirmation,
//       onDevice: _onDevice,
//     );
//     setState(() {});
//   }
//
//   void stopListening() {
//     //_logEvent('stop');
//     speech.stop();
//     setState(() {
//       level = 0.0;
//     });
//   }
//
//   void cancelListening() {
//     //_logEvent('cancel');
//     speech.cancel();
//     setState(() {
//       level = 0.0;
//     });
//   }
//
//   /// This callback is invoked each time new recognition results are
//   /// available after `listen` is called.
//   void resultListener(SpeechRecognitionResult result) {
//
//     setState(() {
//       lastWords = '${result.recognizedWords} - ${result.finalResult}';
//     });
//   }
//
//   void statusListener(String status) {
//     setState(() {
//       lastStatus = status;
//     });
//   }
//
//
// }
//
// /// Displays the most recently recognized words and the sound level.
// class RecognitionResultsWidget extends StatelessWidget {
//   const RecognitionResultsWidget({
//     Key? key,
//     required this.lastWords,
//     required this.level,
//   }) : super(key: key);
//
//   final String lastWords;
//   final double level;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//
//         Expanded(
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 color: Theme.of(context).secondaryHeaderColor,
//                 child: Center(
//                   child: Text(
//                     lastWords,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
// class SpeechControlWidget extends StatelessWidget {
//   const SpeechControlWidget(this.hasSpeech, this.isListening,
//       this.startListening, this.stopListening, this.cancelListening,
//       {Key? key})
//       : super(key: key);
//
//   final bool hasSpeech;
//   final bool isListening;
//   final void Function() startListening;
//   final void Function() stopListening;
//   final void Function() cancelListening;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//
//         TextButton(
//           onPressed: !hasSpeech || isListening ? null : startListening,
//           child: const Icon(Icons.mic),
//         ),
//         TextButton(
//           onPressed: isListening ? stopListening : null,
//           child: const Icon(Icons.mic_off),
//         ),
//         TextButton(
//           onPressed: isListening ? cancelListening : null,
//           child: const Icon(Icons.disabled_by_default_outlined),
//         )
//       ],
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';
//
// class SpeechToTextPage extends StatefulWidget {
//   const SpeechToTextPage({Key? key}) : super(key: key);
//
//   @override
//   _SpeechToTextPage createState() => _SpeechToTextPage();
// }
//
// class _SpeechToTextPage extends State<SpeechToTextPage> {
//   final TextEditingController _textController = TextEditingController();
//
//   final SpeechToText _speechToText = SpeechToText();
//   bool _speechEnabled = false;
//   String _lastWords = "";
//
//   void listenForPermissions() async {
//     final status = await Permission.microphone.status;
//     switch (status) {
//       case PermissionStatus.denied:
//         requestForPermission();
//         break;
//       case PermissionStatus.granted:
//         break;
//       case PermissionStatus.limited:
//         break;
//       case PermissionStatus.permanentlyDenied:
//         break;
//       case PermissionStatus.restricted:
//         break;
//       case PermissionStatus.provisional:
//         // TODO: Handle this case.
//     }
//   }
//
//   Future<void> requestForPermission() async {
//     await Permission.microphone.request();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     listenForPermissions();
//     if (!_speechEnabled) {
//       _initSpeech();
//     }
//   }
//
//   /// This has to happen only once per app
//   void _initSpeech() async {
//     _speechEnabled = await _speechToText.initialize();
//   }
//
//   /// Each time to start a speech recognition session
//   void _startListening() async {
//     await _speechToText.listen(
//       onResult: _onSpeechResult,
//       listenFor: const Duration(seconds: 30),
//       localeId: "en_En",
//       cancelOnError: false,
//       partialResults: false,
//       listenMode: ListenMode.confirmation,
//     );
//     setState(() {});
//   }
//
//   /// Manually stop the active speech recognition session
//   /// Note that there are also timeouts that each platform enforces
//   /// and the SpeechToText plugin supports setting timeouts on the
//   /// listen method.
//   void _stopListening() async {
//     await _speechToText.stop();
//     setState(() {});
//   }
//
//   /// This is the callback that the SpeechToText plugin calls when
//   /// the platform returns recognized words.
//   void _onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       _lastWords = "$_lastWords${result.recognizedWords} ";
//       _textController.text = _lastWords;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//           child: ListView(
//             shrinkWrap: true,
//             padding: const EdgeInsets.all(12),
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _textController,
//                       minLines: 6,
//                       maxLines: 10,
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.grey.shade300,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   FloatingActionButton.small(
//                     onPressed:
//                     // If not yet listening for speech start, otherwise stop
//                     _speechToText.isNotListening
//                         ? _startListening
//                         : _stopListening,
//                     tooltip: 'Listen',
//                     backgroundColor: Colors.blueGrey,
//                     child: Icon(_speechToText
//                         .isNotListening
//                         ? Icons.mic_off
//                         : Icons.mic),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';
//
// class SpeechToTextPage extends StatefulWidget {
//   const SpeechToTextPage({Key? key}) : super(key: key);
//
//   @override
//   _SpeechToTextPage createState() => _SpeechToTextPage();
// }

// class _SpeechToTextPage extends State<SpeechToTextPage> {
//   final TextEditingController _textController = TextEditingController();
//   final SpeechToText _speechToText = SpeechToText();
//   bool _speechEnabled = false;
//   String _lastWords = "";
//
//   void listenForPermissions() async {
//     final status = await Permission.microphone.status;
//     switch (status) {
//       case PermissionStatus.denied:
//         requestForPermission();
//         break;
//       case PermissionStatus.granted:
//         break;
//       case PermissionStatus.limited:
//         break;
//       case PermissionStatus.permanentlyDenied:
//         break;
//       case PermissionStatus.restricted:
//         break;
//       case PermissionStatus.provisional:
//         // TODO: Handle this case.
//     }
//   }
//
//   Future<void> requestForPermission() async {
//     await Permission.microphone.request();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     listenForPermissions();
//     if (!_speechEnabled) {
//       _initSpeech();
//     }
//   }
//
//   /// This has to happen only once per app
//   void _initSpeech() async {
//     _speechEnabled = await _speechToText.initialize();
//   }
//
//   /// Each time to start a speech recognition session
//   void _startListening() async {
//     await _speechToText.listen(
//       onResult: _onSpeechResult,
//       listenFor: const Duration(seconds: 30),
//       localeId: "en_En",
//       cancelOnError: false,
//       partialResults: false,
//       listenMode: ListenMode.confirmation,
//     );
//     setState(() {});
//   }
//
//   /// Manually stop the active speech recognition session
//   /// Note that there are also timeouts that each platform enforces
//   /// and the SpeechToText plugin supports setting timeouts on the
//   /// listen method.
//   void _stopListening() async {
//     await _speechToText.stop();
//     setState(() {});
//   }
//
//   /// This is the callback that the SpeechToText plugin calls when
//   /// the platform returns recognized words.
//   void _onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       _lastWords = "$_lastWords${result.recognizedWords} ";
//       _textController.text = _lastWords;
//     });
//   }
//
//   Widget buildMicButton() {
//     return FloatingActionButton.small(
//       onPressed:
//       // If not yet listening for speech start, otherwise stop
//       _speechToText.isNotListening ? _startListening : _stopListening,
//       tooltip: 'Listen',
//       backgroundColor: Colors.blueGrey,
//       child: Icon(
//         _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ListView(
//           shrinkWrap: true,
//           padding: const EdgeInsets.all(12),
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     minLines: 6,
//                     maxLines: 10,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.grey.shade300,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 buildMicButton(),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechRecognitionDialog extends StatefulWidget {
  @override
  _SpeechRecognitionDialogState createState() => _SpeechRecognitionDialogState();
}

class _SpeechRecognitionDialogState extends State<SpeechRecognitionDialog> {
  final TextEditingController _textController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = "";

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 30),
      localeId: "en_En",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = "$_lastWords${result.recognizedWords} ";
      _textController.text = _lastWords;
    });
  }

  @override
  void initState() {
    super.initState();
    if (!_speechEnabled) {
      _initSpeech();
    }
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
       // padding: const EdgeInsets.all(16),
        child: Row(

          children: [
            Container(
              width: MediaQuery.of(context).size.width * .6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30)
            ),
              child: TextField(
                controller: _textController,
                // minLines: 6,
                maxLines: 10,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                ),
              ),
            ),

            FloatingActionButton.small(
              onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
              tooltip: 'Listen',
              backgroundColor: Colors.blueGrey,
              child: Icon(
                _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
