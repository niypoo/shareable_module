import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shareable_module/models/shareUser.model.dart';

class ShareableRelationHelper {
  // TO make a relation
  static Future<void> makeRelation({
    required ShareUser userSharingWith,
    required String invitationId,
    DatabaseReference? realtimeDatabaseRef,
    DocumentReference? firestoreRef,
  }) async {
    // if realtime Database Ref exist
    if (realtimeDatabaseRef != null) {
      await realtimeDatabaseRef.child('sharings').child(userSharingWith.id).set(
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

  static Future<void> removeRelation({
    required ShareUser userSharingWith,
    DatabaseReference? realtimeDatabaseRef,
    DocumentReference? firestoreRef,
  }) async {

    
    // if realtime Database Ref exist
    if (realtimeDatabaseRef != null) {
      await realtimeDatabaseRef.child('sharings').child(userSharingWith.id).remove();
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
