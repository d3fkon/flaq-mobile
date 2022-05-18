import 'package:flaq_ui_v2/constants/colors.constants.dart';
import 'package:flaq_ui_v2/modules/login/signup.screen.dart';
import 'package:flaq_ui_v2/services/auth.service.dart';
import 'package:flaq_ui_v2/widgets/bg_gradient.widget.dart';
import 'package:flaq_ui_v2/widgets/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:niku/widget/niku.dart';
import 'package:niku/namespace.dart' as n;

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final referralController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff0D0D0D),
      child: Niku(
        n.Column(
          [
            n.Box()..h = 54,
            Niku(
              // Inner Column
              n.Column([
                n.Row([
                  n.Text('just one last thing')
                    ..fontSize = 20
                    ..fontWeight = FontWeight.w500,
                ]),
                n.Box()..h = 16,
                n.Row([
                  n.Text('we need a referral code')
                    ..fontSize = 14
                    ..fontWeight = FontWeight.w300,
                ]),
                n.Box()..h = 46,
                TextFormField(
                  controller: referralController,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (s) => Helper.validateReferralCode(s),
                  cursorColor: AppColors.ff,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'referral code',
                    errorStyle: const TextStyle(color: Color(0xff9999a5)),
                    hintStyle: const TextStyle(color: Color(0xff9999a5)),
                    fillColor: const Color(0xff1A1A1A),
                    focusedErrorBorder: Helper.focusedBorder(),
                    errorBorder: Helper.enabledBorder(),
                    focusedBorder: Helper.focusedBorder(),
                    enabledBorder: Helper.enabledBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
                n.Box()..h = 18,
                n.Box()..h = 36,
                Niku(
                  n.Text('apply code')
                    ..center
                    ..color = Colors.black
                    ..m = 13
                    ..fontWeight = FontWeight.w600,
                )
                  ..bg = AppColors.ff
                  ..rounded = 4
                  ..fullWidth
                  ..useGesture(
                    tap: (() {
                      final controller = Get.find<AuthService>();
                      controller.applyReferral(referralController.text.trim());
                      Vibrate.feedback(FeedbackType.success);
                    }),
                  ),
                n.Box()..h = 16,
                n.Text('how to get a referral code?')
                  ..underline
                  ..color = const Color(0xff9999A5)
                  ..useGesture(tap: () => Get.to(() => const SignupScreen()))
              ])
                ..px = 24,
            ),
            n.Box()..h = 57,
            n.Box()..h = 8,
            n.Text('do actions that are'),
            n.Text('truly rewarding')..bold
          ],
        )
          ..scrollable
          ..crossAxisAlignment = CrossAxisAlignment.center
          ..px = 24,
      )..safeAreaY,
    );
  }
}
