import 'package:flutter/material.dart';
import 'package:fly_ui/views/layouts/responsiveView.widget.dart';
import 'package:fly_ui/views/layouts/scaffoldLayout.widget.dart';
import 'package:fly_ui/views/widgets/appBar.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareablePermissions/shareablePermissions.controller.dart';
import 'package:shareable_module/shareablePermissions/widgets/permissionsList.widget.dart';

class ShareablePermissions extends GetView<ShareablePermissionsController> {
  const ShareablePermissions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlyScaffold.padding(
      appBar: FlyAppBar(title: 'Permissions'.tr,),
      child: FlyResponsiveView(
        child: PermissionsList(controller: controller),
      ),
    );
  }
}
