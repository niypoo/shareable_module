import 'package:firebase_database/firebase_database.dart';
import 'package:realtime_database_service/realtimeDatabase.service.dart';
import 'package:shareable_module/models/invitation.model.dart';

class InvitationDatabaseHelper {
  // ref of database
  static DatabaseReference ref =
      RealtimeDatabaseService.to.instance.ref('invitations');

  // create new invitations
  static Future<void> create(ShareInvitation shareInvitation) async {
    //trigger
    await ref.child(shareInvitation.id!).set(shareInvitation.toData());
    // .catchError(FirestoreService.exceptionHandel);
  }

  // get summary
  static Future<DatabaseEvent> getById(String invitationId) {
    //trigger
    return ref.child(invitationId).once();
  }

  //delete
  static Future<void> deleteById(String? invitationId) async {
    // condition
    if (invitationId == null) return;

    //delete
    await ref.child(invitationId).remove();
  }

  //get log in date range from/to
  static Future<void> deleteByObjectId(String objectId) async {
    // get event
    final DatabaseEvent event =
        await ref.startAt(objectId).endAt(objectId).once();

    //snapshot
    final DataSnapshot snapshot = event.snapshot;

    // define value as map
    final Map<dynamic, dynamic>? data =
        snapshot.value as Map<dynamic, dynamic>?;

    // skip if empty or null
    if (data == null || data.isEmpty) return;

    // else delete
    for (final Map doc in data.values as Iterable<Map<dynamic, dynamic>>) {
      if (doc.containsKey('invitationId')) {
        deleteById(doc['invitationId']);
      }
    }
  }
}
