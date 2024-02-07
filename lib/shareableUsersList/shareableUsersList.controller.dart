import 'package:firebase_authentication_service/firebaseAuthentication.service.dart';
import 'package:firebase_authentication_service/models/baseUser.model.dart';
import 'package:flutter/widgets.dart';
import 'package:fly_ui/modules/searchInput/abstracts/hasSearchInput.abstract.dart';
import 'package:get/get.dart';
import 'package:shareable_module/abstractions/hasShareable.abstractor.dart';
import 'package:shareable_module/models/shareUser.model.dart';
import 'package:shareable_module/routes/route.dart';

class ShareableUsersListController extends GetxController
    implements HasSearchInput {
  // static
  static ShareableUsersListController get to => Get.find();

  // // current user
  final BaseUser _user = FirebaseAuthenticationService.to.user.value!;

  // properties
  Shareable? object;

  // properties
  final Rx<dynamic> arguments = Get.arguments ?? [];

  List<ShareUser> sharingUsers = [];

  bool isCurrentUserOwner = false;

  @override
  void onInit() {
    arguments.listen((p0) {
      object = p0!;
      update();
    });

    isCurrentUserOwner = object!.uid == _user.id;
    sharingUsers = object!.shareableUsers();
    print('isCurrentUserOwner $isCurrentUserOwner');
    print('_user ${_user.id}');
    print('object ${object!.id} ~ ${object!.displayName} ~ ${object!.uid}');
    super.onInit();
  }

  bool isOwner(String uid) => object!.uid == uid;

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
        .where((element) => element.getDisplayName == value)
        .toList();
    update();
  }

  @override
  void onSearchFieldClear() {
    sharingUsers = object!.shareableUsers();
    searchTextController.clear();
    update();
  }

  Future<void> toPermission(ShareUser shareUser) async =>
      await Get.toNamed(ShareableRoutesNames.shareablePermission,
          arguments: shareUser);
}
