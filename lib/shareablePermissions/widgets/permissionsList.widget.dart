import 'package:flutter/material.dart';
import 'package:fly_ui/extensions/responsive.extension.dart';
import 'package:fly_ui/views/widgets/buttons/elevatedButton.widget.dart';
import 'package:fly_ui/views/widgets/switchOption.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareablePermissions/shareablePermissions.controller.dart';

class PermissionsList extends StatelessWidget {
  const PermissionsList({
    super.key,
    required this.controller,
  });

  final ShareablePermissionsController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...controller.shareablePermissions
            .map(
              (e) => FlySwitchOption(
                value: e.defaultValue,
                title: e.name.tr,
                subtitle: e.description.tr,
                onChange: (bool v) => controller.onPermissionChange(v, true),
              ),
            )
            .toList(),
        SizedBox(height: 30.sp),
        FlyElevatedButton.primary(
          title: 'Save'.tr,
          onPressed: controller.save,
        ),
        FlyElevatedButton.close(
          title: 'Close'.tr,
          onPressed: controller.back,
        ),
      ],
    );
  }
}
