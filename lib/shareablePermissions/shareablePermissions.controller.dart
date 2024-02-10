import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shareable_module/abstractions/hasShareable.abstractor.dart';
import 'package:shareable_module/models/sharePermission.model.dart';
import 'package:shareable_module/models/shareUser.model.dart';
import 'package:shareable_module/shareable.service.dart';
import 'package:snackbar_helper/snackbar.service.dart';
import 'package:unicons/unicons.dart';

class ShareablePermissionsController extends GetxController {
  static ShareablePermissionsController get to => Get.find();

  final ShareUser shareUser = Get.arguments;

  // properties
  final Shareable object =
      ShareableService.to.invitationHandler.getShareableObject();

  // properties
  List<ShareablePermission> shareablePermissions =
      ShareableService.to.invitationHandler.getShareablePermissions;

  // final RxBool read = false.obs;
  // final RxBool write = false.obs;
  // final RxBool edit = false.obs;
  // final RxBool remove = false.obs;
  // final RxBool share = false.obs;

  @override
  void onInit() {
    // read.value = shareUser.isAllow('read', true);
    // write.value = shareUser.isAllow('write', true);
    // edit.value = shareUser.isAllow('edit');
    // remove.value = shareUser.isAllow('remove');
    // share.value = shareUser.isAllow('share');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // ON OPTIONS CHANGES
  onPermissionChange(bool value, bool permission) => permission = value;

  // STOR OPTIONS VALUES IN SERVER
  Future<void> save() async {
    try {
      // change current options in sharing map
      await object.updateShareablePermssions(
        {
          'read': true,
          'write': true,
          'edit': true,
          'remove': true,
          'share': true,
        },
        shareUser,
      );

      // back
      back();

      //show snack
      SnackbarHelper.show(
        body: "Data has been updated.".tr,
        icon: UniconsLine.user_check,
        color: Colors.green[400],
      );
    } catch (e) {
      //show snack
      SnackbarHelper.show(
        body: "Something went wrong".tr,
        icon: UniconsLine.exclamation_triangle,
        color: Colors.red[400],
      );
    }
  }

  // BACK
  void back() => Get.back();
}
