import 'package:ecos12_chat_app/module/conversation/conversation_store.dart';
import 'package:ecos12_chat_app/module/conversation/widgets/app_bar_message.dart';
import 'package:ecos12_chat_app/module/conversation/widgets/input_text_message.dart';
import 'package:ecos12_chat_app/module/conversation/widgets/message_tile.dart';
import 'package:ecos12_chat_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:ecos12_chat_app/class/chat_store.dart';

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
  late final ConversationStore messageStore;

  @override
  void initState() {
    messageStore = GetIt.instance.get<ChatStore>().getMessage(widget.idConversation)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConversation(
        textTitle: messageStore.title,
      ),
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
