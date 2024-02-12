import 'package:get/get.dart';
import 'package:shareable_module/shareableUserRole/shareableUserRole.controller.dart';

class ShareableUserRoleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareableUserRoleController>(() => ShareableUserRoleController());
  }
}
