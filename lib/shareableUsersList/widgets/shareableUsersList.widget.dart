import 'package:flutter/material.dart';
import 'package:fly_ui/views/widgets/buttons/elevatedButton.widget.dart';
import 'package:fly_ui/views/widgets/images/image.widget.dart';
import 'package:fly_ui/views/widgets/listTile/tile.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareableUsersList/shareableUsersList.controller.dart';
import 'package:shareable_module/shareable.service.dart';
import 'package:unicons/unicons.dart';

class ShareableUsersListWidget extends GetView<ShareableUsersListController> {
  const ShareableUsersListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Body
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: controller.shareableUsers
                  .map(
                    (user) => FlyListTile(
                      leading: FlyImage(
                        height: 40,
                        width: 40,
                        url: user.photoUrl,
                        placeholder: 'assets/images/avatars/0.png',
                      ),
                      title: user.getDisplayName,
                      value: controller.isOwner(user.id)
                          ? IconButton(
                              icon: const Icon(UniconsLine.trash_alt),
                              color: Get.theme.primaryColor,
                              onPressed: () {})
                          : const SizedBox.shrink(),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),

        // Button
        FlyElevatedButton.primary(
          onPressed: () =>
              ShareableService.to.createNewInvitation(controller.object),
          title: "Family Invitation".tr,
        ),
      ],
    );
  }
}
