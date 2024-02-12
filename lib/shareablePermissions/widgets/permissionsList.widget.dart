import 'package:flutter/material.dart';
import 'package:fly_ui/extensions/responsive.extension.dart';
import 'package:fly_ui/views/widgets/buttons/elevatedButton.widget.dart';
import 'package:fly_ui/views/widgets/listTile/tileRadio.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareablePermissions/shareablePermissions.controller.dart';

class PermissionsList extends GetView<ShareablePermissionsController> {
  const PermissionsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<ShareablePermissionsController>(
          builder: (controller) => Column(
            children: controller.roles
                .map(
                  (e) => FlyRadioListTile(
                    value: e.name,
                    title: e.name.tr,
                    valueGroup: controller.userRole.name,
                    hint: '${e.name} role hint'.tr,
                    onTap: () => controller.onRoleChange(e),
                  ),
                )
                .toList(),
          ),
        ),
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
