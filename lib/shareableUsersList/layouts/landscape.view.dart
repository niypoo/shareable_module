import 'package:flutter/material.dart';
import 'package:fly_ui/modules/searchInput/searchInput.widget.dart';
import 'package:fly_ui/views/layouts/landscapeView.widget.dart';
import 'package:fly_ui/views/widgets/appBar.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareableUsersList/shareableUsersList.controller.dart';
import 'package:shareable_module/shareableUsersList/widgets/CreateNewInvitationButton.widget.dart';
import 'package:shareable_module/shareableUsersList/widgets/shareableUsersList.widget.dart';

class ShareableUsersListLandscapeView
    extends GetView<ShareableUsersListController> {
  const ShareableUsersListLandscapeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlyLandscapeView(
      childA: SingleChildScrollView(
        child: Column(
          children: [
            FlyAppBar(
              title: 'Sharing'.tr,
              titleSpacing: 0.0,
            ),
            FlySearchInput(
              controller: controller,
              placeholder: 'Search'.tr,
            ),
          ],
        ),
      ),
      childB: const FlyLandScapeScroll(
        child: Column(
          children: [
            ShareableUsersListWidget(),
            // Button
            CreateNewInvitationButton(),
          ],
        ),
      ),
    );
  }
}
