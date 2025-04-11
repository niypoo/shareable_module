import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shareable_module/abstractions/shareable.abstractor.dart';
import 'package:shareable_module/enums/role.enum.dart';
import 'package:shareable_module/models/shareUser.model.dart';
import 'package:shareable_module/shareable.service.dart';
import 'package:snackbar_helper/snackbar.service.dart';
import 'package:unicons/unicons.dart';

class ShareableUserRoleController extends GetxController {
  static ShareableUserRoleController get to => Get.find();

  final ShareUser shareUser = Get.arguments;

  // properties
  final Shareable object =
      ShareableService.to.invitationHandler.shareableInstance;

  // properties
  List<Role> roles = Role.values;
  Role userRole = Role.viewer;

  @override
  void onInit() {
    userRole = shareUser.role;
    super.onInit();
  }



  // ON OPTIONS CHANGES
  onRoleChange(Role role) {
    userRole = role;
    update();
  }

  // STOR OPTIONS VALUES IN SERVER
  Future<void> save() async {
    try {
      print('object ${object.id}');
      print('shareUser ${shareUser.id}');
      print('role $userRole');
      // change current options in sharing map
      await object.updateShareableUser(
        {
          'role': userRole.name,
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
