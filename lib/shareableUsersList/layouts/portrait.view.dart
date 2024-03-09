import 'package:flutter/material.dart';
import 'package:fly_ui/extensions/responsive.extension.dart';
import 'package:fly_ui/modules/searchInput/searchInput.widget.dart';
import 'package:fly_ui/views/layouts/nestedScrollView.widget.dart';
import 'package:fly_ui/views/widgets/appBar.widget.dart';
import 'package:fly_ui/views/widgets/sliverContainer.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareableUsersList/shareableUsersList.controller.dart';
import 'package:shareable_module/shareableUsersList/widgets/CreateNewInvitationButton.widget.dart';
import 'package:shareable_module/shareableUsersList/widgets/shareableUsersList.widget.dart';

class ShareableUsersListPortraitView
    extends GetView<ShareableUsersListController> {
  const ShareableUsersListPortraitView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlyNestedScrollView(
      // BODY
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ShareableUsersListWidget(),
            // Button
            CreateNewInvitationButton(),
          ],
        ),
      ),
      // APP BAR
      headerSliverBuilder: [
        SliverPersistentHeader(
          delegate: FlySliverContainer(
            initMaxExtent: 45.sp,
            initMinExtent: 45.sp,
            child: (bool isCollapse, double shrinkOffset) => FlyAppBar(
              title: 'Sharing'.tr,
              titleSpacing: 0.0,
            ),
          ),
          pinned: false,
          floating: false,
        ),
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: FlySliverContainer(
            initMaxExtent: 45.sp,
            initMinExtent: 45.sp,
            child: (bool isCollapse, double shrinkOffset) => Container(
              height: 45.sp,
              color: Get.theme.scaffoldBackgroundColor,
              child: FlySearchInput(
                controller: controller,
                placeholder: 'Search'.tr,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
