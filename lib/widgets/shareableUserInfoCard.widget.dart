import 'package:flutter/material.dart';
import 'package:fly_ui/extensions/responsive.extension.dart';
import 'package:fly_ui/views/widgets/containers/container.widget.dart';
import 'package:fly_ui/views/widgets/images/image.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/models/shareUser.model.dart';

class ShareableUserInfoCard extends StatelessWidget {
  const ShareableUserInfoCard({
    super.key,
    required this.shareUser,
  });

  final ShareUser shareUser;
  @override
  Widget build(BuildContext context) {
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
                url: shareUser.photoUrl,
                width: 40.sp,
                height: 55.sp,
              ),
              SizedBox(width: 10.sp),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shareUser.getDisplayName,
                    style: Get.textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Sharable.${shareUser.role.name}'.tr,
                    style: Get.textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.sp),
                  Text(
                    'Sharable.${shareUser.role.name} role hint'.tr,
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
