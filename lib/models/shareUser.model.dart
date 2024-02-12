import 'package:firebase_authentication_service/models/baseUser.model.dart';
import 'package:shareable_module/enums/role.enum.dart';

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

  // Sharable role
  final Role role;

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
    required this.role,
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
      role: stringToRole(data['permissions']),
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
        'role': role.name,
        'createdAt': createdAt != null
            ? createdAt!.toIso8601String()
            : DateTime.now().toIso8601String(),
        'updatedAt': updatedAt != null
            ? updatedAt!.toIso8601String()
            : DateTime.now().toIso8601String(),
      };

  // check if user is own one of candidate roles
  bool are(List<Role> roles) => roles.contains(role);

  @override
  Set<String> get getFCMTokens => fcmToken == null
      ? {}
      : Set.from(fcmToken!.values.where((e) => e != null).toList());

  @override
  String get getDisplayName => displayName ?? 'U-1001';
}
