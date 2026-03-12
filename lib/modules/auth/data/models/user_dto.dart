import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';

@immutable
class UserDto {
  final String id;
  final String email;
  final String name;
  final String? avatar;
  final String token;

  const UserDto({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
    required this.token,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
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

  User toDomain() {
    return User(
      id: id,
      email: email,
      name: name,
      avatar: avatar,
    );
  }

  factory UserDto.fromDomain(
    User user, {
    required String token,
  }) {
    return UserDto(
      id: user.id,
      email: user.email,
      name: user.name,
      avatar: user.avatar,
      token: token,
    );
  }
}
