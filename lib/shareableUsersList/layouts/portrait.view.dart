import 'package:flutter/material.dart';
import 'package:fly_ui/views/layouts/nestedScrollView.widget.dart';
import 'package:fly_ui/views/widgets/sliverAppBae.widget.dart';
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
          delegate: FlySliverAppBar(
            title: 'Sharing'.tr,
          ),
        ),
      ],
    );
  }
}
