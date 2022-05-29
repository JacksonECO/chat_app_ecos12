import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppBarMessage extends AppBar {
  AppBarMessage({Key? key})
      : super(
          key: key,
          backgroundColor: ColorApp.cultured,
          foregroundColor: ColorApp.azure,
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
                GetIt.instance.get<UserModel>().nickname ?? 'Martha Craig',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        );
}
