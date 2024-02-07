import 'package:flutter/material.dart';
import 'package:fly_ui/views/layouts/responsiveView.widget.dart';
import 'package:fly_ui/views/layouts/scaffoldLayout.widget.dart';
import 'package:shareable_module/shareableUsersList/layouts/portrait.view.dart';

class ShareableUsersListView extends StatelessWidget {
  const ShareableUsersListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FlyScaffold(
      child: FlyResponsiveView(
        child: PortraitView(),
      ),
    );
  }
}
