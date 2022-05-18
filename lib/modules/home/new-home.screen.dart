import 'package:flaq_ui_v2/constants/colors.constants.dart';
import 'package:flaq_ui_v2/modules/home/home.controller.dart';
import 'package:flaq_ui_v2/modules/payment/qr.screen.dart';
import 'package:flaq_ui_v2/modules/settings/settings.screen.dart';
import 'package:flaq_ui_v2/services/auth.service.dart';
import 'package:flaq_ui_v2/styles/text.dart';
import 'package:flaq_ui_v2/widgets/flaq_button.dart';
import 'package:flaq_ui_v2/widgets/flaq_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:niku/namespace.dart' as n;

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  _buildPayNowButton() {
    return n.Niku(n.Stack([
      n.Column([
        n.Text('make upi payment')
          ..color = const Color(0xff3d3d3d)
          ..fontSize = 14
          ..fontWeight = FontWeight.w700
          ..textAlign = TextAlign.center,
      ])
        ..backgroundColor = Colors.transparent
        ..mainAxisAlignment = MainAxisAlignment.center
        ..crossAxisAlignment = CrossAxisAlignment.center,
    ]))
      ..h = 48
      ..align = Alignment.center
      ..backgroundColor = Colors.white
      ..rounded = 4
      ..useGesture(tap: () {
        Vibrate.feedback(FeedbackType.selection);
        // Get.to(() => const PriceEntryScreen());
        Get.to(() => const QRScreen());
        // Get.to(() => const PaymentSuccessScreen(
        //       txnId: '123',
        //     ));
        // Get.to(() => const SelectCampaignScreen());
      })
      ..wFull;
  }

  Widget _buildTokens() {
    return n.Column([
      n.Row([
        n.Column([
          n.Niku(
            n.Image(const AssetImage('assets/images/POLYGON.png'))
              ..color = AppColors.f7
              ..useParent((p0) => p0..p = 5),
          )
            ..useRoundedBorder(color: AppColors.f7, width: 2, rounded: 100)
            ..w = 42
            ..h = 42,
        ]),
        n.Box()..w = 17,
        n.Column([
          n.Text('FRONT'),
          n.Box()..h = 8,
          n.Text('frontier wallet'),
          n.Box()..h = 8,
          n.Text('qty - 1.2 FRONT'),
        ])
          ..crossAxisAlignment = CrossAxisAlignment.start,
        n.Box()..expanded,
        n.Column([
          n.Text('₹ ${Get.find<HomeController>().flaqValue}'),
          n.Text('claimable')
            ..color = AppColors.b9
            ..fontSize = 10,
        ])
          ..crossAxisAlignment = CrossAxisAlignment.start,
      ])
        ..crossAxisAlignment = CrossAxisAlignment.start
        ..pb = 24,
    ]);
  }

  Widget _buildWithdrawRewards() {
    return n.Column([
      n.Text('withdraw rewards')
        ..fontSize = 18
        ..fontWeight = FontWeight.w400,
      n.Box()..h = 16,
      n.Text('connect your frontier wallet and claim rewards')
        ..color = AppColors.b9
        ..fontSize = 14,
      n.Box()..h = 24,
      // n.Box()..h = 24,
      n.Niku(
        FButton(
          n.Text('connect your wallet')..apply = TextStyles.buttonText,
        ),
        // _buildTokens(),
      ),
      n.Box()..h = 24,
      n.Box()
        ..h = 1
        ..wFull
        ..backgroundColor = AppColors.oneF,
      n.Box()..h = 24,
      n.Niku(
        _buildTokens(),
      )
    ])
      ..crossAxisAlignment = CrossAxisAlignment.start
      ..p = 24;
  }

  Widget _buildCard() {
    return FCard(
      n.Column([
        n.Row([
          n.Text('what is ')
            ..fontSize = 18
            ..color = const Color(0xfff7f7f7),
          n.Text('frontier')
            ..fontSize = 18
            ..color = Colors.orange,
          n.Text('?')
            ..fontSize = 18
            ..color = const Color(0xfff7f7f7),
        ]),
        n.Box()..h = 12,
        n.Text(
          'Frontier is a Crypto & DeFi, NFT wallet where you can send, store & invest in 4,000+ crypto assets',
        )..fontSize = 12,
        n.Box()..h = 24,
        n.Row([
          FButton(
            n.Row([
              n.Text('learn more')..apply = TextStyles.buttonText,
              n.Box()..w = 8,
              n.Niku(n.Icon(Icons.keyboard_backspace))..rotate = 3.14,
            ]),
          )..small,
          n.Box()..expanded
        ]),
      ])
        ..crossAxisAlignment = CrossAxisAlignment.start,
    )..mx = 24;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.oneD,
      child: n.Niku(
        n.Column([
          n.Niku(
            n.Column([
              n.Row([
                n.Column([
                  n.Text('your flaq rewards')
                    ..fontSize = 18
                    ..color = AppColors.ff
                    ..fontWeight = FontWeight.w400,
                  n.Box()..h = 8,
                  n.Text('₹ ${Get.find<HomeController>().flaqValue}')
                    ..fontWeight = FontWeight.w400
                    ..fontSize = 30,
                ])
                  ..crossAxisAlignment = CrossAxisAlignment.start,
                n.Box()..expanded,
                n.Niku(
                  n.Image(const AssetImage('assets/images/Logo.png'))
                    ..useParent((p0) => p0..m = 10),
                )
                  ..backgroundColor = const Color(0xff9999A5)
                  ..rounded = 1000
                  ..w = 50
                  ..h = 50
                  ..useGesture(tap: () {
                    Get.to(() => const SettingsScreen());
                  }),
              ]),
              n.Box()..h = 32,
              n.Text('earn flaq rewards for every upi payment \n'
                  'and redeem them for \$FRONT crypto tokens')
                ..fontSize = 12
                ..fontWeight = FontWeight.w500,
              n.Box()..h = 32,
              _buildPayNowButton(),
            ])
              ..m = 25
              ..crossAxisAlignment = CrossAxisAlignment.start,
          )
            ..boxDecoration = const BoxDecoration(
              color: AppColors.oneD,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            )
            ..fullWidth,
          n.Niku(_buildWithdrawRewards()),
          _buildCard(),
        ])
          ..crossAxisAlignment = CrossAxisAlignment.start,
      )
        ..backgroundColor = AppColors.zeroD
        ..safeY,
    );
  }
}
