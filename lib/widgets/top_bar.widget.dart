import 'package:flaq_ui_v2/modules/settings/settings.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:niku/namespace.dart' as n;

import '../modules/wallet/wallet.screen.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return n.Column([
      n.Row([
        n.IconButton(Icons.settings)
          ..iconSize = 16
          ..useParent(
            (p) => p
              ..useRoundedBorder(color: Colors.white.withOpacity(0.7), width: 1)
              ..h = 42
              ..w = 42,
          )
          ..onPressed = () {
            Get.to(const SettingsScreen());
          },
        n.Box()..expanded,
        // n.IconButton(Icons.account_balance_wallet)
        //   ..useParent(
        //     (p) => p
        //       ..backgroundColor = Colors.white
        //       ..rounded,
        //   )
        //   ..onPressed = () {
        //     Get.to(() => const WalletScreen());
        //   }
        //   ..color = Colors.black,
      ]),
    ])
      ..px = 16;
  }
}
