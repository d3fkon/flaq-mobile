import 'package:flaq_ui_v2/widgets/bg_gradient.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:niku/widget/niku.dart';
import 'package:niku/namespace.dart' as n;

class WithdrawInfoData {
  final ImageProvider image;
  final String title;
  final String description;
  final String actionText;

  WithdrawInfoData({
    required this.image,
    required this.title,
    required this.description,
    required this.actionText,
  });
}

class WithdrawInfoScreen extends StatefulWidget {
  final WithdrawInfoData data;
  final VoidCallback onPress;
  const WithdrawInfoScreen(
      {Key? key, required this.data, required this.onPress})
      : super(key: key);
  @override
  State<WithdrawInfoScreen> createState() => _WithdrawInfoScreenState();
}

class _WithdrawInfoScreenState extends State<WithdrawInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: BGGradient(
        child: n.Column(
          [
            n.Box()..expanded,
            n.Row([
              n.Image(widget.data.image)
                ..h = 100
                ..w = 100
            ]),
            n.Box()..h = 42,
            n.Text(widget.data.title)
              ..fontSize = 24
              ..fontWeight = FontWeight.w600
              ..color = Colors.white,
            n.Box()..h = 12,
            n.Text(widget.data.description)
              ..fontSize = 16
              ..fontWeight = FontWeight.w400
              ..color = Colors.white,
            n.Box()..expanded,
            Niku(
              n.Column(
                [
                  n.Text(widget.data.actionText)
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
              ..useGesture(tap: widget.onPress),
            n.Box()..h = 100
          ],
        )..px = 24,
      ),
    );
  }
}
