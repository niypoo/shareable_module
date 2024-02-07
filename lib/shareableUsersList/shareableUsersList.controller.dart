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
  // final BaseUser _user = FirebaseAuthenticationService.to.user.value!;

  // properties
  final Shareable object = Get.arguments ?? [];

  List<ShareUser> sharingUsers = [];

  @override
  void onInit() {
    sharingUsers = object.shareableUsers();
    super.onInit();
  }

  bool isOwner(String id) => object.uid == id;

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
    sharingUsers = object.shareableUsers();
    searchTextController.clear();
    update();
  }

  Future<void> toPermission(ShareUser shareUser) async =>
      await Get.toNamed(ShareableRoutesNames.shareablePermission,
          arguments: shareUser);
}
