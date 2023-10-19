import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:inandout_try/tts.dart';
import 'package:permission_handler/permission_handler.dart';

class FriendSms extends StatefulWidget {
  const FriendSms({super.key, required this.messages});
  final List<SmsMessage> messages;

  @override
  State<FriendSms> createState() => _FriendSmsState();
}

class _FriendSmsState extends State<FriendSms> {
  bool isSwitched = false;
  List<String> stringMessages = [];
  List<SmsMessage> messages = [];
  List<SmsMessage> _messages = [];
  String phoneNumber = "";
  List<String> addresses = [ "+918178996556"];
  final SmsQuery _query = SmsQuery();
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else if (isSwitched == true) {
      setState(() {
        isSwitched = false;
      });
    }
  }

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 50,
          ),
          Row(
            children: [
              Container(
                width: 250,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '+91 ',
                    hintText: 'Enter your Friends number',
                  ),
                  onSubmitted: (value) {
                    debugPrint("-->>53${value}");
                    if (value.length > 10) {
                      debugPrint("-->>53${value}");
                      controller.text = value.substring(0, 10);
                      _showErrorBar(context);
                    } else if (value.length < 10) {
                      _showErrorBar(context);
                    } else {
                      setState(() {
                        phoneNumber = value;
                       phoneNumber = "91"+value;
                        debugPrint("72-->> ${phoneNumber}");
                      });
                    }
                  },
                ),
              ),
              const Spacer(),
              Switch(
                onChanged: toggleSwitch,
                value: isSwitched,
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 50,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.29,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: ListView.builder(
              itemCount: widget.messages.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int i) {
                var message = widget.messages[i];
                String text = message.body.toString();
                List<String> words = text.split(' ');

                if (words.length > 4) {
                  words = words.sublist(0, 4);
                }

                String displayText = words.join(' ');
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 60),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {
                        showCustomAlertDialog(
                            context, message.body, message.sender);
                      },
                      child: Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 16,
                            width: MediaQuery.of(context).size.width / 9,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.orange,
                              child:
                                  Text(message.sender?[0].toUpperCase() ?? ""),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.sender.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.height / 50,
                                    fontFamily: 'Gilroy Bold'),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 150,
                              ),
                              Text(
                                message.date?.toString() ?? "",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.height / 60,
                                    fontFamily: 'Gilroy Medium'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    displayText,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              60,
                                      fontFamily: 'Gilroy Medium',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> speakMessage(String message) async {
    await TextToSpeech.speak(message);
  }

  void showCustomAlertDialog(BuildContext context, message, String? sender) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 15),
            content: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: ListTile(
                title: Text(sender.toString()),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(message.toString()),
                ),
              ),
            ),
            actions: [
              ElevatedButton(onPressed: () {}, child: Text("Copy")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close"))
            ],
          );
        });
  }

  void _showErrorBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please enter a valid phone number (10 digits).'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// FloatingActionButton(
// onPressed: ()
// async {
// var permission = await Permission.sms.status;
// if (permission.isGranted) {
// //  for (var address in addresses) {
// final addressMessages = await _query.querySms(
// kinds: [SmsQueryKind.inbox],
// address: "+918178996556",
// count: messages.length,
// );
// stringMessages = messages.map((message) => message.body.toString()).toList();
// debugPrint("270-->> $stringMessages");
// messages.addAll(addressMessages);
// //}
// for (int i = 0; i < messages.length; i++) {
// await speakMessage(messages[i].body.toString());
// }
// setState(() {
// _messages = messages;
// });
// } else {
// await Permission.sms.request();
// }
// },
// child: const Icon(Icons.refresh),
// ),
