import 'package:flaq_ui_v2/modules/home/home.controller.dart';
import 'package:flaq_ui_v2/modules/payment/payment_success.screen.dart';
import 'package:flaq_ui_v2/modules/payment/price-entry.screen.dart';
import 'package:flaq_ui_v2/modules/payment/qr.screen.dart';
import 'package:flaq_ui_v2/modules/select_campaign.screen.dart';
import 'package:flaq_ui_v2/modules/withdraw/static/token_import.screen.dart';
import 'package:flaq_ui_v2/modules/withdraw/static/withdraw_info.screen.dart';
import 'package:flaq_ui_v2/services/auth.service.dart';
import 'package:flaq_ui_v2/widgets/bg_gradient.widget.dart';
import 'package:flaq_ui_v2/widgets/helper.dart';
import 'package:flaq_ui_v2/widgets/top_bar.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:niku/niku.dart';
import 'package:niku/namespace.dart' as n;
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late final WithdrawInfoData _withdrawInfoData1;
  late final WithdrawInfoData _withdrawInfoData2;
  HomeScreenState() {
    _withdrawInfoData2 = WithdrawInfoData(
      image: const AssetImage('assets/images/Logo.png'),
      title: 'Import the \$FLAQ token to your wallet',
      description:
          'in order to view your flaq balance, import the token into your wallet',
      actionText: 'i understand',
    );

    _withdrawInfoData1 = WithdrawInfoData(
      image: const AssetImage('assets/images/POLYGON.png'),
      title: '\$FLAQ exists on the polygon blockchain',
      description:
          'make sure your wallet is connected to matic chain in order to view your token',
      actionText: 'next',
    );
  }

  final controller = Get.find<HomeController>();
  _buildSavingsWidget() {
    return n.Column([
      n.Row([
        n.Text('flaq rewards')
          ..fontSize = 18
          ..textAlign = TextAlign.left,
      ]),
      n.Row([
        NikuImage.asset('assets/images/Logo.png')
          ..width = 24
          ..height = 24,
        n.Box()..w = 8,
        Obx(
          () => n.Text('${controller.flaqValue}')
            ..fontSize = 30.0
            ..fontWeight = FontWeight.w600,
        )
      ]),
    ])
      ..px = 16;
  }

  _buildPayNowButton() {
    return Niku(n.Stack([
      n.Column([
        n.Text('make upi payment')
          ..color = const Color(0xff3d3d3d)
          ..fontSize = 14
          ..fontWeight = FontWeight.w600
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
      ..px = 16
      ..wFull;
  }

  _bulidSecondaryButtons() {
    return Niku(
      n.Column([
        n.Text('withdraw')
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
          Get.to(
            () => WithdrawInfoScreen(
              data: _withdrawInfoData1,
              onPress: () {
                Vibrate.feedback(FeedbackType.selection);
                Get.to(
                  () => WithdrawInfoScreen(
                    data: _withdrawInfoData2,
                    onPress: () {
                      Vibrate.feedback(FeedbackType.selection);
                      Get.to(() => const TokenImportScreeen());
                    },
                  ),
                  preventDuplicates: false,
                );
              },
            ),
          );
        },
      )
      ..wFull;
  }

  _buildWhatsappCTA() {
    return n.Column([
      n.Text('refer & earn flaq')
        ..useParent(
          (p0) => p0
            ..px = 16
            ..pb = 22,
        )
        ..fontWeight = FontWeight.w400
        ..fontSize = 18,
      Niku(
        n.Column(
          [
            n.Text('flaq is an invite only app')
              ..fontSize = 14
              ..fontWeight = FontWeight.w600,
            n.Box()..h = 14,
            n.Text('invite friends and earn upto 100 FLAQ \n'
                'your referral code - "${Get.find<AuthService>().user!.referralCode}"\n')
              ..fontSize = 14
              ..color = const Color(0xffB9B9B9)
              ..fontWeight = FontWeight.w400,
            // n.Text(
            //     'your referral code - "${Get.find<AuthService>().user!.referralCode}"\n')
            //   ..fontSize = 14
            //   ..color = const Color(0xffB9B9B9)
            //   ..fontWeight = FontWeight.w400,
            n.Box()..h = 18,
            Niku(
              n.Row([
                n.Icon(Icons.whatsapp)
                  ..color = Colors.black
                  ..size = 17,
                n.Box()..w = 8.1,
                n.Text('invite and earn')
                  ..color = const Color(0xff3d3d3d)
                  ..fontWeight = FontWeight.w600
                  ..fontSize = 14
              ])
                ..mainAxisAlignment = MainAxisAlignment.center,
            )
              ..p = 12
              ..backgroundColor = Colors.white
              ..rounded = 4
          ],
        )
          ..crossAxisAlignment = CrossAxisAlignment.start
          ..p = 24,
      )
        ..useRoundedBorder(color: Colors.white, rounded: 4, width: 1)
        ..useGesture(tap: () {
          Vibrate.feedback(FeedbackType.success);
          final referralCode = Get.find<AuthService>().user!.referralCode;
          launch(Uri.encodeFull(
              'https://api.whatsapp.com/send?text=Join the flaq club and start earn crypto for all your payments.\nUse my referral code *$referralCode* to enter the app now'));
        })
        ..px = 16
        ..wFull
    ])
      ..crossAxisAlignment = CrossAxisAlignment.start;
  }

  _buildFalqClub() {
    return Niku(
      n.Column([
        n.Text('your earnings')
          ..useParent(
            (p0) => p0
              ..px = 16
              ..pb = 22,
          )
          ..fontWeight = FontWeight.w400
          ..fontSize = 18,
        n.ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, i) => Niku(
            n.Stack([
              Positioned(
                child: CircleAvatar(
                  child: n.Image(
                    const AssetImage('assets/images/POLYGON.png'),
                  )..useParent(
                      (p0) => p0..p = 5,
                    ),
                  radius: 20,
                  backgroundColor: Colors.white,
                ),
                right: -6,
                top: -6,
              ),
              n.Column([
                n.Text(i == 0 ? 'polygon' : 'sunflower land')
                  ..fontSize = 16
                  ..fontWeight = FontWeight.w500,
                n.Box()..expanded,
                n.Text(i == 0 ? '0.5 MATIC' : '24 SFL')
                  ..fontWeight = FontWeight.w500
                  ..fontSize = 12
                  ..color = const Color(0xff9999A5),
                n.Text(i == 0 ? '₹ 110' : '₹ 140')
                  ..fontSize = 16
                  ..fontWeight = FontWeight.w400,
              ])
                ..crossAxisAlignment = CrossAxisAlignment.start
                ..p = 16,
            ]),
          )
            ..useGesture(tap: () {
              Helper.toast('earning redemption coming soon!');
            })
            ..h = 107
            ..w = 175
            ..rounded = 4
            ..useRoundedBorder(
                color: const Color(0xff000000), rounded: 4, width: 1)
            ..backgroundColor = const Color(0xff1D1D1D)
            ..pr = 10,
        )
          ..h = 139
          ..pt = 0
          ..scrollDirection = Axis.horizontal,
      ])
        ..crossAxisAlignment = CrossAxisAlignment.start,
    );
    // ..useRoundedBorder(color: Colors.white, rounded: 4, width: 1)
  }

  _buildLearnPolygon() {
    return Niku(
      n.Column([
        n.Row([
          n.Text('learn about the polygon ecosystem')
            ..fontSize = 16
            ..fontWeight = FontWeight.w300,
        ]),
        n.Box()..h = 18,
        n.Row([
          n.Text(
              'polygon is a layer 2 blockchain scaling solution. learn more to earn \$MATIC')
            ..color = const Color(0xff9999A5)
            ..expanded
            ..fontWeight = FontWeight.w500,
        ]),
        n.Box()..h = 18,
        Niku(
          n.Row([
            n.Image(const AssetImage('assets/images/POLYGON.png'))
              ..h = 17
              ..w = 17
              ..color = Colors.white,
            n.Box()..w = 8.1,
            n.Text('learn more')
              ..color = Colors.white
              ..fontWeight = FontWeight.w600
              ..fontSize = 14
          ])
            ..mainAxisAlignment = MainAxisAlignment.center,
        )
          ..p = 12
          ..backgroundColor = const Color(0xffA869FE)
          ..rounded = 4
      ])
        ..p = 24,
    )
      ..useRoundedBorder(color: Colors.white, rounded: 4, width: 1)
      ..px = 16
      ..wFull;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Niku(
        BGGradient(
          child: n.Column([
            // const TopBar(),
            // n.Box()..h = 48,
            _buildSavingsWidget(),
            n.Box()..h = 34,
            // _buildFlaqValue(),
            // Obx(
            //   () => FlaqProgressBar(
            //     amountComplete: controller.amountComplete.value,
            //     goalAmount: controller.goalAmount.value,
            //   ),
            // ),
            // n.Box()..h = 48,
            _buildPayNowButton(),
            // n.Box()..h = 18,
            // _bulidSecondaryButtons(),
            n.Box()..h = 32,
            _buildFalqClub(),
            // n.Box()..h = 24,
            // _buildLearnPolygon(),
            _buildWhatsappCTA(),
          ])
            ..w100
            ..safeAreaTop
            ..scrollable,
          // ..px = 16,
        ),
      ),
    );
  }
}

class FlaqProgressBar extends StatelessWidget {
  final double amountComplete, goalAmount;
  const FlaqProgressBar({
    Key? key,
    required this.amountComplete,
    required this.goalAmount,
  }) : super(key: key);

  @override
  Widget build(context) {
    return n.Column([
      n.Row([
        n.Row([
          // Polygon logo
          n.Image(const AssetImage('assets/images/POLYGON.png'))
            ..color = AppColors.white
            ..h = 14
            ..w = 14,
          n.Box()..w = 5,
          n.Text('0')..fontSize = 14,
        ]),
        n.Box()..expanded,
        n.Row([
          // Polygon logo
          n.Image(const AssetImage('assets/images/POLYGON.png'))
            ..color = AppColors.white
            ..h = 14
            ..w = 14,
          n.Box()..w = 5,
          n.Text('50')..fontSize = 14,
        ]),
      ]),
      n.Box()..h = 10,
      LinearProgressIndicator(
        value: amountComplete / (goalAmount == 0 ? 1 : goalAmount),
        minHeight: 6,
        backgroundColor: AppColors.secondary.withOpacity(0.2),
        valueColor: const AlwaysStoppedAnimation(AppColors.secondary),
      ),
      n.Box()..h = 18,
      n.Text('earn flaq by making payments\nwithdraw flaq into \$MATIC')
        ..color = const Color(0xffF7F7F7)
        ..fontSize = 14
        ..fontWeight = FontWeight.w300
    ])
      ..crossAxisAlignment = CrossAxisAlignment.start;
  }
}
