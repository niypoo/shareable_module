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

  List<ShareUser> shareableUsers();

  List<ShareUser> shareableUsersExcept(dynamic userId);

  Future<void> removeShareableUser(ShareUser user);

  Future<void> updateShareablePermssions(Map<String, dynamic> permissions, ShareUser user,);
}
