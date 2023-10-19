// import 'package:flutter/material.dart';
// import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
//
// class _MessagesListView extends StatelessWidget {
//   const _MessagesListView({
//     Key? key,
//     required this.messages,
//     required this.filterAddress,
//   }) : super(key: key);
//
//   final List<SmsMessage> messages;
//   final String filterAddress;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: messages.length,
//       itemBuilder: (BuildContext context, int i) {
//         var message = messages[i];
//
//         return ListTile(
//           subtitle: Text('${message.body}'),
//           onTap: () {
//             showCustomAlertDialog(context, message.body);
//           },
//         );
//       },
//     );
//   }
//   void showCustomAlertDialog(BuildContext context,  message) {
//
//     showDialog(
//         context: context,
//         builder: (context)
//         {
//           return AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 15),
//               content: SingleChildScrollView(
//                   child: Column(
//                       children: [
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                   padding: const EdgeInsets.only(left: 5.0),
//                                   child: Expanded(
//                                     child: Text(
//                                       message.toString(),
//                                       maxLines: 10,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   )
//                               ),
//                             ]),
//                       ])
//               )
//           );
//         }
//     );
//
//
//   }
// }