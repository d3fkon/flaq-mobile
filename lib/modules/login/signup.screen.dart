import 'package:flaq_ui_v2/constants/colors.constants.dart';
import 'package:flaq_ui_v2/services/auth.service.dart';
import 'package:flaq_ui_v2/widgets/bg_gradient.widget.dart';
import 'package:flaq_ui_v2/widgets/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:niku/widget/niku.dart';
import 'package:niku/namespace.dart' as n;

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool shouldShowPassword = false;

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
                  n.Text('sign up')
                    ..fontSize = 20
                    ..fontWeight = FontWeight.w500,
                ]),
                n.Box()..h = 16,
                n.Row([
                  n.Text('create your login credentials')
                    ..fontSize = 14
                    ..fontWeight = FontWeight.w300,
                ]),
                n.Box()..h = 46,
                TextFormField(
                  autofocus: true,
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (s) => Helper.validateEmail(s),
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: AppColors.ff,
                  decoration: InputDecoration(
                    filled: true,
                    errorStyle: const TextStyle(color: Color(0xff9999a5)),
                    hintText: 'email',
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
                TextFormField(
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (s) => Helper.validatePassword(s),
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: AppColors.ff,
                  obscureText: !shouldShowPassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        !shouldShowPassword
                            ? Icons.remove_red_eye
                            : Icons.visibility_off,
                        size: 20,
                        color: const Color(0xff9999a5),
                      ),
                      onPressed: () {
                        setState(() {
                          shouldShowPassword = !shouldShowPassword;
                        });
                      },
                    ),
                    suffixIconColor: AppColors.secondary,
                    filled: true,
                    hintText: 'password',
                    hintStyle: const TextStyle(color: Color(0xff9999a5)),
                    errorStyle: const TextStyle(color: Color(0xff9999a5)),
                    errorMaxLines: 2,
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
                n.Box()..h = 36,
                Niku(
                  n.Text('sign up')
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
                      controller.signup(emailController.text.trim(),
                          passwordController.text.trim());
                      Vibrate.feedback(FeedbackType.success);
                    }),
                  ),
                n.Box()..h = 16,
                n.Text('already have an account? login')
                  ..underline
                  ..color = const Color(0xff9999A5)
                  ..useGesture(tap: Get.back)
              ])
                ..px = 24,
            ),
            n.Box()..h = 57,
          ],
        )
          ..scrollable
          ..crossAxisAlignment = CrossAxisAlignment.center
          ..px = 24,
      )..safeAreaY,
    );
  }
}
