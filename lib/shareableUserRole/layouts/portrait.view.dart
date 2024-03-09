import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shareable_module/shareableUserRole/widgets/rolesList.widget.dart';

class ShareableUserRolePortraitView extends StatelessWidget {
  const ShareableUserRolePortraitView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [RolesListWidget()],
      ),
    );
  }
}
