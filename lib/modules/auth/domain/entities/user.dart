import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? avatar;
  final String token;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
    required this.token,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? avatar,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      token: token ?? this.token,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
      'token': token,
    };
  }

  @override
  List<Object?> get props => [id, email, name, avatar, token];
}