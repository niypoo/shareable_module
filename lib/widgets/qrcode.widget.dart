import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class QRCodeWidget extends StatelessWidget {
  final String value;

  const QRCodeWidget({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: (context.isLandscape ? Get.height : Get.width) * 0.5,
        width: (context.isLandscape ? Get.height : Get.width) * 0.5,
        child: SfBarcodeGenerator(
          barColor: Get.theme.primaryColor,
          value: value,
          textStyle: Get.textTheme.bodySmall!,
          symbology: QRCode(),
          // showValue: true,
        ),
      ),
    );
  }
}
