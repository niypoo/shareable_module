import 'package:flutter/material.dart';
import 'package:fly_ui/extensions/responsive.extension.dart';
import 'package:fly_ui/views/layouts/nestedScrollView.widget.dart';
import 'package:fly_ui/views/widgets/appBar.widget.dart';
import 'package:fly_ui/views/widgets/sliverContainer.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareableUsersList/widgets/shareableUsersList.widget.dart';

class PortraitView extends StatelessWidget {
  const PortraitView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlyNestedScrollView(
      // BODY
      body: const ShareableUsersListWidget(),
      // APP BAR
      headerSliverBuilder: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: FlySliverContainer(
            initMaxExtent: 53.sp,
            initMinExtent: 45.sp,
            child: (bool isCollapse, double shrinkOffset) => Container(
              color: Get.theme.scaffoldBackgroundColor,
              child: FlyAppBar(title: 'Sharing'.tr),
            ),
          ),
        ),
      ],
    );
  }
}
