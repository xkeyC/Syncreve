import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:syncreve/base/ui_model.dart';

class QrScannerUIModel extends BaseUIModel {
  final Future<bool> Function(BarcodeCapture barcodes) onQrDetect;

  QrScannerUIModel({required this.onQrDetect});

  bool isPop = false;

  void onDetect(BarcodeCapture barcodes) async {
    if (await onQrDetect(barcodes)) {
      if (!isPop) {
        isPop = true;
        Navigator.pop(context!);
      }
    }
  }
}
