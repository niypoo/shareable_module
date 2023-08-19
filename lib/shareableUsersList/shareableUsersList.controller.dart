import 'package:firebase_authentication_service/firebaseAuthentication.service.dart';
import 'package:firebase_authentication_service/models/baseUser.model.dart';
import 'package:get/get.dart';
import 'package:shareable_module/abstractions/hasShareable.abstractor.dart';

class ShareableUsersListController extends GetxController {
  // static
  static ShareableUsersListController get to => Get.find();

  // current user
  final BaseUser _user = FirebaseAuthenticationService.to.user.value!;

  // properties
  final Shareable object = Get.arguments ?? [];

  final RxList<BaseUser> shareableUsers = RxList<BaseUser>([]);

  @override
  void onInit() {
    shareableUsers.value = object.shareableUsersWithoutOwner();
    super.onInit();
  }

  bool isOwner(String uid) => _user.id == uid;
}
