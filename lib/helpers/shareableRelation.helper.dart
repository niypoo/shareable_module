import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_authentication_service/models/baseUser.model.dart';
import 'package:shareable_module/abstractions/shareableServiceInvitationHandler.abstract.dart';

class ShareableRelationHelper {
  // TO make a relation
  static Future<void> makeRelation({
    required BaseUser userSharingWith,
    required String invitationId,
    required String objectId,
    required String role,
    required ShareableServiceInvitationHandler handler,
  }) async {
    // define
    final Map<String, dynamic> shareUserData = userSharingWith.toData();
    // inject role
    shareUserData['role'] = role;

    // if realtime Database Ref exist
    if (handler.shareableRealtimeDatabaseRef != null) {
      await handler.shareableRealtimeDatabaseRef!
          .child(objectId)
          .child('sharings')
          .child(userSharingWith.id)
          .set(
        {
          "status": true,
          'userId': userSharingWith.id,
          'objectId': objectId,
          'invitationId': invitationId,
          'role': role,
        },
      );
    }

    // if firestore Database Ref exist
    if (handler.shareableFirestoreRef != null) {
      // trigger set
      await handler.shareableFirestoreRef!.doc(objectId).set(
        {
          'sharingIds': FieldValue.arrayUnion([userSharingWith.id]),
          'sharingUsers': {userSharingWith.id: shareUserData},
          'objectId': objectId,
          'invitationId': invitationId,
        },
        SetOptions(merge: true),
      );
    }
  }

  static Future<void> removeRelation({
    required BaseUser userSharingWith,
    required String objectId,
    required ShareableServiceInvitationHandler handler,
  }) async {
    // if realtime Database Ref exist
    if (handler.shareableRealtimeDatabaseRef != null) {
      await handler.shareableRealtimeDatabaseRef!
          .child(objectId)
          .child('sharings')
          .child(userSharingWith.id)
          .remove();
    }

    // if firestore Database Ref exist
    if (handler.shareableFirestoreRef != null) {
      await handler.shareableFirestoreRef!.doc(objectId).set(
        {
          'sharingIds': FieldValue.arrayRemove([userSharingWith.id]),
          'sharingUsers': {userSharingWith.id: FieldValue.delete()},
        },
        SetOptions(merge: true),
      );
    }
  }
}
