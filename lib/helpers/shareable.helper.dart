import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_authentication_service/models/baseUser.model.dart';

class ShareableHelper {
  // TO make a relation
  Future<void> makeRelation({
    required BaseUser userSharingWith,
    required String invitationId,
    DatabaseReference? realtimeDatabaseRef,
    DocumentReference? firestoreRef,
  }) async {
    // if realtime Database Ref exist
    if (realtimeDatabaseRef != null) {
      await realtimeDatabaseRef.set(
        {
          "status": true,
          'userId': userSharingWith.id,
          'invitationId': invitationId,
        },
      );
    }

    // if firestore Database Ref exist
    if (firestoreRef != null) {
      await firestoreRef.set(
        {
          'sharingIds': FieldValue.arrayUnion([userSharingWith.id]),
          'sharingUsers': {userSharingWith.id: userSharingWith.toData()},
        },
        SetOptions(merge: true),
      );
    }
  }

  Future<void> removeRelation({
    required BaseUser userSharingWith,
    required String invitationId,
    DatabaseReference? realtimeDatabaseRef,
    DocumentReference? firestoreRef,
  }) async {
    // if realtime Database Ref exist
    if (realtimeDatabaseRef != null) {
      await realtimeDatabaseRef.remove();
    }

    // if firestore Database Ref exist
    if (firestoreRef != null) {
      await firestoreRef.set(
        {
          'sharingIds': FieldValue.arrayRemove([userSharingWith]),
          'sharingUsers': {userSharingWith: FieldValue.delete()},
        },
        SetOptions(merge: true),
      );
    }
  }
}
