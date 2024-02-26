import 'package:bottom_sheet_helper/models/actionSheetOption.model.dart';
import 'package:bottom_sheet_helper/services/actionSheet.helper.dart';
import 'package:firebase_authentication_service/firebaseAuthentication.service.dart';
import 'package:firebase_authentication_service/models/baseUser.model.dart';
import 'package:flutter/widgets.dart';
import 'package:fly_ui/modules/searchInput/abstracts/hasSearchInput.abstract.dart';
import 'package:get/get.dart';
import 'package:shareable_module/abstractions/hasShareable.abstractor.dart';
import 'package:shareable_module/models/shareUser.model.dart';
import 'package:shareable_module/shareable.service.dart';
import 'package:unicons/unicons.dart';

class ShareableUsersListController extends GetxController
    implements HasSearchInput {
  // static
  static ShareableUsersListController get to => Get.find();

  // // current user
  final BaseUser _user = FirebaseAuthenticationService.to.user.value!;

  // properties
  late Shareable object =
      ShareableService.to.invitationHandler.shareableInstance;

  // get share users list
  List<ShareUser> sharingUsers = [];

  bool isCurrentUserOwner = false;

  @override
  void onInit() {
    getShareUsersList();
    isCurrentUserOwner = object.uid == _user.id;

    // Handle Search input actions
    searchTextController.addListener(
      () {
        // Value os search input
        searchIsEmpty.value = searchTextController.text.trim().isEmpty;
      },
    );

    // listen to search input focus
    searchFocusNode.addListener(() {});

    super.onInit();
  }

  bool isOwner(String uid) => object.uid == uid;

  // search text controller
  @override
  TextEditingController searchTextController = TextEditingController();

  // search input is empty
  @override
  RxBool searchIsEmpty = true.obs;

  @override
  FocusNode searchFocusNode = FocusNode();

  @override
  void onFieldSubmitted(String value) {
    sharingUsers = sharingUsers
        .where((user) =>
            user.getDisplayName.toLowerCase().contains(value.toLowerCase()))
        .toList();
    update();
  }

  @override
  void onSearchFieldClear() {
    searchTextController.clear();
    getShareUsersList();
  }

  Future<void> onMoreOptionTap(ShareUser shareUser) async {
    final String? payload = await ActionSheetHelper.show(options: [
      ActionSheetOption(
        title: 'Sharable.Remove'.tr,
        value: 'Remove',
        subtitle: 'Sharable.Remove this user from share list.'.tr,
        leading: const Icon(UniconsLine.trash),
      ),
      ActionSheetOption(
        title: 'Sharable.Roles'.tr,
        value: 'Roles',
        subtitle: 'Sharable.Manage this user role.'.tr,
        leading: const Icon(UniconsLine.setting),
      ),
    ]);

    if (payload == null) return;

    if (payload == 'Roles') {
      ShareableService.to.chnageRole(shareUser);
    } else if (payload == 'Remove') {
      ShareableService.to.remove(object: object, removeUser: shareUser);
    }

    // update data
    getShareUsersList();
  }

  // get share users list and update
  getShareUsersList() {
    sharingUsers = ShareableService.to.invitationHandler.shareableInstance
        .shareableUsers([]);
    update();
  }
}
