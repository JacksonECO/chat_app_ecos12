import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:ecos12_chat_app/module/home/widgets/menu_item.dart';
import 'package:ecos12_chat_app/module/search/new_group_screen1.dart';
import 'package:ecos12_chat_app/module/search/search_screen.dart';
import 'package:ecos12_chat_app/module/user/login_screen.dart';
import 'package:ecos12_chat_app/widgets/button_simple.dart';
import 'package:flutter/material.dart';

class AppBarHome extends AppBar {
  AppBarHome({super.key})
      : super(
          backgroundColor: ColorApp.greenTurquoise,
          foregroundColor: Colors.white,
          actions: [
            Builder(builder: (context) {
              return ButtonSimple(
                child: const Icon(Icons.search, size: 25),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
              );
            }),
            // Box(15),
            PopupMenuButton<void>(
              padding: EdgeInsets.zero,
              splashRadius: 0.0001,
              tooltip: '',
              itemBuilder: (context) {
                return [
                  MenuItens(
                    text: 'Novo Grupo',
                    icon: Icons.group_add_outlined,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewGroupScreen1(),
                        ),
                      );
                    },
                  ),
                  MenuItens(
                    text: 'Buscar Alunos',
                    icon: Icons.search_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                  ),
                  MenuItens(
                    text: 'Peer-to-Peer',
                    icon: Icons.search_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(isSecret: true),
                        ),
                      );
                    },
                  ),
                  const PopupMenuDivider(height: 10),
                  MenuItens(
                    text: 'Sair',
                    icon: Icons.logout_outlined,
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute<void>(builder: (BuildContext context) => const LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ];
              },
            )
          ],
          toolbarHeight: 65,
          elevation: 15,
          title: const Text('Chat UNIFEI'),
        );
}
