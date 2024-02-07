import 'package:get/get.dart';
import 'package:shareable_module/shareablePermissions/shareablePermissions.controller.dart';

class ShareablePermissionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareablePermissionsController>(() => ShareablePermissionsController());
  }
}
