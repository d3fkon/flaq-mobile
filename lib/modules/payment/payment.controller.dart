import 'dart:io';
import 'dart:math';

import 'package:flaq_ui_v2/constants/auth.constants.dart';
import 'package:flaq_ui_v2/modules/payment/payment_success.screen.dart';
import 'package:flaq_ui_v2/services/api.service.dart';
import 'package:flaq_ui_v2/services/location.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:upi_pay/upi_pay.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentController extends GetxService with WidgetsBindingObserver {
  var upiUrl = "upi://pay?pa=ashwin221198@okicici&pn=Ashwin".obs;
  var pa = "".obs;
  var pn = "".obs;
  var upiAppId = "".obs;
  var metaId = "625853b90c373076182dabae".obs;
  var mc = "".obs;
  var sign = "".obs;
  var mode = "".obs;
  var orgid = "".obs;
  final apiService = Get.find<ApiService>();

  setUpiUrl(String upiUrl) {
    debugPrint('Raw - $upiUrl');
    this.upiUrl(upiUrl);
    final uri = Uri.dataFromString(Uri.decodeFull(upiUrl));
    pa(uri.queryParameters['pa']);
    pn(uri.queryParameters['pn']);
    mc(uri.queryParameters['mc']);
    sign(uri.queryParameters['sign']);
    mode(uri.queryParameters['mode']);
    orgid(uri.queryParameters['orgid']);
    debugPrint(pa.value);
  }

  /// Make a payment on Android
  makeAndroidPayment() async {
    final appId = upiAppId.string;
    late final UpiApplication upiApp;

    if (appId.contains('google') || appId.contains('tez')) {
      upiApp = UpiApplication.googlePay;
    } else if (appId.contains('phonepe')) {
      upiApp = UpiApplication.phonePe;
    } else if (appId.contains('paytm')) {
      upiApp = UpiApplication.paytm;
    } else if (appId.contains('icic')) {
      upiApp = UpiApplication.iMobile;
    } else {
      upiApp = UpiApplication.googlePay;
    }

    EasyLoading.show(status: "opening payment gateway");
    final res = await UpiPay.initiateRawTransaction(
      app: upiApp,
      raw: upiUrl.value,
    );
    EasyLoading.dismiss();
    if (res.status == UpiTransactionStatus.success ||
        res.status == UpiTransactionStatus.submitted) {
      await apiService.confirmPayment(metaId.value);
      await Future.delayed(const Duration(milliseconds: 100));
      await authService.getProfile();
      Get.off(() => PaymentSuccessScreen(
            txnId: res.txnId ?? '-',
          ));
    } else {
      Get.back();
      Fluttertoast.showToast(
          msg: 'Could not confirm payment. Please try again');
    }
  }

  /// Initiate payment for a particular amount
  initiatePayment(String amount) async {
    final locationService = Get.find<LocationService>();
    final location = await locationService.getCurrentLocation();
    if (location == null) {
      Get.back();
      return;
    }
    String merchantId;
    final merchant = await apiService.getMerchantInLocation(
        lat: location.latitude, long: location.longitude);
    if (merchant == null) {
      merchantId = await apiService.registerMerchant(
        upiId: pa.value,
        lat: location.latitude,
        long: location.longitude,
      );
    } else {
      merchantId = merchant['_id'];
    }
    debugPrint('Merchant Fetched. Initializing Payments');
    final payment = await apiService.initiatePayment(
      amount: amount,
      upiUrl: 'ashwin221198@okicici',
      merchantId: merchantId,
      lat: location.latitude,
      long: location.longitude,
    );
    debugPrint('Payment Initiated');
    final meta = payment['meta'];
    metaId(meta['_id']);
    EasyLoading.show();
    Fluttertoast.showToast(
      msg: 'Reopen flaq after payment to collect your reward',
      toastLength: Toast.LENGTH_LONG,
    );

    await makeAndroidPayment();
    EasyLoading.dismiss();
  }
}
