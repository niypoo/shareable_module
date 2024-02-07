import 'package:shareable_module/abstractions/hasShareable.abstractor.dart';
import 'package:shareable_module/models/invitationHandleStatus.model.dart';
import 'package:shareable_module/models/shareUser.model.dart';

abstract class ShareableServiceInvitationHandler {
  // if user use qr-code/link more then once
  // or if user it before in seconde time use it to redirect to object
  Future<void> relationAlreadyExist(String objectId);

  // if invitation is valid use it to create relation between objects
  Future<InvitationHandleStatus> relationCreation(
    String objectId,
    String invitationId,
  );

  Future<void> permissionsShareableUserUpdate(Map<String, dynamic> permissions);

  Shareable getShareableObject();
  List<ShareUser> getShareUsers();
}
