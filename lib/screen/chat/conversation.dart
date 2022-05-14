import 'package:ecos12_chat_app/components/box.dart';
import 'package:ecos12_chat_app/mobx/chat.dart';
import 'package:ecos12_chat_app/screen/chat/components/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:ecos12_chat_app/screen/chat/components/app_bar_chat.dart';
import 'package:ecos12_chat_app/screen/chat/components/input_text_message.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  ChatStore store = GetIt.instance.get<ChatStore>();

  @override
  void initState() {
    store.startWebSocket();
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
              Box(5),
              Observer(builder: (_) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: store.conversation.first.message.length,
                    itemBuilder: (context, index) => MessageTile(message: store.conversation.first.message[index]),
                  ),
                );
              }),
              InputTextMessage(
                sendOnTap: store.conversation.first.sendOnTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
