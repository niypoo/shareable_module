import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_service/firestore.util.dart';
import 'package:shareable_module/models/invitation.model.dart';

class InvitationFirestoreHelper {
  //get Medical Case Document
  static CollectionReference<Map<String, dynamic>> invitationRef() {
    return FirestoreService.to.instance.collection('invitations');
  }

  //Add New Invitations
  static Future<void> create(ShareInvitation shareInvitation) async {
    //update
    return await invitationRef().doc(shareInvitation.id).set(
          shareInvitation.toData(),
          SetOptions(merge: false),
        );
  }

  //get Invitation document by id
  static Future<DocumentSnapshot> getById(String invitationId) async {
    //get Invitation document
    return await invitationRef().doc(invitationId).get();
  }

  //delete Invitation by id
  static Future<void> deleteById(String invitationId) async {
    //delete
    await invitationRef().doc(invitationId).delete();
  }

  // only in case account want delete his case
  static Future<void> deleteByObjectId(String objectId) async {
    // init stream
    QuerySnapshot<Map<String, dynamic>> docs =
        await invitationRef().where('objectId', arrayContains: objectId).get();

    // skip
    if (docs.docs.isEmpty) return;

    // delete one by one
    for (final doc in docs.docs) {
      // skip
      if (doc.id.trim().isEmpty) return;

      // remove medical case
      doc.reference.delete();
    }
  }
}
