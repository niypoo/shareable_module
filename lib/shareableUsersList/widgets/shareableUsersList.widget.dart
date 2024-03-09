import 'package:flutter/material.dart';
import 'package:fly_ui/views/widgets/images/image.widget.dart';
import 'package:fly_ui/views/widgets/listTile/tile.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareableUsersList/shareableUsersList.controller.dart';
import 'package:unicons/unicons.dart';

class ShareableUsersListWidget extends GetView<ShareableUsersListController> {
  const ShareableUsersListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShareableUsersListController>(
      builder: (controller) {
        return Column(
          children: controller.sharingUsers
              .map(
                (user) => FlyListTile(
                  leading: FlyImage(
                    height: 100,
                    width: 50,
                    url: user.photoUrl,
                    placeholder: 'assets/images/avatars/0.png',
                  ),
                  title: user.getDisplayName,
                  subtitle: controller.isOwner(user.id)
                      ? 'Sharable.owner'.tr
                      : 'Sharable.${user.role.name}'.tr,
                  value: !controller.isOwner(user.id) &&
                          controller.isCurrentUserOwner
                      ? IconButton(
                          icon: const Icon(UniconsLine.ellipsis_v),
                          color: Get.theme.primaryColor,
                          onPressed: () => controller.onMoreOptionTap(user),
                        )
                      : const SizedBox.shrink(),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
