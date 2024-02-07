import 'package:firebase_authentication_service/firebaseAuthentication.service.dart';
import 'package:firebase_authentication_service/models/baseUser.model.dart';
import 'package:flutter/widgets.dart';
import 'package:fly_ui/modules/searchInput/abstracts/hasSearchInput.abstract.dart';
import 'package:get/get.dart';
import 'package:shareable_module/abstractions/hasShareable.abstractor.dart';
import 'package:shareable_module/models/shareUser.model.dart';
import 'package:shareable_module/routes/route.dart';
import 'package:shareable_module/shareable.service.dart';

class ShareableUsersListController extends GetxController
    implements HasSearchInput {
  // static
  static ShareableUsersListController get to => Get.find();

  // // current user
  final BaseUser _user = FirebaseAuthenticationService.to.user.value!;

  // properties
  final Shareable object =
      ShareableService.to.invitationHandler.getShareableObject();

  // get share users list
  List<ShareUser> sharingUsers = [];

  bool isCurrentUserOwner = false;

  @override
  void onInit() {
    isCurrentUserOwner = object.uid == _user.id;
    getShareUsersList();

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
        .where((user) => user.getDisplayName.contains(value))
        .toList();

    print('value $value');
    print('sharingUsers ${sharingUsers.length}');
    update();
  }

  @override
  void onSearchFieldClear() {
    searchTextController.clear();
    getShareUsersList();
  }

  // open permission
  Future<void> toPermission(ShareUser shareUser) async {
    await Get.toNamed(
      ShareableRoutesNames.shareablePermission,
      arguments: shareUser,
    );
  }

  // get share users list and update
  getShareUsersList() {
    sharingUsers = ShareableService.to.invitationHandler.getShareUsers();
    update();
  }
}
