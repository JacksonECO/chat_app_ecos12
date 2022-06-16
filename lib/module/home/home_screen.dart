import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:ecos12_chat_app/class/chat_store.dart';
import 'package:ecos12_chat_app/class/date.dart';
import 'package:ecos12_chat_app/module/home/widgets/app_bar_home.dart';
import 'package:ecos12_chat_app/module/conversation/conversation_screen.dart';
import 'package:ecos12_chat_app/widgets/button_simple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ChatStore store = GetIt.instance.get<ChatStore>();

  @override
  void initState() {
    store.startWebSocket();
    super.initState();
  }

  @override
  void dispose() {
    store.closeConnection();
    store.cleanConversation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHome(),
      body: Observer(
        builder: (context) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: ColorApp.greenTurquoise,
            ),
            itemCount: store.listConversation.length,
            itemBuilder: (context, index) {
              return Observer(builder: (context) {
                return ButtonSimple(
                  child: ListTile(
                    key: Key(store.listConversation[index].lastMessage != null
                        ? store.listConversation[index].lastMessage!.text
                        : store.listConversation[index].toString()),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('https://picsum.photos/id/$index/200/300.jpg'),
                    ),
                    title:
                        Text(store.listConversation[index].title, style: const TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text(
                      store.listConversation[index].lastMessage == null
                          ? ''
                          : store.listConversation[index].lastMessage!.text,
                    ),
                    trailing: Text(
                      store.listConversation[index].lastMessage == null
                          ? ''
                          : Date.hoursWithMinute(
                              store.listConversation[index].lastMessage!.timestamp ??
                                  store.listConversation[index].lastMessage!.timestampSend!,
                            ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ConversationScreen(store.listConversation[index].id),
                      ),
                    );
                  },
                );
              });
            },
          );
        },
      ),
    );
  }
}
