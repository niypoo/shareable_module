import 'package:firebase_authentication_service/models/baseUser.model.dart';

abstract class Shareable {
  final String id;
  final String uid;
  final String displayName;

  Shareable({
    required this.id,
    required this.uid,
    required this.displayName,
  });

  List<BaseUser> shareableUsers();

  List<BaseUser> shareableUsersWithoutOwner();

  Future<void> removeShareableUser(BaseUser user);
}
