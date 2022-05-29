import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:ecos12_chat_app/widgets/box.dart';
import 'package:flutter/material.dart';

class AppBarConversation extends AppBar {
  final String textTitle;
  AppBarConversation({Key? key, required this.textTitle})
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
                  'https://picsum.photos/1200/1200',
                  fit: BoxFit.fill,
                ).image,
              ),
              Box(10),
              Text(
                textTitle,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        );
}
