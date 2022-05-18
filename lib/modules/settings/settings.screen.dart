import 'package:flaq_ui_v2/services/auth.service.dart';
import 'package:flaq_ui_v2/widgets/bg_gradient.widget.dart';
import 'package:flaq_ui_v2/widgets/top_bar.widget.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:niku/namespace.dart' as n;
import 'package:flutter/material.dart';
import 'package:niku/widget/niku.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  _buildLogout() {
    return Niku(
      n.Column([
        n.Text('log out')
          ..fontSize = 14
          ..fontWeight = FontWeight.w600
          ..textAlign = TextAlign.center,
      ])
        ..mainAxisAlignment = MainAxisAlignment.center
        ..crossAxisAlignment = CrossAxisAlignment.center,
    )
      ..h = 48
      ..align = Alignment.center
      ..useRoundedBorder(color: Colors.white, rounded: 4, width: 1)
      ..backgroundColor = Colors.black38
      ..useGesture(
        tap: () {
          Vibrate.feedback(FeedbackType.selection);
          Get.find<AuthService>().signOut();
        },
      )
      ..wFull;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Niku(
        BGGradient(
          child: n.Column(
            [
              n.Text('Settings')
                ..fontSize = 20
                ..fontWeight = FontWeight.w500,
              n.Box()..h = 18,
              _buildLogout(),
              n.Box()..h = 18,
              Center(
                child: FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return n.Text(
                          'Version: ${snapshot.data!.version}+${snapshot.data!.buildNumber}',
                          style: n.TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        );
                      default:
                        return n.Box();
                    }
                  },
                ),
              )
            ],
          )
            ..crossAxisAlignment = CrossAxisAlignment.start
            ..py = 24
            ..px = 16,
        ),
      )..safeY,
    );
  }
}
