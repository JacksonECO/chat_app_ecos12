import 'package:ecos12_chat_app/mobx/conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:ecos12_chat_app/components/box.dart';
import 'package:ecos12_chat_app/mobx/chat.dart';
import 'package:ecos12_chat_app/screen/chat/components/app_bar_chat.dart';
import 'package:ecos12_chat_app/screen/chat/components/input_text_message.dart';
import 'package:ecos12_chat_app/screen/chat/components/message_tile.dart';

class ConversationScreen extends StatefulWidget {
  final String idConversation;
  const ConversationScreen(
    this.idConversation, {
    Key? key,
  }) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  ChatStore store = GetIt.instance.get<ChatStore>();
  late final ConversationStore conversation;

  @override
  void initState() {
    store.startWebSocket();
    conversation = store.getConversation(widget.idConversation)!;
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
      appBar: AppBarChat(),
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
                      controller: conversation.controllerScroll,
                      semanticChildCount: conversation.listMessage.length,
                      shrinkWrap: true,
                      itemCount: conversation.listMessage.length,
                      itemBuilder: (context, index) => MessageTile(message: conversation.listMessage[index]),
                    ),
                  ),
                );
              }),
              InputTextMessage(
                conversationStore: conversation,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
