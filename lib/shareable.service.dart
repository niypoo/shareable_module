import 'package:app_configuration_service/appInfo.config.dart';
import 'package:bottom_sheet_helper/models/actionSheetOption.model.dart';
import 'package:bottom_sheet_helper/services/actionSheet.helper.dart';
import 'package:bottom_sheet_helper/services/advanceConformationSheet.helper.dart';
import 'package:bottom_sheet_helper/services/conformationSheet.helper.dart';
import 'package:bottom_sheet_helper/services/customBottomSheet.helper.dart';
import 'package:bottom_sheet_helper/services/messageBottomSheet.helper.dart';
import 'package:dynamic_links_helper/dynamicLinks.helper.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:helpers/random.helper.dart';
import 'package:helpers/username.helper.dart';
import 'package:loading_service/loading.service.dart';
import 'package:qr_code_scanner_module/helpers/qrCodeScanner.helper.dart';
import 'package:share_helper/share.helper.dart';
import 'package:shareable_module/abstractions/shareable.abstractor.dart';
import 'package:shareable_module/abstractions/shareableServiceInvitationHandler.abstract.dart';
import 'package:shareable_module/enums/role.enum.dart';
import 'package:shareable_module/helpers/invitation.database.helper.dart';
import 'package:shareable_module/helpers/invitation.firestore.helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shareable_module/models/invitation.model.dart';
import 'package:shareable_module/models/invitationHandleStatus.model.dart';
import 'package:shareable_module/models/shareUser.model.dart';
import 'package:shareable_module/routes/route.dart';
import 'package:shareable_module/widgets/qrcode.widget.dart';
import 'package:snackbar_helper/snackbar.service.dart';
import 'package:unicons/unicons.dart';

class ShareableService extends GetxService {
  // define
  static ShareableService get to => Get.find();

  //define controller helper
  ShareableServiceInvitationHandler invitationHandler;
  final Duration invitationExpireAfter;
  final String shareableDynamicLinkKey;

  // constructor
  ShareableService({
    required this.invitationHandler,
    this.invitationExpireAfter = const Duration(days: 3),
    this.shareableDynamicLinkKey = 'shareable',
  });

  // initiation
  Future<ShareableService> init() async {
    return this;
  }

  // open screen of invitation Qr Code
  Future<void> invitationAsQRCode({
    required String objectId,
    required Role role,
  }) async {
    // Invitation Id
    final String invitationId = RandomHelper.string();

    // store invitation
    await _storeInvitations(
      ShareInvitation(
        endAt: DateTime.now().add(invitationExpireAfter),
        id: invitationId,
        objectId: objectId,
      ),
    );

    // show invitation id as qr-code
    await CustomBottomSheetHelper.show(
      title: 'Sharable.Invitation link title'.tr,
      subTitle:
          "Sharable.Ask from whom wants share this case scans this code by his device's camera."
              .tr,
      child: QRCodeWidget(
        value:
            'objectId=$objectId&invitationId=$invitationId&role=${role.name}',
      ),
    );
  }

  // Generate shareable link
  Future<void> invitationAsLink({
    required String objectId,
    required String invitationCardTitle,
    required String invitationCardMessage,
    required Role role,
  }) async {
    try {
      // Invitation Id
      final String invitationId = RandomHelper.string();

      //! generate share Link
      final String? link = await DynamicLinksHelper.create(
        identifier: AppConfigService.to.bundleId!,
        title: invitationCardTitle,
        description: invitationCardMessage,
        imageUrl: AppConfigService.to.invitationImage,
        path: '/shareable',
        queryParameters: {
          'objectId': objectId,
          'invitationId': invitationId,
        },
        keywords: [AppConfigService.to.appName, 'Shareable'],
        // scheme: 'https',
        // host: AppConfigService.to.deepLinkHost,
        //* deprecated
        // path: '/shareable',
        // uriPrefix: AppConfigService.to.dynamicLink,
        // appStoreIdentifier: AppConfigService.to.appStoreIdentifier.toString(),
        // bundleId: AppConfigService.to.bundleId!,

        // shortLink: false,
      );

      // skip
      if (link == null) return;

      // store invitations on cloud
      await _storeInvitations(
        ShareInvitation(
          endAt: DateTime.now().add(invitationExpireAfter),
          id: invitationId,
          objectId: objectId,
          role: role,
        ),
      );

      // open share dialog
      await ShareHelper.string(link);
    } catch (e, x) {
      print('ERROR $e $x');
    }
  }

  // do shareable qr-code invitation scanner,
  // then handle the invitation.
  Future<void> invitationQRCodeScanner({
    String? pageTitle,
    String? title,
    String? description,
  }) async {
    final String? payload = await QrCodeScannerHelper.show(
      pageTitle: pageTitle,
      title: title,
      description: description,
    );
    if (payload == null) return;
    final Map<String, String> asQuery =
        QrCodeScannerHelper.splitQueryString(payload);

    await handleInvitation(asQuery);
  }

