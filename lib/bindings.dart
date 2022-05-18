import 'package:flaq_ui_v2/modules/payment/payment.controller.dart';
import 'package:flaq_ui_v2/services/api.service.dart';
import 'package:flaq_ui_v2/services/auth.service.dart';
import 'package:flaq_ui_v2/modules/home/home.controller.dart';
import 'package:flaq_ui_v2/services/location.service.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => LocationService());
    Get.lazyPut(() => PaymentController());
  }
}
