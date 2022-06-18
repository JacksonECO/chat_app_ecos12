import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:ecos12_chat_app/module/search/new_group_screen2.dart';
import 'package:ecos12_chat_app/module/search/search_store.dart';
import 'package:ecos12_chat_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NewGroupScreen1 extends StatefulWidget {
  const NewGroupScreen1({Key? key}) : super(key: key);

  @override
  State<NewGroupScreen1> createState() => _NewGroupScreen1State();
}

class _NewGroupScreen1State extends State<NewGroupScreen1> {
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
        return Column(
          children: [
            ...store.listUser
                .map(
                  (e) => CheckboxListTile(
                    value: store.listUserSelected.contains(e),
                    onChanged: (selected) {
                      if (selected == null) return;
                      if (selected) {
                        store.addUserSelected(e);
                      } else {
                        store.removeUserSelected(e);
                      }
                    },
                    title: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: Image.network(
                            'https://picsum.photos/id/${e.registry.substring(0, 2)}/200/300.jpg',
                            fit: BoxFit.fill,
                          ).image,
                        ),
                        Box(15),
                        Text(e.nickname),
                      ],
                    ),
                  ),
                )
                .toList(),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewGroupScreen2(
                listUsersSelection: store.listUserSelected,
              ),
            ),
          );
        },
        backgroundColor: ColorApp.greenTurquoise,
        tooltip: 'Continuar',
        child: const Icon(
          Icons.arrow_forward,
        ),
      ),
    );
  }
}
