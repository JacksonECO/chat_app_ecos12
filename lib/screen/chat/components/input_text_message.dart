import 'package:ecos12_chat_app/app/app_color.dart';
import 'package:ecos12_chat_app/components/box.dart';
import 'package:flutter/material.dart';

class InputTextMessage extends StatefulWidget {
  final void Function(TextEditingController) sendOnTap;
  const InputTextMessage({Key? key, required this.sendOnTap}) : super(key: key);

  @override
  State<InputTextMessage> createState() => _InputTextMessageState();
}

class _InputTextMessageState extends State<InputTextMessage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColor.cultured,
      ),
      child: Row(
        children: [
          Box(10),
          const Icon(Icons.sentiment_satisfied),
          Box(10),
          Expanded(
            child: SingleChildScrollView(
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Mensagem',
                  border: InputBorder.none,
                ),
                maxLines: 3,
                minLines: 1,
              ),
            ),
          ),
          Box(10),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10000), color: AppColor.greenTurquoise),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
              onTap: () => widget.sendOnTap(controller),
            ),
          ),
          Box(10),
        ],
      ),
    );
  }
}
