import 'package:ecos12_chat_app/app/app_color.dart';
import 'package:ecos12_chat_app/components/box.dart';
import 'package:flutter/material.dart';

class AppBarChat extends AppBar {
  AppBarChat({Key? key})
      : super(
          key: key,
          backgroundColor: AppColor.cultured,
          foregroundColor: AppColor.azure,
          actions: [],
          toolbarHeight: 65,
          elevation: 15,
          title: Row(
            children: [
              InkWell(
                child: const Icon(Icons.arrow_back_ios, size: 25),
                onTap: () {},
              ),
              Box(10),
              CircleAvatar(
                radius: 25,
                backgroundImage: Image.network(
                  'https://picsum.photos/1200/1200',
                  fit: BoxFit.fill,
                ).image,
              ),
              Box(10),
              const Text(
                'Martha Craig',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        );
}
