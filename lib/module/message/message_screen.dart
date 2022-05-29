import 'package:ecos12_chat_app/module/message/message_store.dart';
import 'package:ecos12_chat_app/module/message/widgets/app_bar_message.dart';
import 'package:ecos12_chat_app/module/message/widgets/input_text_message.dart';
import 'package:ecos12_chat_app/module/message/widgets/message_tile.dart';
import 'package:ecos12_chat_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:ecos12_chat_app/class/chat_store.dart';

class MessageScreen extends StatefulWidget {
  final String idConversation;
  const MessageScreen(
    this.idConversation, {
    Key? key,
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  ChatStore store = GetIt.instance.get<ChatStore>();
  late final MessageStore messageStore;

  @override
  void initState() {
    store.startWebSocket();
    messageStore = store.getMessage(widget.idConversation)!;
    super.initState();
  }

  @override
  void dispose() {
    store.closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMessage(),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              'assets/images/background.jpg',
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              Box(3),
              Observer(builder: (_) {
                return Expanded(
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior(),
                    child: ListView.builder(
                      reverse: true,
                      controller: messageStore.controllerScroll,
                      semanticChildCount: messageStore.listMessage.length,
                      shrinkWrap: true,
                      itemCount: messageStore.listMessage.length,
                      itemBuilder: (context, index) => MessageTile(message: messageStore.listMessage[index]),
                    ),
                  ),
                );
              }),
              InputTextMessage(messageStore: messageStore),
            ],
          ),
        ],
      ),
    );
  }
}
