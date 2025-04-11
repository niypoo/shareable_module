import 'package:fly_ui/transitions/flyRouteTransition.dart';
import 'package:get/get.dart';
import 'package:shareable_module/routes/route.dart';
import 'package:shareable_module/shareableUserRole/shareableUserRole.binding.dart';
import 'package:shareable_module/shareableUserRole/shareableUserRole.view.dart';
import 'package:shareable_module/shareableUsersList/shareableUsersList.binding.dart';
import 'package:shareable_module/shareableUsersList/shareableUsersList.view.dart';

class ShareablePages {
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: ShareableRoutesNames.shareableUserList,
      page: () => const ShareableUsersListView(),
      binding: ShareableUsersListBinding(),
      customTransition: FlySharedAxisTransition(),
    ),

        GetPage(
      name: ShareableRoutesNames.shareableUserRole,
      page: () => const ShareableUserRoleView(),
      binding: ShareableUserRoleBinding(),
      customTransition: FlySharedAxisTransition(),
    ),
  ];
}
