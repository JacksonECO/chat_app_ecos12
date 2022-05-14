import 'dart:convert';

class UserModel {
  String? id;
  String? registry;
  String? nickname;

  bool get isValid {
    return id != null &&
        id!.isNotEmpty &&
        registry != null &&
        registry!.isNotEmpty &&
        nickname != null &&
        nickname!.isNotEmpty;
  }

  void update(UserModel newUser) {
    id = newUser.id;
    registry = newUser.registry;
    nickname = newUser.nickname;
  }

  UserModel({
    this.id,
    this.registry,
    this.nickname,
  });

  UserModel copyWith({
    String? id,
    String? registry,
    String? nickname,
  }) {
    return UserModel(
      id: id ?? this.id,
      registry: registry ?? this.registry,
      nickname: nickname ?? this.nickname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'registry': registry,
      'nickname': nickname,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'].toString(),
      registry: map['registry'].toString(),
      nickname: map['nickname'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(id: $id, registry: $registry, nickname: $nickname)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.id == id && other.registry == registry && other.nickname == nickname;
  }

  @override
  int get hashCode => id.hashCode ^ registry.hashCode ^ nickname.hashCode;
}
