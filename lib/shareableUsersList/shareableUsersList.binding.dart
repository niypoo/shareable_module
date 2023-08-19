import 'package:get/get.dart';
import 'package:shareable_module/shareableUsersList/shareableUsersList.controller.dart';

class ShareableUsersListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareableUsersListController>(
        () => ShareableUsersListController());
  }
}
