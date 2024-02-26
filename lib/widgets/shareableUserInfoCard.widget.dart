import 'package:flutter/material.dart';
import 'package:fly_ui/extensions/responsive.extension.dart';
import 'package:fly_ui/views/widgets/containers/container.widget.dart';
import 'package:fly_ui/views/widgets/images/image.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareableUsersList/shareableUsersList.controller.dart';

class ShareableUserInfoCard extends GetView<ShareableUsersListController> {
  const ShareableUserInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.currentUserFromShareableList == null) {
      return const SizedBox.shrink();
    } else {
      return Column(
        children: [
          Divider(
            color: Get.theme.scaffoldBackgroundColor.withOpacity(0.5),
          ),
          FlyContainer(
            margin: const EdgeInsets.all(0),
            padding: EdgeInsets.all(8.sp),
            color: Get.theme.scaffoldBackgroundColor,
            child: Row(
              children: [
                FlyImage(
                  url: controller.currentUserFromShareableList!.photoUrl,
                  width: 40.sp,
                  height: 55.sp,
                ),
                SizedBox(width: 10.sp),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.currentUserFromShareableList!.getDisplayName,
                      style: Get.textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Sharable.${controller.currentUserFromShareableList!.role.name}'
                          .tr,
                      style: Get.textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5.sp),
                    Text(
                      'Sharable.${controller.currentUserFromShareableList!.role.name} role hint'
                          .tr,
                      style: Get.textTheme.labelSmall!.copyWith(fontSize: 7.sp),
                    ),
                  ],
                ))
              ],
            ),
          ),
          Divider(
            color: Get.theme.scaffoldBackgroundColor.withOpacity(0.5),
          ),
        ],
      );
    }
  }
}
