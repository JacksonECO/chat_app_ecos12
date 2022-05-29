import 'package:ecos12_chat_app/class/date.dart';
import 'package:ecos12_chat_app/class/model/message_model.dart';
import 'package:ecos12_chat_app/widgets/box.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final MessageModel message;
  const MessageTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        padding: const EdgeInsets.fromLTRB(10, 7, 8, 8),
        decoration: BoxDecoration(
          color: message.isSender ? Colors.green[300] : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SelectableText(
              message.text + '      ',
              style: const TextStyle(height: 1.5, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Box(5),
            message.timestamp == null
                ? Box(10,
                    child: const CircularProgressIndicator(
                      strokeWidth: 1,
                    ))
                : Text(
                    Date.hoursWithSeconds(message.timestamp!),
                    style: const TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w400),
                  ),
          ],
        ),

        /*
        child: Stack(alignment: Alignment.bottomRight, children: [
          Column(
            children: [
              SelectableText(
                message.text + "      ",
                style: TextStyle(height: 1.5, fontSize: 16),
              ),
              Box(17),
            ],
          ),
          Text(
            dateHours(message.date),
            style: TextStyle(fontSize: 13),
          )
        ]),
        */
      ),
    );
  }
}
