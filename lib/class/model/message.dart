import 'dart:convert';

class Message {
  String? id;
  String text;
  String nameFrom;
  String idFrom;
  DateTime? timestamp;
  bool isSender;

  Message({
    this.id,
    required this.text,
    required this.nameFrom,
    required this.idFrom,
    this.timestamp,
    required this.isSender,
  });

  Message copyWith({
    String? id,
    String? text,
    String? nameFrom,
    String? idFrom,
    DateTime? timestamp,
    bool? isSender,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      nameFrom: nameFrom ?? this.nameFrom,
      idFrom: idFrom ?? this.idFrom,
      timestamp: timestamp ?? this.timestamp,
      isSender: isSender ?? this.isSender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'nameFrom': nameFrom,
      'idFrom': idFrom,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'isSender': isSender,
    };
  }

  Map<String, dynamic> sendToMap() {
    return {
      'text': text,
      'nameFrom': nameFrom,
      'idFrom': idFrom,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      text: map['text'] ?? '',
      nameFrom: map['nameFrom'] ?? '',
      idFrom: map['idFrom'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(map['timestamp']) : null,
      isSender: map['isSender'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Message(id: $id, text: $text, nameFrom: $nameFrom, idFrom: $idFrom, timestamp: $timestamp, isSender: $isSender)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.id == id &&
        other.text == text &&
        other.nameFrom == nameFrom &&
        other.idFrom == idFrom &&
        other.timestamp == timestamp &&
        other.isSender == isSender;
  }

  @override
  int get hashCode {
    return id.hashCode ^ text.hashCode ^ nameFrom.hashCode ^ idFrom.hashCode ^ timestamp.hashCode ^ isSender.hashCode;
  }
}
