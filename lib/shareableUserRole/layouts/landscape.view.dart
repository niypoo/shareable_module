import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly_ui/views/layouts/landscapeView.widget.dart';
import 'package:fly_ui/views/widgets/appBar.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareableUserRole/widgets/rolesList.widget.dart';

class ShareableUserRoleLandscapeView extends StatelessWidget {
  const ShareableUserRoleLandscapeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlyLandscapeView(
      childA: SingleChildScrollView(
        child: Column(
          children: [
            FlyAppBar(title: 'Physical activities'.tr),
          ],
        ),
      ),
      childB: const FlyLandScapeScroll(
        child: Column(
          children: [RolesListWidget()],
        ),
      ),
    );
  }
}
