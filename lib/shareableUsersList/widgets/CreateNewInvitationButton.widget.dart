
import 'package:flutter/material.dart';
import 'package:fly_ui/views/widgets/buttons/elevatedButton.widget.dart';
import 'package:fly_ui/views/widgets/buttons/iconButton.widget.dart';
import 'package:get/get.dart';
import 'package:shareable_module/shareableUsersList/shareableUsersList.controller.dart';
import 'package:shareable_module/shareable.service.dart';
import 'package:unicons/unicons.dart';

class CreateNewInvitationButton extends GetView<ShareableUsersListController> {
  const CreateNewInvitationButton({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return FlyElevatedButton.primary(
      onPressed: () =>
          ShareableService.to.createNewInvitation(controller.object),
      title: "Family Invitation".tr,
    );
  }
}



class CreateNewInvitationAppBarButton extends GetView<ShareableUsersListController> {
  const CreateNewInvitationAppBarButton({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return FlyIconButton(
      icon: UniconsLine.plus,
      onPressed: () => ShareableService.to
          .createNewInvitation(controller.object),
    );
  }
}
