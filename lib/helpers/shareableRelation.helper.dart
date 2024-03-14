import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_authentication_service/models/baseUser.model.dart';

class ShareableRelationHelper {
  // TO make a relation
  static Future<void> makeRelation({
    required BaseUser userSharingWith,
    required String invitationId,
    required String objectId,
    required String role,
    DatabaseReference? realtimeDatabaseRef,
    DocumentReference? firestoreRef,
  }) async {
    // define
    final Map<String, dynamic> shareUserData = userSharingWith.toData();
    // inject role
    shareUserData['role'] = role;

    // if realtime Database Ref exist
    if (realtimeDatabaseRef != null) {
      await realtimeDatabaseRef.child('sharings').child(userSharingWith.id).set(
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
    if (firestoreRef != null) {
      // inject user role
      shareUserData['role'] = role;

      // trigger set
      await firestoreRef.set(
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
    DatabaseReference? realtimeDatabaseRef,
    DocumentReference? firestoreRef,
  }) async {
    // if realtime Database Ref exist
    if (realtimeDatabaseRef != null) {
      await realtimeDatabaseRef
          .child('sharings')
          .child(userSharingWith.id)
          .remove();
    }

    // if firestore Database Ref exist
    if (firestoreRef != null) {
      await firestoreRef.set(
        {
          'sharingIds': FieldValue.arrayRemove([userSharingWith.id]),
          'sharingUsers': {userSharingWith.id: FieldValue.delete()},
        },
        SetOptions(merge: true),
      );
    }
  }
}
