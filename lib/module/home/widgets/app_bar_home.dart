import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:ecos12_chat_app/class/chat_store.dart';
import 'package:ecos12_chat_app/module/search/search_screen.dart';
import 'package:ecos12_chat_app/module/user/login_screen.dart';
import 'package:ecos12_chat_app/widgets/box.dart';
import 'package:ecos12_chat_app/widgets/button_simple.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppBarHome extends AppBar {
  AppBarHome({Key? key})
      : super(
          key: key,
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
            Box(15),
            Builder(builder: (context) {
              return ButtonSimple(
                child: const Icon(Icons.menu, size: 25),
                onTap: () {
                  GetIt.instance.get<ChatStore>().closeConnection();

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(builder: (BuildContext context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
              );
            }),
            Box(15),
          ],
          toolbarHeight: 65,
          elevation: 15,
          title: const Text('Chat UNIFEI'),
        );
}
