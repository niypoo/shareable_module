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
      ShareableService.to.invitationHandler.shareablePermissions;

  Map<String, dynamic> permissions = {};

  @override
  void onInit() {
    // assign exist permssion or default
    if (shareUser.permissions == null) {
      for (var permission in shareablePermissions) {
        permissions[permission.key] = permission.defaultValue;
      }
    } else {
      permissions = shareUser.permissions!;
    }

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
  onPermissionChange(bool value, String key) {
    print('key $key , $value');
    permissions[key] = value;
    update();
  }

  // STOR OPTIONS VALUES IN SERVER
  Future<void> save() async {
    try {
      print('object ${object.id}');
      print('shareUser ${shareUser.id}');
      print('permissions $permissions');
      // change current options in sharing map
      await object.updateUserPermissions(
        permissions,
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
