import 'package:flutter/material.dart';
import 'package:fly_ui/extensions/responsive.extension.dart';
import 'package:fly_ui/views/widgets/buttons/elevatedButton.widget.dart';
import 'package:fly_ui/views/widgets/listTile/tileRadio.widget.dart';
import 'package:fly_ui/views/widgets/stepper/widgets/stepperHint.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareableUserRole/shareableUserRole.controller.dart';

class RolesListWidget extends GetView<ShareableUserRoleController> {
  const RolesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HINT
        FlyStepperHint(
          subHint:
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
                    title: 'Sharable.${e.name}'.tr,
                    selectedValue: controller.userRole.name,
                    subtitle: 'Sharable.${e.name} role hint'.tr,
                    onChanged: (_) => controller.onRoleChange(e),
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
