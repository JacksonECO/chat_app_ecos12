import 'dart:convert';

class Message {
  String? id;
  String text;
  String nameFrom;
  String idFrom;
  DateTime? date;
  bool isSender;

  Message({
    this.id,
    required this.text,
    required this.nameFrom,
    required this.idFrom,
    this.date,
    required this.isSender,
  });

  Message copyWith({
    String? id,
    String? text,
    String? nameFrom,
    String? idFrom,
    DateTime? date,
    bool? isSender,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      nameFrom: nameFrom ?? this.nameFrom,
      idFrom: idFrom ?? this.idFrom,
      date: date ?? this.date,
      isSender: isSender ?? this.isSender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'nameFrom': nameFrom,
      'idFrom': idFrom,
      'date': date?.millisecondsSinceEpoch,
      'isSender': isSender,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      text: map['text'] ?? '',
      nameFrom: map['nameFrom'] ?? '',
      idFrom: map['idFrom'] ?? '',
      date: map['date'] != null ? DateTime.fromMillisecondsSinceEpoch(map['date']) : null,
      isSender: map['isSender'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Message(id: $id, text: $text, nameFrom: $nameFrom, idFrom: $idFrom, date: $date, isSender: $isSender)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Message &&
      other.id == id &&
      other.text == text &&
      other.nameFrom == nameFrom &&
      other.idFrom == idFrom &&
      other.date == date &&
      other.isSender == isSender;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      text.hashCode ^
      nameFrom.hashCode ^
      idFrom.hashCode ^
      date.hashCode ^
      isSender.hashCode;
  }
}
