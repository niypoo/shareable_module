import 'package:shareable_module/models/sharePermission.model.dart';
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

  List<ShareablePermission> get shareablePermissions;

  List<ShareUser> shareableUsers();

  List<ShareUser> shareableUsersExcept(dynamic userId);
  
  Future<void> removeShareableUser(ShareUser user);
}
