import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flaq_ui_v2/modules/payment/custom_border.dart';
import 'package:flaq_ui_v2/modules/payment/payment.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:niku/widget/niku.dart';
import 'package:niku/namespace.dart' as n;

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  late final MobileScannerController scanController;
  bool isScanned = false;
  var upiApps = <dynamic>[];
  dynamic selectedUpiApp = {};

  @override
  void initState() {
    super.initState();
    scanController = MobileScannerController(formats: [BarcodeFormat.qrCode]);
    CashfreePGSDK.getUPIApps().then((res) {
      setState(() {
        if (res != null) upiApps = res;
      });
    });
  }

  Widget _buildPayAnywhere() => Container(
        height: 150,
        padding: const EdgeInsets.all(18),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: n.Column(
          [
            n.Text('scan any qr code and pay on')
              ..fontSize = 18
              ..fontWeight = FontWeight.w600,
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Montserrat',
              ),
              child: AnimatedTextKit(
                pause: const Duration(milliseconds: 700),
                repeatForever: true,
                animatedTexts: [
                  RotateAnimatedText('PhonePe'),
                  RotateAnimatedText('Google Pay'),
                  RotateAnimatedText('PayTm'),
                ],
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Niku(
        n.Stack(
          [
            MobileScanner(
              controller: scanController,
              allowDuplicates: !isScanned,
              onDetect: (code, args) async {
                if (code.rawValue != null &&
                    (code.rawValue?.startsWith('upi://') ?? false)) {
                  debugPrint(code.rawValue);
                  final paymentController = Get.find<PaymentController>();
                  paymentController.setUpiUrl(code.rawValue ?? '');
                  // scanController.stop();
                  setState(() {
                    isScanned = true;
                  });
                  // Get.off(() => const PriceEntryScreen());
                }
              },
            ),
            n.Box()
              ..w100
              ..h100
              ..backgroundColor = !isScanned ? Colors.black26 : Colors.black87,
            if (!isScanned)
              Center(
                child: CustomPaint(
                  painter: BorderPainter(),
                  child: n.Box()
                    ..backgroundColor = Colors.white24
                    ..rounded = 20
                    ..w = 200
                    ..p = 8
                    ..h = 200,
                ),
              ),
            n.Column(
              [
                n.Box()..expanded,
                AnimatedCrossFade(
                  crossFadeState: isScanned
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                  firstCurve: Curves.bounceIn,
                  secondChild: Niku(
                    n.Column([
                      _buildPayAnywhere(),
                      // n.Text('Hi Bitch')..color = Colors.white,
                      Niku(
                        n.Column([
                          // n.Box()..h = 150,
                          n.Text('Select your upi app')
                            ..fontSize = 18
                            ..fontWeight = FontWeight.w600,
                          n.Box()..h = 18,
                          n.Row([
                            for (final upiApp in upiApps)
                              n.Column([
                                Niku(
                                  n.Image(
                                    MemoryImage(base64Decode(upiApp['icon'])),
                                  )
                                    ..h = 40
                                    ..w = 40,
                                )..useGesture(tap: () {
                                    setState(() {
                                      selectedUpiApp = upiApp;
                                      // controller.upiAppId(upiApp['id']);
                                    });
                                  }),
                                if (selectedUpiApp['id'] == upiApp['id'])
                                  n.Text(
                                    'Selected',
                                    style: n.TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                              ])
                          ])
                            ..scrollable
                            ..mainAxisAlignment = MainAxisAlignment.spaceEvenly,
                          n.Box()..h = 30,
                          if (!selectedUpiApp.isEmpty)
                            Niku(n.Stack([
                              n.Column([
                                n.Text(
                                    'pay now using ${selectedUpiApp['displayName'].toString().toLowerCase()}')
                                  ..color = const Color(0xff3d3d3d)
                                  ..fontSize = 14
                                  ..fontWeight = FontWeight.w600
                                  ..textAlign = TextAlign.center,
                              ])
                                ..backgroundColor = Colors.transparent
                                ..mainAxisAlignment = MainAxisAlignment.center
                                ..crossAxisAlignment =
                                    CrossAxisAlignment.center,
                            ]))
                              ..h = 48
                              ..align = Alignment.center
                              ..backgroundColor = selectedUpiApp.isEmpty
                                  ? Colors.white24
                                  : Colors.white
                              ..rounded = 4
                              ..useGesture(tap: () {
                                // PAY NOW BUTTON
                                Vibrate.feedback(FeedbackType.selection);
                                // controller.confirmPayment();
                                final controller =
                                    Get.find<PaymentController>();
                                controller.initiatePayment('0');
                              })
                              ..wFull,
                        ])
                          ..mx = 18,
                      )..wFull,
                      n.Box()..h = 18,
                      n.Box()..expanded,
                    ]),
                  )
                    ..useGesture(verticalDragEnd: (drag) {
                      if (drag.velocity.pixelsPerSecond.dy > 10) {
                        setState(() {
                          isScanned = false;
                        });
                      }
                    })
                    ..safeY
                    ..wFull
                    ..h = MediaQuery.of(context).size.height / 2
                    ..backgroundColor = Colors.black,
                  firstChild: _buildPayAnywhere(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
