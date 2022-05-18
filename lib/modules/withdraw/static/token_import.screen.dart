import 'package:flaq_ui_v2/modules/withdraw/withdraw.screen.dart';
import 'package:flaq_ui_v2/widgets/bg_gradient.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:niku/niku.dart';
import 'package:niku/namespace.dart' as n;

class TokenImportScreeen extends StatelessWidget {
  const TokenImportScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Niku(
        BGGradient(
          child: n.Column([
            n.Row([
              n.Icon(Icons.arrow_back)..useGesture(tap: Get.back),
              n.Text('import token')
                ..fontSize = 20
                ..fontWeight = FontWeight.w500
                ..center
                ..expanded,
              n.Icon(Icons.transform)..color = Colors.transparent
            ]),
            n.Box()..h = 58,
            ...tokenImportMeta(
                'token address', '0x7D1AfA7B718fb893dB30A3aBc0Cfc608AaC'),
            ...tokenImportMeta('name', 'FLAQ'),
            ...tokenImportMeta('symbol', 'FLAQ'),
            ...tokenImportMeta('decimals', '18'),
            n.Box()..expanded,
            Niku(
              n.Column(
                [
                  n.Text('i have imported the token')
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
          ])
            ..px = 24,
        ),
      )..safeAreaTop,
    );
  }
}

tokenImportMeta(String label, String value) => [
      n.Row([
        n.Text(label)
          ..fontSize = 14
          ..fontWeight = FontWeight.w600
      ]),
      n.Box()..h = 8,
      n.TextFormField(
        initialValue: value,
      )
        ..enabled = false
        ..bg = const Color(0xff1A1A1A)
        ..useGesture(tap: () {
          EasyLoading.showToast('$value copied to clipboard');
        })
        ..fontSize = 12
        ..suffixIcon = (n.Icon(Icons.copy)..color = Colors.white),
      n.Box()..h = 24,
    ];
