import 'package:flutter/material.dart';
import 'package:fly_ui/views/layouts/responsiveView.widget.dart';
import 'package:fly_ui/views/layouts/scaffoldLayout.widget.dart';
import 'package:fly_ui/views/widgets/appBar.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareableUserRole/shareableUserRole.controller.dart';
import 'package:shareable_module/shareableUserRole/widgets/rolesList.widget.dart';

class ShareableUserRoleView extends GetView<ShareableUserRoleController> {
  const ShareableUserRoleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlyScaffold.padding(
      appBar: FlyAppBar(
        title: 'Sharable.User Role'.tr,
      ),
      child: const FlyResponsiveView(
        child: RolesListWidget(),
      ),
    );
  }
}
