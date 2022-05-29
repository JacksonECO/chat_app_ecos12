import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:ecos12_chat_app/module/conversation/conversation_store.dart';
import 'package:ecos12_chat_app/widgets/box.dart';
import 'package:flutter/material.dart';

class InputTextMessage extends StatefulWidget {
  final ConversationStore messageStore;

  const InputTextMessage({
    Key? key,
    required this.messageStore,
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
        color: ColorApp.cultured,
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10000), color: ColorApp.greenTurquoise),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
              onTap: () {
                widget.messageStore.sendOnTap(controller);
              },
            ),
          ),
          Box(10),
        ],
      ),
    );
  }
}
