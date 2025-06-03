import 'package:flutter/material.dart';
import 'package:fly_ui/extensions/responsive.extension.dart';
import 'package:fly_ui/views/widgets/images/image.widget.dart';
import 'package:fly_ui/views/widgets/listTile/listTile.widget.dart';
import 'package:fly_ui/views/widgets/pageMessage.widget.dart';
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
      autoRemove: false,
      builder: (controller) {
        if (controller.sharingUsers.isEmpty &&
            controller.searchTextController.text.isEmpty) {
          return FlyContainerMessage(
            icon: UniconsLine.user_exclamation,
            title: "Sharable.Empty list!".trParams(
              {
                '_nm': controller.searchTextController.text,
              },
            ),
            body: "Sharable.Seems you manage this alone.".tr,
          );
        } else if (controller.sharingUsers.isEmpty &&
            controller.searchTextController.text.isNotEmpty) {
          return FlyContainerMessage(
            icon: UniconsLine.search,
            title: "Sharable.No result!".trParams(
              {
                '_nm': controller.searchTextController.text,
              },
            ),
            body: "Sharable.Try searching with a different name.".tr,
          );
        } else {
          return Column(
            children: controller.sharingUsers
                .map(
                  (user) => FlyListTile(
                    outline: true,
                    leading: FlyImage(
                      height: 40.sp,
                      width: 35.sp,
                      url: user.photoUrl,
                    ),
                    title: user.getDisplayName,
                    value: controller.isOwner(user.id)
                        ? 'Sharable.owner'.tr
                        : 'Sharable.${user.role.name}'.tr,
                    trailing: !controller.isOwner(user.id) &&
                            controller.isCurrentUserOwner
                        ? IconButton(
                            icon: const Icon(UniconsLine.ellipsis_v),
                            onPressed: () => controller.onMoreOptionTap(user),
                          )
                        : null,
                  ),
                )
                .toList(),
          );
        }
      },
    );
  }
}
