// import 'package:Jidaa/ui-kit/widgets/jAppBar.dart';
// import 'package:Jidaa/ui-kit/widgets/viewLayout.widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:Jidaa/ui-kit/widgets/jNestedScrollerView.dart';

// import '../diabeticShare.controller.dart';
// import '../widgets/shareTabsView.widget.dart';

// class LandscapeView extends StatelessWidget {
//   const LandscapeView({
//     Key? key,
//     required this.tabController,
//   }) : super(key: key);

//   final TabController tabController;

//   @override
//   Widget build(BuildContext context) {
//     return ViewLandScapeWithOutScroll(
//       childA: SingleChildScrollView(
//         child: Column(
//           children: [
//             JAppBar(
//               title: 'Sharing'.tr,
//               enablePadding: true,
//             ),
//             JTabsBar(
//               tabController: tabController,
//               tabs: [
//                 Tab(text: 'Family'.tr),
//                 Tab(text: 'Medical providers'.tr),
//               ],
//             ),
//           ],
//         ),
//       ),
//       childB: ShareTabsView(tabController: tabController),
//     );
//   }
// }
