import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:syncreve/base/ui.dart';

import 'qr_scanner_ui_model.dart';

class QrScannerUI extends BaseUI<QrScannerUIModel> {
  @override
  Widget? buildBody(BuildContext context, QrScannerUIModel model) {
    return Stack(
      children: [
        Stack(
          children: [
            MobileScanner(
              // fit: BoxFit.contain,
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.normal,
                facing: CameraFacing.back,
                torchEnabled: true,
              ),
              onDetect: model.onDetect,
            )
          ],
        ),
        ColorFiltered(
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.srcOut),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black26,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(32)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.top + 54,
          child: makeAppbar(context, getUITitle(context, model),
              backgroundColor: Colors.transparent,
              elevation: 0,
              textColor: Colors.white),
        )
      ],
    );
  }

  @override
  String getUITitle(BuildContext context, QrScannerUIModel model) => "Scan QR";

  @override
  PreferredSizeWidget? buildAppbar(
          BuildContext context, QrScannerUIModel model) =>
      null;
}
