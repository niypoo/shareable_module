import 'package:shareable_module/abstractions/shareable.abstractor.dart';
import 'package:shareable_module/models/invitationHandleStatus.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class ShareableServiceInvitationHandler {

  
  // if user use qr-code/link more then once
  // or if user it before in seconde time use it to redirect to object
  Future<void> isRelationAlreadyExist(String objectId);

  // if invitation is valid use it to create relation between objects
  Future<InvitationHandleStatus> relationCreation({
    required String objectId,
    required String invitationId,
    required String role,
  });

  // define the sharable Instance | object
  Shareable get shareableInstance;

  // sharable ref in firestore
  DocumentReference? shareableFirestoreRef;

  // sharable ref in realtime database
  DatabaseReference? shareableRealtimeDatabaseRef;
}
