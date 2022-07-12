import 'dart:convert';

class UserModel {
  late String registry;
  late String nickname;
  String? token;

  bool get isValid {
    return true;
    // return id != null &&
    //     id!.isNotEmpty &&
    //     registry != null &&
    //     registry!.isNotEmpty &&
    //     nickname != null &&
    //     nickname!.isNotEmpty;
  }

  void update(UserModel newUser) {
    registry = newUser.registry;
    nickname = newUser.nickname;
    token = newUser.token;
  }

  UserModel.init() {
    registry = '';
    nickname = '';
    token = null;
  }

  UserModel({
    required this.registry,
    required this.nickname,
    required this.token,
  });

  UserModel copyWith({
    String? registry,
    String? nickname,
    String? token,
  }) {
    return UserModel(
      registry: registry ?? this.registry,
      nickname: nickname ?? this.nickname,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'registry': registry,
      'nickname': nickname,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      registry: map['registry']!,
      nickname: map['nickname']!,
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(registry: $registry, nickname: $nickname, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.registry == registry && other.nickname == nickname && other.token == token;
  }

  @override
  int get hashCode => registry.hashCode ^ nickname.hashCode ^ token.hashCode;
}
