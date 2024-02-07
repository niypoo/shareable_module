import 'package:firebase_authentication_service/models/baseUser.model.dart';

class ShareUser implements BaseUser {
  @override
  final String id;
  @override
  final String? displayName;
  @override
  final String? email;
  @override
  final String? photoUrl;
  @override
  final String? provider;
  @override
  final bool isAnonymous;
  @override
  final bool primary;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final Map<String, dynamic>? fcmToken;
  @override
  final String? phone;
  @override
  final dynamic type;

  final Map<String, dynamic>? permissions;

  ShareUser({
    required this.id,
    required this.isAnonymous,
    this.email,
    this.photoUrl,
    this.displayName,
    this.provider,
    this.fcmToken,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.primary = false,
    this.permissions,
  });

  factory ShareUser.fromData(dynamic data) {
    return ShareUser(
      id: data['id'],
      displayName: data['displayName'],
      email: data['email'],
      photoUrl: data['photoUrl'],
      provider: data['provider'],
      phone: data['phone'],
      fcmToken: data['fcmToken'],
      primary: data['primary'] ?? false,
      type: data['type'],
      permissions: data['permissions'],
      isAnonymous: data['isAnonymous'] ?? false,
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'])
          : DateTime.now(),
      updatedAt: data['updatedAt'] != null
          ? DateTime.parse(data['updatedAt'])
          : DateTime.now(),
    );
  }

  @override
  Map<String, dynamic> toData() => {
        "id": id,
        'displayName': displayName,
        'email': email,
        'photoUrl': photoUrl,
        'provider': provider,
        'phone': phone,
        'primary': primary,
        'fcmToken': fcmToken,
        'type': type,
        'isAnonymous': isAnonymous,
        'permissions': permissions,
        'createdAt': createdAt != null
            ? createdAt!.toIso8601String()
            : DateTime.now().toIso8601String(),
        'updatedAt': updatedAt != null
            ? updatedAt!.toIso8601String()
            : DateTime.now().toIso8601String(),
      };

  bool isAllow(String key, [bool defaultValue = false]) {
    if (permissions == null) return defaultValue;
    if (permissions!.isEmpty) return defaultValue;
    if (!permissions!.containsKey(key)) return defaultValue;
    if (permissions![key] == null) return defaultValue;
    if (permissions![key] == false) return false;

    return true;
  }

  @override
  Set<String> get getFCMTokens => fcmToken == null
      ? {}
      : Set.from(fcmToken!.values.where((e) => e != null).toList());

  @override
  String get getDisplayName => displayName ?? 'U-1001';
}
