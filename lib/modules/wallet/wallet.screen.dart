import 'package:flaq_ui_v2/widgets/top_bar.widget.dart';
import 'package:niku/namespace.dart' as n;
import 'package:flutter/material.dart';
import 'package:niku/widget/niku.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _buildWalletDetails() {
      return n.Column([
        n.Text('Ankit\'s Wallet')
          ..fontSize = 16
          ..fontWeight = FontWeight.w500
          ..color = const Color(0xff9999A5),
        n.Row([
          n.Text('127bn8uaw8msnaj...32uz')..fontSize = 16,
          n.IconButton(Icons.copy)
            ..onPressed = () {}
            ..iconSize = 16
        ]),
      ])
        ..crossAxisAlignment = CrossAxisAlignment.start;
    }

    return Material(
      color: Colors.black,
      child: Niku(
        n.Column(
          [
            const TopBar(),
            n.Box()..h = 48,
            _buildWalletDetails(),
          ],
        )..crossAxisAlignment = CrossAxisAlignment.start,
      )
        ..safeAreaTop
        ..w100
        ..h100
        ..safeAreaTop
        ..px = 35,
    );
  }
}
