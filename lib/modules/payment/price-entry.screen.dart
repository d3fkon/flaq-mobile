import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flaq_ui_v2/modules/payment/payment.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:niku/namespace.dart' as n;
import 'package:niku/widget/niku.dart';

import '../../constants/colors.constants.dart';

class PriceEntryScreen extends StatefulWidget {
  const PriceEntryScreen({Key? key}) : super(key: key);

  @override
  State<PriceEntryScreen> createState() => _PriceEntryScreenState();
}

class _PriceEntryScreenState extends State<PriceEntryScreen> {
  final controller = Get.find<PaymentController>();
  final amountController = TextEditingController();
  var upiApps = <dynamic>[];
  dynamic selectedUpiApp = {};

  @override
  initState() {
    super.initState();
    CashfreePGSDK.getUPIApps().then((res) {
      setState(() {
        if (res != null) upiApps = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Niku(
            n.Column([
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
                          controller.upiAppId(upiApp['id']);
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
              n.Box()..h = 18,
              Niku(n.Stack([
                n.Column([
                  n.Text('pay now using ${selectedUpiApp['displayName']}')
                    ..color = const Color(0xff3d3d3d)
                    ..fontSize = 14
                    ..fontWeight = FontWeight.w600
                    ..textAlign = TextAlign.center,
                ])
                  ..backgroundColor = Colors.transparent
                  ..mainAxisAlignment = MainAxisAlignment.center
                  ..crossAxisAlignment = CrossAxisAlignment.center,
              ]))
                ..h = 48
                ..align = Alignment.center
                ..backgroundColor =
                    selectedUpiApp.isEmpty ? Colors.white24 : Colors.white
                ..rounded = 4
                ..useGesture(tap: () {
                  // PAY NOW BUTTON
                  Vibrate.feedback(FeedbackType.selection);
                  // controller.confirmPayment();
                  controller.initiatePayment(amountController.text);
                })
                ..wFull,
            ])
              ..mx = 18,
          )..wFull,
          n.Box()..h = 18,

          // Center(
          //   child: AutoSizeTextField(
          //     cursorColor: AppColors.secondary,
          //     autofocus: true,
          //     minWidth: 110,
          //     textAlign: TextAlign.center,
          //     keyboardType: TextInputType.number,
          //     style: const TextStyle(
          //       fontWeight: FontWeight.w400,
          //       fontSize: 32,
          //       color: AppColors.white,
          //     ),
          //     inputFormatters: [
          //       FilteringTextInputFormatter.digitsOnly,
          //     ],
          //     toolbarOptions: const ToolbarOptions(),
          //     enableInteractiveSelection: false,
          //     controller: amountController,
          //     onChanged: (value) {
          //       // Setting the amount only if it is not already fixed
          //       // if (!widget.amountFixed) model.controller.amount = value;
          //     },
          //     decoration: const InputDecoration(
          //       prefixText: '₹',
          //       prefixStyle: TextStyle(
          //         color: AppColors.white,
          //         fontSize: 32,
          //       ),
          //       border: InputBorder.none,
          //     ),
          //     fullwidth: false,
          //   ),
          // ),

          n.Row([
            Obx(() => Text('Paying ${controller.pa.value}')),
          ])
            ..mainAxisAlignment = MainAxisAlignment.center,
        ],
      ),
    );
  }
}
