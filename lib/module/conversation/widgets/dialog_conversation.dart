import 'package:flutter/material.dart';

abstract class DialogConversation {
  static showDialogPeerConnectionInvalid(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Destinatário desconectado'),
          content: const Text(
            'Para que seja possível iniciar a conversa ou enviar mensagens, o destinatário deve estar conectado.',
          ),
          actions: [
            TextButton(
              child: const Text('Voltar'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
