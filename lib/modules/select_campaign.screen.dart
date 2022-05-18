import 'package:flaq_ui_v2/widgets/top_bar.widget.dart';
import 'package:flutter/material.dart';
import 'package:niku/namespace.dart' as n;
import 'package:niku/widget/niku.dart';

class SelectCampaignScreen extends StatefulWidget {
  const SelectCampaignScreen({Key? key}) : super(key: key);

  @override
  State<SelectCampaignScreen> createState() => _SelectCampaignScreenState();
}

class _SelectCampaignScreenState extends State<SelectCampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Niku(
        n.Column(
          [
            const TopBar(),
            n.Box()..h = 18,
            n.Row([
              n.Text('Select your earning path')
                ..fontSize = 18
                ..fontWeight = FontWeight.w700,
            ]),
            Niku()
              ..gradient = const LinearGradient(
                colors: [
                  Color(0xff8247E5),
                  Colors.transparent,
                ],
              )
              ..useRoundedBorder(
                width: 1,
                rounded: 5,
                color: const Color(0xff392063),
              )
              ..wFull
              ..h = 40,
          ],
        ),
      )..safeY,
    );
  }
}
