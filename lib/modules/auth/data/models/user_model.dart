import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? avatar;
  final String token;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
    required this.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String?,
      token: map['token'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
      'token': token,
    };
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      avatar: avatar,
      token: token,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      avatar: user.avatar,
      token: user.token,
    );
  }

  @override
  List<Object?> get props => [id, email, name, avatar, token];
}