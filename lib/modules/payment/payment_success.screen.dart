import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:niku/namespace.dart' as n;
import 'package:niku/widget/niku.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final String txnId;
  const PaymentSuccessScreen({Key? key, required this.txnId}) : super(key: key);

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Niku(
        n.Column([
          n.Box()..h = 18,
          n.Text(
            'flaq',
            style: n.TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          n.Box()..expanded,
          n.Image(
            const AssetImage('assets/images/txn_success.gif'),
          )
            ..h = 288
            ..w = 288,
          n.Text(
            'Transaction ID',
            style: n.TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          n.Text(
            widget.txnId,
            style: n.TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          n.Box()..expanded,
          n.Button(n.Text('Done'))
            ..center
            ..onPressed = Get.back,
          n.Box()..expanded,
        ])
          ..fullWidth
          ..mainAxisAlignment = MainAxisAlignment.center
          ..crossAxisAlignment = CrossAxisAlignment.center,
      )
        ..backgroundColor = Colors.black
        ..safeAreaY,
    );
  }
}
