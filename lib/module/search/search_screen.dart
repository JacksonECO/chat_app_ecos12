import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:ecos12_chat_app/class/chat_store.dart';
import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/class/rest.dart';
import 'package:ecos12_chat_app/module/conversation/conversation_screen.dart';
import 'package:ecos12_chat_app/module/conversation/conversation_store.dart';
import 'package:ecos12_chat_app/module/search/search_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class SearchScreen extends StatefulWidget {
  final bool isSecret;
  const SearchScreen({Key? key, this.isSecret = false}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final store = SearchStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.greenTurquoise,
        foregroundColor: Colors.white,
        title: TextFormField(
          onChanged: store.setSearch,
          decoration: const InputDecoration(
            hintText: 'Digite o nome do usuário',
            border: InputBorder.none,
          ),
        ),
      ),
      body: Observer(builder: (_) {
        if (store.listUser.isEmpty) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return ListView.builder(
          itemCount: store.listUser.length,
          itemBuilder: (_, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: Image.network(
                  'https://picsum.photos/id/$index/200/300.jpg',
                  fit: BoxFit.fill,
                ).image,
              ),
              title: Text(store.listUser[index].nickname),
              subtitle: Text(store.listUser[index].registry),
              onTap: () async {
                if (widget.isSecret) {
                  final _idConversation = 'secret:${store.listUser[index].registry}';
                  final chatOlder = GetIt.instance.get<ChatStore>().getConversation(_idConversation);

                  if (chatOlder != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConversationScreen(
                          conversation: chatOlder,
                          secretRegistry: store.listUser[index].registry,
                        ),
                      ),
                    );
                  } else {
                    GetIt.instance.get<ChatStore>().addConversationStore(ConversationStore(
                          id: _idConversation,
                          title: 'Privado: ${store.listUser[index].nickname}',
                          isGroup: false,
                        ));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConversationScreen(
                          conversation: GetIt.instance.get<ChatStore>().getConversation(_idConversation),
                          secretRegistry: store.listUser[index].registry,
                        ),
                      ),
                    );
                  }
                  return;
                }

                final users = await Rest.get(path: '/conversations');

                for (var element in users) {
                  final a = element['participantsRegistry'] as List;
                  if (a.length == 2) {
                    if (a.contains(GetIt.instance.get<UserModel>().registry) &&
                        a.contains(store.listUser[index].registry)) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConversationScreen(
                            conversation: GetIt.instance.get<ChatStore>().getConversation(element['id']),
                          ),
                        ),
                      );
                      return;
                    }
                  }
                }

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConversationScreen(
                      newConversationUser: store.listUser[index],
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
