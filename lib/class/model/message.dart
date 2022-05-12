import 'dart:convert';

class Message {
  String text;
  String? nameFrom;
  DateTime date;
  bool isSender;
  Message({
    required this.text,
    this.nameFrom,
    required this.date,
    required this.isSender,
  });

  Message copyWith({
    String? text,
    String? nameFrom,
    DateTime? date,
    bool? isSender,
  }) {
    return Message(
      text: text ?? this.text,
      nameFrom: nameFrom ?? this.nameFrom,
      date: date ?? this.date,
      isSender: isSender ?? this.isSender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'nameFrom': nameFrom,
      'date': date.millisecondsSinceEpoch,
      'isSender': isSender,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'] ?? '',
      nameFrom: map['nameFrom'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      isSender: map['isSender'] ?? false,
    );
  }

  String toJson() => json.encode({...toMap(), 'type': 'message'});

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Message(text: $text, nameFrom: $nameFrom, date: $date, isSender: $isSender)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.text == text &&
        other.nameFrom == nameFrom &&
        other.date == date &&
        other.isSender == isSender;
  }

  @override
  int get hashCode {
    return text.hashCode ^ nameFrom.hashCode ^ date.hashCode ^ isSender.hashCode;
  }
}
