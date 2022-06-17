import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:ecos12_chat_app/widgets/box.dart';
import 'package:flutter/material.dart';

class AppBarConversation extends AppBar {
  final String textTitle;
  final String? conversationID;
  AppBarConversation({Key? key, required this.textTitle, this.conversationID = ''})
      : super(
          key: key,
          backgroundColor: ColorApp.greenTurquoise,
          foregroundColor: Colors.white,
          actions: [],
          toolbarHeight: 65,
          elevation: 15,
          // automaticallyImplyLeading: false,
          title: Row(
            children: [
              // Builder(builder: (context) {
              //   return InkWell(
              //     child: const Icon(Icons.arrow_back_ios, size: 25),
              //     onTap: () {
              //       Navigator.of(context).pop();
              //     },
              //   );
              // }),
              // Box(10),
              CircleAvatar(
                radius: 25,
                backgroundImage: Image.network(
                  'https://picsum.photos/200/300?random=$conversationID',
                  fit: BoxFit.fill,
                ).image,
              ),
              Box(10),
              Expanded(
                child: Text(
                  textTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        );
}
