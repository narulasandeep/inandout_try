import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:inandout_try/friend_sms.dart';
import 'package:inandout_try/messagetab.dart';
import 'package:inandout_try/money_sms.dart';
import 'package:inandout_try/speech_to_text.dart';
import 'package:inandout_try/watsapp_sms.dart';
import 'package:inandout_try/tts.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

       // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TabbarExample(),
    // MessagesTab()
    );
  }
}

class TabbarExample extends StatefulWidget {
  const TabbarExample({Key? key}) : super(key: key);

  @override
  State<TabbarExample> createState() => _TabbarExampleState();
}

class _TabbarExampleState extends State<TabbarExample> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];
  int i = 0;
  String filterAddress = ""; // Variable to store the user input
  List<SmsMessage> messages = [];
  List<String> stringMessages = [];
  bool light0 = true;
  bool light1 = true;
  int _tabTextIndexSelected = 0 ;
List<String> addresses = ["AH-650025", "AH-AIRTEL", "VM-BSELTD", "RockyBhiaa", "+91-8178996556"];
  List<String> listToggleTabs = ["Money\n Sms" , "Friend\n Sms" , "Watsapp\nSMS "];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("In And Out Payments",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,

        ),
        body:
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FlutterToggleTab
                  (
                  width: 95,
                  borderRadius: 15,
                  height: 50,
                  selectedIndex: _tabTextIndexSelected,
                  selectedBackgroundColors: [Colors.blue, Colors.blueAccent],
                  selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                  unSelectedTextStyle:const  TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                  labels: listToggleTabs,
                  selectedLabelIndex: (index) {
                    debugPrint('159 --> $index');
                    setState(() {
                      _tabTextIndexSelected = index;
                    });
                  },
                  isScroll:false,
                ),
                if(_tabTextIndexSelected == 0 )
                   MoneySms(messages: messages,)
                else if (_tabTextIndexSelected ==1)
                  FriendSms(messages: messages)
                else if (_tabTextIndexSelected==2)
                    WatsappSms()
              ],
            ),
          ),
        ),
        floatingActionButton:
        FloatingActionButton(
          onPressed: ()
          async {
            var permission = await Permission.sms.status;
            if (permission.isGranted) {
             //  for (var address in addresses) {
              final addressMessages = await _query.querySms(
                kinds: [SmsQueryKind.inbox],
                address: "+918178996556",
                count: messages.length,
              );
              stringMessages = messages.map((message) => message.body.toString()).toList();
              debugPrint("270-->> $stringMessages");
              messages.addAll(addressMessages);
               //}
              for (int i = 0; i < messages.length; i++) {
                await speakMessage(messages[i].body.toString());
              }
              setState(() {
                _messages = messages;
              });
            } else {
              await Permission.sms.request();
            }
          },

          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
  Future<void> speakMessage(String message) async {
    await TextToSpeech.speak(message);

  }


}

