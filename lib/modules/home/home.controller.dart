import 'dart:async';

import 'package:flaq_ui_v2/services/api.service.dart';
import 'package:flaq_ui_v2/services/auth.service.dart';
import 'package:get/get.dart';

class HomeController extends GetxService {
  Timer? timer;
  late final ApiService _apiService;
  late final flaqValue = 0.0.obs;
  late final amountComplete = 0.0.obs;
  late final goalAmount = 0.0.obs;

  init() async {
    // final goal = await _apiService.getGoal();
    // final authService = Get.find<AuthService>();
    // goalAmount(double.parse(goal['goalAmount']));
    // flaqValue(double.parse(authService.user?.synFlaqBalance ?? '0'));
    // amountComplete(double.parse(goal['amountComplete']));
  }

  HomeController() {
    _apiService = Get.find<ApiService>();
    init();
    // timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   updateFlaqValue();
    // });
  }

  updateFlaqValue() {
    flaqValue((flaqValue.value + 0.00034).toPrecision(4));
  }

  @override
  void dispose() {
    timer?.cancel();
  }
}
