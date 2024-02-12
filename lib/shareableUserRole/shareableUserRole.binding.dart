import 'package:get/get.dart';
import 'package:shareable_module/shareablePermissions/shareablePermissions.controller.dart';

class ShareableUserRoleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareableUserRoleController>(() => ShareableUserRoleController());
  }
}
