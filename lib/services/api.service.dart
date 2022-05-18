import 'package:flaq_ui_v2/models/user.model.dart';
import 'package:flaq_ui_v2/services/auth.service.dart';
import 'package:flaq_ui_v2/widgets/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'location.service.dart';

class ApiService extends GetConnect implements GetxService {
  @override
  void onInit() {
    super.onInit();
    httpClient.addRequestModifier<dynamic>((request) async {
      Get.printInfo(info: 'Request - ${request.url}');
      request.headers['x-auth-token'] =
          '${await Get.find<AuthService>().getUserToken()}';
      return request;
    });
    httpClient.addResponseModifier((request, response) {
      if (response.hasError) {
        Get.printError(info: 'Response - ${response.bodyString}');
      } else {
        Get.printInfo(info: response.bodyString ?? '');
      }
      return response;
    });
    // httpClient.baseUrl = 'https://6b2f-125-22-99-42.in.ngrok.io/api/v1';
    httpClient.baseUrl = 'http://52.66.228.64:4000/api/v1';
  }

  /// API to get the goal for the user
  getGoal() async {
    final res = await httpClient.get('/syn/goal');
    print(res.bodyString);
    return res.body['data'];
  }

  // Get the user's profile
  Future<FlaqUser?> getProfile() async {
    debugPrint('Getting profile');
    final res = await httpClient.get('/user/profile');
    if (res.hasError) {
      debugPrint("Error fetching profile");
      debugPrint(res.bodyString);
      return null;
    }
    debugPrint("Profile fetched");
    return UserProfileResponse.fromJson(res.body).data;
  }

  /// Initiate a payment
  initiatePayment({
    required String upiUrl,
    required String amount,
    required String merchantId,
    required num lat,
    required num long,
  }) async {
    final res = await httpClient.post('/payments/initiate', body: {
      "amount": '0',
      "upiUrl": upiUrl,
      "merchantId": merchantId,
      "location": {"lat": lat, "long": long}
    });
    if (res.hasError) {
      debugPrint(res.bodyString);
    }
    return res.body['data'];
  }

  Future<bool> applyReferralCode(String referralCode) async {
    final res = await httpClient.post('/user/referral/apply', body: {
      "referralCode": referralCode,
    });
    if (res.hasError) {
      debugPrint(res.bodyString);
      if (res.statusCode == 400) {
        Helper.toast(res.body['message']);
      }
      return false;
    }
    Helper.toast('Referral code applied successfully');
    return true;
  }

  /// Confirm Payment
  confirmPayment(String metaId) async {
    final res = await httpClient.post('/payments/confirm', body: {
      "metaId": metaId,
    });
    if (res.hasError) {
      debugPrint("Error occured");
      debugPrint(res.bodyString);
    }
    debugPrint("Success confirming payment");
    debugPrint(res.bodyString);
    return res.body['data'];
  }

  /// Get all the merchant in the location
  getMerchantInLocation({
    required num lat,
    required num long,
  }) async {
    final res = await httpClient.post('/merchants/fetch/location', body: {
      'lat': lat,
      'long': long,
    });
    if (res.hasError) {
      debugPrint(res.bodyString);
      return null;
    }
    return res.body['data'];
  }

  /// Register a merchant
  registerMerchant({
    required String upiId,
    required num lat,
    required num long,
  }) async {
    final userLocation = await Get.find<LocationService>().getCurrentLocation();
    if (userLocation == null) {
      return;
    }
    final res = await httpClient.post('/merchants/register', body: {
      'upiId': upiId,
      'shopName': 'UNKNOWN',
      'lat': '$lat',
      'long': '$long',
      'city': 'UNKNOWN'
    });
    if (res.hasError) {
      debugPrint("Error creating merchant");
      debugPrint(res.bodyString);
      return null;
    }
    return res.body['data']['_id'];
  }
}
