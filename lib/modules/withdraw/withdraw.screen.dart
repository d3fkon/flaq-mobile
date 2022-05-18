import 'package:flaq_ui_v2/widgets/bg_gradient.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:niku/widget/niku.dart';
import 'package:niku/niku.dart';
import 'package:niku/namespace.dart' as n;

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  buildAddressField() => [
        n.Row([
          n.Text('address')
            ..fontSize = 14
            ..fontWeight = FontWeight.w600
        ]),
        n.Box()..h = 8,
        n.TextFormField()
          ..bg = const Color(0xff1A1A1A)
          ..fontSize = 12
          ..borderColor = Colors.transparent,
        n.Box()..h = 24,
      ];

  buildAmountField() => [
        n.Row([
          n.Text('amount')
            ..fontSize = 14
            ..fontWeight = FontWeight.w600
        ]),
        n.Box()..h = 8,
        n.TextFormField()
          ..bg = const Color(0xff1A1A1A)
          ..fontSize = 12
          ..keyboardType = TextInputType.number
          ..suffix = (n.Text('max')
            ..fontSize = 12
            ..fontWeight = FontWeight.w600)
          ..borderColor = Colors.transparent,
        n.Box()..h = 24,
      ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Niku(
        BGGradient(
          child: n.Column(
            [
              n.Row(
                [
                  n.Icon(Icons.arrow_back)..useGesture(tap: Get.back),
                  n.Text('withdraw')
                    ..fontSize = 20
                    ..fontWeight = FontWeight.w500
                    ..center
                    ..expanded,
                  n.Icon(Icons.transform)..color = Colors.transparent
                ],
              ),
              n.Box()..h = 58,
              n.Row([
                n.Text('network')
                  ..fontSize = 14
                  ..fontWeight = FontWeight.w600,
                n.Box()..expanded,
                n.Text('polygon')
                  ..fontSize = 14
                  ..color = const Color(0xff8247E5)
                  ..fontWeight = FontWeight.w600,
              ]),
              n.Box()..h = 40,
              ...buildAddressField(),
              ...buildAmountField(),
              n.Box()..expanded,
              Niku(
                n.Column(
                  [
                    n.Text('withdraw flaq')
                      ..fontSize = 14
                      ..color = const Color(0xff1A1A1A)
                      ..center
                      ..fontWeight = FontWeight.w600,
                  ],
                )..mainAxisAlignment = MainAxisAlignment.center,
              )
                ..backgroundColor = Colors.white
                ..fullWidth
                ..h = 48
                ..rounded = 4
                ..useGesture(tap: () {
                  Get.to(() => const WithdrawScreen());
                }),
              n.Box()..h = 100,
            ],
          )..px = 24,
        ),
      )..safeAreaTop,
    );
  }
}
