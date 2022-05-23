import 'package:flutter/material.dart';

import 'package:ecos12_chat_app/app/app_color.dart';
import 'package:ecos12_chat_app/components/box.dart';
import 'package:ecos12_chat_app/mobx/conversation.dart';

class InputTextMessage extends StatefulWidget {
  final ConversationStore conversationStore;

  const InputTextMessage({
    Key? key,
    required this.conversationStore,
  }) : super(key: key);

  @override
  State<InputTextMessage> createState() => _InputTextMessageState();
}

class _InputTextMessageState extends State<InputTextMessage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColor.cultured,
      ),
      child: Row(
        children: [
          Box(10),
          const Icon(Icons.sentiment_satisfied),
          Box(10),
          Expanded(
            child: SingleChildScrollView(
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Mensagem',
                  border: InputBorder.none,
                ),
                maxLines: 3,
                minLines: 1,
              ),
            ),
          ),
          Box(10),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10000), color: AppColor.greenTurquoise),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
              onTap: () {
                widget.conversationStore.sendOnTap(controller);
              },
            ),
          ),
          Box(10),
        ],
      ),
    );
  }
}
