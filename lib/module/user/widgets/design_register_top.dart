import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:ecos12_chat_app/module/user/login_screen.dart';
import 'package:flutter/material.dart';

class DesignRegisterTop extends StatelessWidget {
  const DesignRegisterTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20),
          margin: EdgeInsets.zero,
          height: 100,
          decoration: const BoxDecoration(
            color: ColorApp.greenTurquoise,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  color: ColorApp.azure,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: InkWell(
                  onTap: () => Navigator.canPop(context)
                      ? Navigator.pop(context)
                      : Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginScreen())),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Crie sua conta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          color: ColorApp.greenTurquoise,
          child: Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            height: 35,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
            ),
          ),
        ),
      ],
    );
  }
}
