import 'package:shareable_module/enums/role.enum.dart';
import 'package:shareable_module/models/shareUser.model.dart';

abstract class Shareable {
  final String id;
  final String uid;
  final String displayName;

  Shareable({
    required this.id,
    required this.uid,
    required this.displayName,
  });

  // Get sharable users list
  List<ShareUser> shareableUsers(List<String> except);

  // Remove sharable user from list
  Future<void> removeFromShareableUsers(ShareUser user);

  // update user permissions from sharable user list
  Future<void> updateShareableUser(
    Map<String, dynamic> data,
    ShareUser user,
  );

  // check current user permission from sharable
  // interfaceAlert to disable message to user
  bool hasRole(List<Role> roles , {bool alertDisplay = false});

  // check if current user is owner
  bool get isOwner;

  ShareUser? get currentUserFromShareableList;
}
