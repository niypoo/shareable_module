import 'package:flutter/material.dart';
import 'package:fly_ui/extensions/responsive.extension.dart';
import 'package:fly_ui/views/widgets/buttons/elevatedButton.widget.dart';
import 'package:fly_ui/views/widgets/listTile/tileRadio.widget.dart';
import 'package:fly_ui/views/widgets/multiStepPageView/widgets/multiStepHint.widget.dart';
import 'package:fly_ui/views/widgets/multiStepPageView/widgets/multiStepTitle.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareablePermissions/shareableUserRole.controller.dart';

class RolesListWidget extends GetView<ShareableUserRoleController> {
  const RolesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title
        FlyMultiStepTitle(title: 'Sharable.Change user role.'.tr),
        SizedBox(height: 8.sp),
        // HINT
        FlyMultiStepHint(
          hint:
              'Sharable.Choose the user role and specify the permissions it has.'
                  .tr,
        ),
        SizedBox(height: 10.sp),

        GetBuilder<ShareableUserRoleController>(
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
