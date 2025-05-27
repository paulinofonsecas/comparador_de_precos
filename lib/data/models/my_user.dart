import 'dart:convert';

import 'package:flutter/widgets.dart';

class MyUser {
  MyUser({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
    this.userType,
  });

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map['id'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String?,
      photoURL: map['photoURL'] as String?,
      userType: map['userType'] as String? ?? 'default',
    );
  }

  factory MyUser.fromJson(String source) =>
      MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  final String id;
  final String email;
  final String? displayName;
  final String? photoURL;
  final String? userType;

  MyUser copyWith({
    String? id,
    String? email,
    String? displayName,
    ValueGetter<String?>? photoURL,
    String? userType,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL != null ? photoURL() : this.photoURL,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'userType': userType,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'MyUser(id: $id, email: $email, displayName: $displayName, photoURL: $photoURL, userType: $userType)';
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyUser &&
        other.id == id &&
        other.email == email &&
        other.displayName == displayName &&
        other.photoURL == photoURL &&
        other.userType == userType;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        photoURL.hashCode ^
        userType.hashCode;
  }
}
