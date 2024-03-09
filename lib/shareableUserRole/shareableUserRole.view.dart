import 'package:flutter/material.dart';
import 'package:fly_ui/views/layouts/responsiveView.widget.dart';
import 'package:fly_ui/views/layouts/scaffoldLayout.widget.dart';
import 'package:fly_ui/views/widgets/appBar.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareableUserRole/layouts/landscape.view.dart';
import 'package:shareable_module/shareableUserRole/layouts/portrait.view.dart';
import 'package:shareable_module/shareableUserRole/shareableUserRole.controller.dart';

class ShareableUserRoleView extends GetView<ShareableUserRoleController> {
  const ShareableUserRoleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlyScaffold.padding(
      appBar: context.isLandscape
          ? null
          : FlyAppBar(title: 'Sharable.User Role'.tr),
      child: const FlyLayoutResponsiveView(
        portrait: ShareableUserRolePortraitView(),
        landscape: ShareableUserRoleLandscapeView(),
      ),
    );
  }
}
