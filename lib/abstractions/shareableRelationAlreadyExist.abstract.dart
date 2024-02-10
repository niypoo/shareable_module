import 'package:shareable_module/abstractions/hasShareable.abstractor.dart';
import 'package:shareable_module/models/invitationHandleStatus.model.dart';
import 'package:shareable_module/models/sharePermission.model.dart';
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

  Shareable getShareableObject();

  List<ShareUser> getShareUsers();

  List<ShareablePermission> defaultShareablePermissions = [
    ShareablePermission(
        key: 'read',
        name: 'Read',
        description: 'Who has permission to read data.',
        defaultValue: true),
    ShareablePermission(
        key: 'write',
        name: 'Write',
        description: 'Who has permission to write data.',
        defaultValue: true),
    ShareablePermission(
        key: 'edit',
        name: 'Edit',
        description: 'Who has permission to edit data.',
        defaultValue: false),
    ShareablePermission(
        key: 'remove',
        name: 'Remove',
        description: 'Who has permission to remove data.',
        defaultValue: false),
    ShareablePermission(
        key: 'share',
        name: 'Share',
        description: 'Who has permission to share data.',
        defaultValue: false),
  ];

  List<ShareablePermission> extraPermissions();

  List<ShareablePermission> get getShareablePermissions =>
      [...defaultShareablePermissions, ...extraPermissions()];
}
