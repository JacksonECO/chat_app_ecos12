import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:ecos12_chat_app/class/chat_store.dart';
import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/module/conversation/conversation_screen.dart';
import 'package:ecos12_chat_app/module/conversation/conversation_store.dart';
import 'package:ecos12_chat_app/widgets/box.dart';
import 'package:ecos12_chat_app/widgets/button_circular.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NewGroupScreen2 extends StatefulWidget {
  final List<UserModel> listUsersSelection;

  const NewGroupScreen2({Key? key, required this.listUsersSelection}) : super(key: key);

  @override
  State<NewGroupScreen2> createState() => _NewGroupScreen2State();
}

class _NewGroupScreen2State extends State<NewGroupScreen2> {
  final titleController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.greenTurquoise,
        foregroundColor: Colors.white,
        title: const Text('Criar Grupo'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Box(10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Digite o nome para o Grupo',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: ColorApp.greenTurquoise, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: ColorApp.greenTurquoise, width: 2),
                ),
              ),
            ),
          ),
          ...widget.listUsersSelection
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: Image.network(
                          'https://picsum.photos/id/${e.registry.substring(0, 2)}/200/300.jpg',
                          fit: BoxFit.fill,
                        ).image,
                      ),
                      Box(15),
                      Expanded(child: Text(e.nickname)),
                      const Icon(Icons.check),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Criar Grupo',
        child: ButtonCircular(
          onTap: () async {
            final newGroup = ConversationStore(null, titleController.text, true);
            await newGroup.createConversation(newGroup, widget.listUsersSelection, titleController.text);
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ConversationScreen(
                  conversation: GetIt.instance.get<ChatStore>().getConversation(newGroup.id!),
                ),
              ),
            );
          },
          child: const Icon(
            Icons.send,
          ),
        ),
      ),
    );
  }
}
