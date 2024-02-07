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
        Obx(() {
          return FlySwitchOption(
            value: controller.read.isTrue,
            title: 'Read'.tr,
            subtitle:
                'Read all diabetic data such as glucose and insulin etc. logs'
                    .tr,
            onChange: (bool v) =>
                controller.onPermissionChange(v, controller.read),
          );
        }),
        Obx(() {
          return FlySwitchOption(
            value: controller.write.isTrue,
            title: 'Write'.tr,
            subtitle:
                'Write any data in diabetic such as glucose level and insulin dose'
                    .tr,
            onChange: (bool v) =>
                controller.onPermissionChange(v, controller.write),
          );
        }),
        Obx(() {
          return FlySwitchOption(
            value: controller.edit.isTrue,
            title: 'Update'.tr,
            subtitle:
                'Update any data in diabetic such as glucose level and insulin dose'
                    .tr,
            onChange: (bool v) =>
                controller.onPermissionChange(v, controller.edit),
          );
        }),
        Obx(() {
          return FlySwitchOption(
            value: controller.remove.isTrue,
            title: 'Remove'.tr,
            subtitle:
                'remove any data in diabetic such as glucose level and insulin dose'
                    .tr,
            onChange: (bool v) =>
                controller.onPermissionChange(v, controller.remove),
          );
        }),
        Obx(() {
          return FlySwitchOption(
            value: controller.share.isTrue,
            title: 'Share'.tr,
            subtitle: 'can share other with current diabetic'.tr,
            onChange: (bool v) =>
                controller.onPermissionChange(v, controller.share),
          );
        }),



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
