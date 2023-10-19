import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:inandout_try/speech_to_text.dart';
class MoneySms extends StatefulWidget {

  const MoneySms( {super.key , required this.messages, });
  final List<SmsMessage> messages;

  @override
  State<MoneySms> createState() => _MoneySmsState();
}

class _MoneySmsState extends State<MoneySms> {
  bool isSwitched = false;
  String selectedMainCategory = 'Expense';
  String selectedSubCategory = '';
  List<String> expenseSubCategories = [
    "Expense - Subcategory 1",
    "Expense - Subcategory 2",
    "Expense - Subcategory 3",
  ];

  List<String> incomeSubCategories = [
    "Income - Subcategory A",
    "Income - Subcategory B",
  ];

  List<String> reportList = [
    "Quality1",
    "Quality2",
    "Quality3",
    "Quality4",
    "Quality5",
    "Quality6",
    "Quality7",
    "Quality8",
    "Quality9",
    "Quality10",
    "Quality11",
  ];

  List<String> selectedReportList = [];
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    }
    else if (isSwitched == true) {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height:
              MediaQuery
                  .of(context)
                  .size
                  .height / 50,
            ),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    void showSpeechRecognitionDialog(BuildContext context) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SpeechRecognitionDialog();
                        },
                      );
                    }

                  },
                  child: Text("Showing History",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Gilroy Bold',
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .height / 50),
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
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 50,
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 1.29,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child:

              ListView.builder(
                itemCount: widget.messages.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i) {
                  var message = widget.messages[i];
                  String text = message.body.toString();
                  List<String> words = text.split(' ');

                  if (words.length > 3) {
                    words = words.sublist(0, 3);
                  }

                  String displayText = words.join(' ');
                  return Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery
                        .of(context)
                        .size
                        .height / 60),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () {
                          showCustomAlertDialog(context, message.body , message.sender);
                        },
                        child: Row(
                          children: [
                            Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 16,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 9,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.orange,
                                child: Text(
                                    message.sender?[0].toUpperCase() ?? ""),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(message.sender.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 50,
                                      fontFamily: 'Gilroy Bold'),
                                ),
                                SizedBox(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 150,
                                ),
                                Text(
                                  message.date?.year.toString() ?? "",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: MediaQuery.of(context).size.height/ 60,
                                      fontFamily: 'Gilroy Medium'),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      displayText,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: MediaQuery.of(context).size.height / 60,
                                        fontFamily: 'Gilroy Medium',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Amount",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 50,
                                      fontFamily: 'Gilroy Bold'),
                                ),
                                SizedBox(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 150,
                                ),

                                Row(
                                  children: [

                                    Transform.scale(
                                      scale: 0.60,
                                      child: DropdownButton<String>(
                                        value: selectedMainCategory,
                                        hint:  const Text("Category"),
                                        items: ['Expense', 'Income']
                                            .map((mainCategory) {
                                          return DropdownMenuItem<String>(
                                            value: mainCategory,
                                            child: Text(mainCategory),
                                          );
                                        })
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedMainCategory = value!;
                                            selectedSubCategory = ''; // Reset subcategory selection
                                          });
                                        },
                                      ),
                                    ),


                                  ],
                                ),

                              ],
                            ),

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
  void showCustomAlertDialog(BuildContext context,  message, String? sender) {

    showDialog(
        context: context,
        builder: (context)
        {
          return
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 15),
              content: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child:
                  ListTile(
                    title: Text(sender.toString()),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(message.toString()),
                    ),

                  ),

              ),
              actions: [
                ElevatedButton(onPressed: (){}, child: Text("Copy")),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Close"))
              ],
          );
        }
    );


  }
  showSubCategoryDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> selectedReportList = [];

        return AlertDialog(
          title: Text("Select Reports"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MultiSelectChip(
                reportList,
                onSelectionChanged: (selectedList) {
                  setState(() {
                    selectedReportList = selectedList;
                  });
                },
                maxSelection: 1,
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>)? onSelectionChanged;
  final Function(List<String>)? onMaxSelected;
  final int? maxSelection;

  MultiSelectChip(this.reportList, {this.onSelectionChanged, this.onMaxSelected, this.maxSelection});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            if (selectedChoices.length == (widget.maxSelection ?? -1) && !selectedChoices.contains(item)) {
              widget.onMaxSelected?.call(selectedChoices);
            } else {
              setState(() {
                selectedChoices.contains(item) ? selectedChoices.remove(item) : selectedChoices.add(item);
                widget.onSelectionChanged?.call(selectedChoices);
              });
            }
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}