  // handle shareable invitation link ,
  // then handle the invitation.
  Future<void> handleInvitation(Map<String, dynamic> params) async {
    // Define Properties
    final dynamic invitationId = params['invitationId'];
    final dynamic objectId = params['objectId'];
    final dynamic role = params['role'];
    print('handleInvitation (params) $params');

    // define common error to used it in multi places
    final InvitationHandleStatus opsStatus = InvitationHandleStatus(
        title: "Sharable.Ops".tr, message: "Sharable.invitation-error".tr);

    //loading on
    LoadingService.to.on();

    // CHECK INVITATION IS VALID
    // Is Invitation Valid
    final bool isInvitationIsValid = await _isInvitationValid(
      invitationId: invitationId,
      objectId: objectId,
    );
    print('isInvitationIsValid ($isInvitationIsValid) ');
    if (!isInvitationIsValid) {
      return _invitationStatusMessageShow(opsStatus);
    }

    // First Case 1 The user already exist in shareable list
    try {
      //loading off
      LoadingService.to.off();

      return await invitationHandler.isRelationAlreadyExist(objectId);
    }

    // Second Case 2 the user not exist so respond will be permission-denied
    // So I will proceeding to add the user in shareable list
    // ignore: non_constant_identifier_names
    on FirebaseException catch (e) {
      print(' FirebaseException ($e) ');
      // permission-denied is message that I looking for &
      // that mean user not shared already
      // if error null or not = permission-denied return global error
      if (e.code != 'permission-denied') {
        return _invitationStatusMessageShow(opsStatus);
      }

      // relation creation PROCESSING
      final InvitationHandleStatus status =
          await invitationHandler.relationCreation(
        objectId: objectId,
        invitationId: invitationId,
        role: role,
      );

      //loading off
      LoadingService.to.off();

      // show status of out-side handler function
      return _invitationStatusMessageShow(status);
    }
  }

  // Store every invitation link details in fireStore & realtime db
  // to compare any invitation accepted details with this invitation
  Future<void> _storeInvitations(ShareInvitation invitation) async {
    // Crate Invitation in firestore / realtime database
    if (invitationHandler.shareableRealtimeDatabaseRef != null) {
      await InvitationDatabaseHelper.create(invitation);
    }

    if (invitationHandler.shareableFirestoreRef != null) {
      await InvitationFirestoreHelper.create(invitation);
    }
  }

  // only for show message of invitation handel status
  Future<void> _invitationStatusMessageShow(
    InvitationHandleStatus status,
  ) async {
    LoadingService.to.off();
    return MessageBottomSheetHelper.show(
      title: status.title,
      body: status.message,
      icon: status.icon ?? UniconsLine.exclamation_triangle,
    );
  }

  // Check if the invitation is valid
  Future<bool> _isInvitationValid({
    String? invitationId,
    String? objectId,
  }) async {
    try {
      // Check if all important properties are exist
      if (invitationId == null || objectId == null) {
        return false;
      }
print('_isInvitationValid (1) ');
      // properties
      final int now = DateTime.now().millisecondsSinceEpoch;
      //Check invitation is valid in FIRESTORE
      // get Invitation from firestore
      DocumentSnapshot<Object?> invitationFirestoreDoc =
          await InvitationFirestoreHelper.getById(invitationId);

      // convert doc to map
      Map<dynamic, dynamic>? invitationFireStoreData =
          invitationFirestoreDoc.data() as Map<dynamic, dynamic>?;

      // check if invite is invalid
      final bool firestoreInvitationInvalid = !invitationFirestoreDoc.exists ||
          invitationFireStoreData!['objectId'] != objectId ||
          now > invitationFireStoreData['endAt'];
print('_isInvitationValid (2) $firestoreInvitationInvalid ');
      // If invitation invalid
      if (firestoreInvitationInvalid) return false;

      //Check invitation is valid in REALTIME
      // get Invitation from firestore
      final DatabaseEvent event =
          await InvitationDatabaseHelper.getById(invitationId);

      // get snapshot
      DataSnapshot invitationDatabaseDoc = event.snapshot;

      // convert doc to map
      final Map<dynamic, dynamic>? invitationDatabaseData =
          invitationDatabaseDoc.value as Map<dynamic, dynamic>?;

      // check if invite is invalid
      final bool databaseInvitationInvalid =
          invitationDatabaseData!['objectId'] != objectId ||
              now > invitationDatabaseData['endAt'];
print('_isInvitationValid (3) $databaseInvitationInvalid ');
      // If invitation invalid
      if (databaseInvitationInvalid) return false;

      // IS PASS MEAN VALID
      return true;
    }
    // CATCH Error MEAN FALSE
    catch (e) {
      print('_isInvitationValid (4) $e ');
      return false;
    }
  }

