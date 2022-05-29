// import 'dart:convert';

// import 'package:mobx/mobx.dart';
// part 'message_model_store.g.dart';

// class MessageModel = _MessageStoreBase with _$MessageModel;

// abstract class _MessageStoreBase with Store {
//   String? id;
//   String text;
//   String nameFrom;
//   String idFrom;
//   DateTime? timestamp;
//   bool isSender;
//   DateTime? timestampSend;

//   _MessageStoreBase({
//     this.id,
//     required this.text,
//     required this.nameFrom,
//     required this.idFrom,
//     this.timestamp,
//     required this.isSender,
//     this.timestampSend,
//   });

//   _MessageStoreBase copyWith({
//     String? id,
//     String? text,
//     String? nameFrom,
//     String? idFrom,
//     DateTime? timestamp,
//     bool? isSender,
//     DateTime? timestampSend,
//   }) {
//     return MessageModel(
//       id: id ?? this.id,
//       text: text ?? this.text,
//       nameFrom: nameFrom ?? this.nameFrom,
//       idFrom: idFrom ?? this.idFrom,
//       timestamp: timestamp ?? this.timestamp,
//       isSender: isSender ?? this.isSender,
//       timestampSend: timestampSend ?? this.timestampSend,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'text': text,
//       'nameFrom': nameFrom,
//       'idFrom': idFrom,
//       'timestamp': timestamp?.millisecondsSinceEpoch,
//       'isSender': isSender,
//       'timestampSend': timestampSend?.millisecondsSinceEpoch,
//     };
//   }

//   Map<String, dynamic> sendToMap() {
//     return {
//       'text': text,
//       'nameFrom': nameFrom,
//       'idFrom': idFrom,
//     };
//   }

//   factory _MessageStoreBase.fromMap(Map<String, dynamic> map) {
//     return MessageModel(
//       id: map['id'],
//       text: map['text'] ?? '',
//       nameFrom: map['nameFrom'] ?? '',
//       idFrom: map['idFrom'] ?? '',
//       timestamp: map['timestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(map['timestamp']) : null,
//       isSender: map['isSender'] ?? false,
//       timestampSend: map['timestampSend'] != null ? DateTime.fromMillisecondsSinceEpoch(map['timestampSend']) : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory _MessageStoreBase.fromJson(String source) => _MessageStoreBase.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Message(id: $id, text: $text, nameFrom: $nameFrom, idFrom: $idFrom, timestamp: $timestamp, isSender: $isSender, timestampSend: $timestampSend)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is MessageModel &&
//         other.id == id &&
//         other.text == text &&
//         other.nameFrom == nameFrom &&
//         other.idFrom == idFrom &&
//         other.timestamp == timestamp &&
//         other.isSender == isSender &&
//         other.timestampSend == timestampSend;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         text.hashCode ^
//         nameFrom.hashCode ^
//         idFrom.hashCode ^
//         timestamp.hashCode ^
//         isSender.hashCode ^
//         timestampSend.hashCode;
//   }
// }
