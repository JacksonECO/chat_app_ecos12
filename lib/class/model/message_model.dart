import 'dart:convert';

import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:get_it/get_it.dart';

class MessageModel {
  String? id;
  String text;
  String? nameFrom;
  String conversationId;
  String senderRegistry;
  DateTime? timestamp;

  bool isSender;
  DateTime? timestampSend;

  MessageModel({
    this.id,
    required this.text,
    required this.nameFrom,
    required this.conversationId,
    required this.senderRegistry,
    this.timestamp,
    required this.isSender,
    this.timestampSend,
  });

  MessageModel copyWith({
    String? id,
    String? text,
    String? nameFrom,
    String? conversationId,
    String? senderRegistry,
    DateTime? timestamp,
    bool? isSender,
    DateTime? timestampSend,
  }) {
    return MessageModel(
      id: id ?? this.id,
      text: text ?? this.text,
      nameFrom: nameFrom ?? this.nameFrom,
      conversationId: conversationId ?? this.conversationId,
      senderRegistry: senderRegistry ?? this.senderRegistry,
      timestamp: timestamp ?? this.timestamp,
      isSender: isSender ?? this.isSender,
      timestampSend: timestampSend ?? this.timestampSend,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'nameFrom': nameFrom,
      'conversationId': conversationId,
      'senderRegistry': senderRegistry,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'isSender': isSender,
      'timestampSend': timestampSend?.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> sendToMap() {
    return {
      'type': 'message',
      'senderRegistry': GetIt.instance.get<UserModel>().registry,
      'conversationId': conversationId,
      'text': text,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      text: map['text'] ?? '',
      nameFrom: map['nameFrom'],
      conversationId: map['conversationId'] ?? '',
      senderRegistry: map['senderRegistry'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(map['timestamp']) : null,
      isSender: map['isSender'] ?? false,
      timestampSend: map['timestampSend'] != null ? DateTime.fromMillisecondsSinceEpoch(map['timestampSend']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(id: $id, text: $text, nameFrom: $nameFrom, conversationId: $conversationId, senderRegistry: $senderRegistry, timestamp: $timestamp, isSender: $isSender, timestampSend: $timestampSend)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.id == id &&
        other.text == text &&
        other.nameFrom == nameFrom &&
        other.conversationId == conversationId &&
        other.senderRegistry == senderRegistry &&
        other.timestamp == timestamp &&
        other.isSender == isSender &&
        other.timestampSend == timestampSend;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        text.hashCode ^
        nameFrom.hashCode ^
        conversationId.hashCode ^
        senderRegistry.hashCode ^
        timestamp.hashCode ^
        isSender.hashCode ^
        timestampSend.hashCode;
  }
}