  //Share a regular invitation
  Future<void> createNewInvitation(Shareable shareable) async {
    // ask user
    final dynamic shareMethods = await ActionSheetHelper.show(
      title: 'Sharable.Send invitations'.tr,
      subTitle:
          "Sharable.Any invite is valid 24 hours only, anyone who has this invitation can join and manage the data with you."
              .tr,
      options: [
        ActionSheetOption(
          title: 'Sharable.Invitation link'.tr,
          subtitle:
              'Sharable.Send an invitation link clickable to any person via the social media or email.'
                  .tr,
          value: 'Link',
          leading: const Icon(UniconsLine.link),
        ),
        ActionSheetOption(
          title: 'Sharable.QR Code'.tr,
          subtitle:
              "Sharable.Ask from whom wants share this case scans this code by his device's camera."
                  .tr,
          value: 'QRCode',
          leading: const Icon(UniconsLine.qrcode_scan),
        ),
      ],
    );

    // if not skip
    if (shareMethods == null) return;

    // ask user
    final Role? role = await ActionSheetHelper.show(
      title: 'Sharable.Roles'.tr,
      subTitle: "Sharable.Choose the role of share user.".tr,
      options: Role.values
          .map(
            (role) => ActionSheetOption(
              title: 'Sharable.${role.name}'.tr,
              subtitle: 'Sharable.${role.name} role hint'.tr.tr,
              value: role,
            ),
          )
          .toList(),
    );

    // if not skip
    if (role == null) return;

    // Loading
    LoadingService.to.on();
    print('shareMethods $shareMethods');
    if (shareMethods == 'Link') {
      ShareableService.to.invitationAsLink(
        objectId: shareable.id,
        invitationCardTitle: "Sharable.Invitation link title",
        invitationCardMessage: 'Sharable.Invitation link body',
        role: role,
      );
    } else if (shareMethods == 'QRCode') {
      ShareableService.to
          .invitationAsQRCode(objectId: shareable.id, role: role);
    }

    // Loading
    LoadingService.to.off();
  }

  // open permission
  Future<void> chnageRole(ShareUser shareUser) async {
    await Get.toNamed(
      ShareableRoutesNames.shareableUserRole,
      arguments: shareUser,
    );
  }

  // REMOVE USER SHARING
  Future<void> remove({
    required Shareable object,
    required ShareUser removeUser,
  }) async {
    // confirm
    final bool? confirm = await ConformationSheetHelper.show(
      title: 'Sharable.Confirmation !'.tr,
      subTitle: 'Sharable.Do you want remove share user ?'.trParams(
        {
          '_ame': removeUser.getDisplayName,
        },
      ),
    ) as bool?;

    // CONFIRMATION
    if (confirm == null || !confirm) return;

    // LOADING
    LoadingService.to.on();

    //delete Sharing user Medical Case
    await object.removeFromShareableUsers(removeUser);

    // LOADING
    LoadingService.to.off();

    // show Snack bar
    SnackbarHelper.show(
      body: 'Sharable.user sharing has been deleted'.trParams(
        {
          '_ame': UsernameHelper.username(removeUser.displayName),
        },
      ),
    );
  }

  // remove Medical Case
  Future<void> leave({
    required Shareable object,
    required ShareUser removeUser,
  }) async {
    // confirm user first
    final bool? confirm = await AdvanceConformationSheetHelper.show(
      title: 'Sharable.Confirmation !'.tr,
      subTitle: 'Sharable.Do you want leave diabetic ?'.trParams(
        {
          '_ame': object.displayName,
        },
      ),
      icon: UniconsLine.exit,
    ) as bool?;

    // if not confirm => skip
    if (confirm == null || !confirm) return;

    // loading
    LoadingService.to.on();

    // TODOO:
    // cancel all notifications
    // MedicalCaseRemindersService().cancelAllReminders(diabeticCase);

    // Call Delete function from server
    //delete Sharing user Medical Case
    await object.removeFromShareableUsers(removeUser);

    // loading
    LoadingService.to.off();

    // show snack bar
    SnackbarHelper.show(
      body: 'Sharable.You have leaved.'.tr,
      icon: UniconsLine.times,
    );
  }

  void shareableInviteRouteCatch(
      {required String path, Map<String, dynamic>? params}) async {
    // handle SHARABLE function
    if (path == '/shareable' && params != null) {
      await handleInvitation(params);
    }
  }

  void notAutorizedMessage() => SnackbarHelper.warning(
        title: 'Sharable.Not Authorized'.tr,
        body:
            "Sharable.You don't have permissions to make this actions, ask owner to change your role."
                .tr,
        icon: UniconsLine.lock,
      );
}
