import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaq_ui_v2/constants/auth.constants.dart';
import 'package:flaq_ui_v2/models/user.model.dart';
import 'package:flaq_ui_v2/modules/home/home.controller.dart';
import 'package:flaq_ui_v2/modules/home/home.screen.dart';
import 'package:flaq_ui_v2/modules/home/new-home.screen.dart';
import 'package:flaq_ui_v2/modules/login/login.screen.dart';
import 'package:flaq_ui_v2/modules/login/referral.screen.dart';
import 'package:flaq_ui_v2/services/api.service.dart';
import 'package:flaq_ui_v2/widgets/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService instance = Get.find();
  late Rx<User?> firebaseUser;
  late final ApiService _apiService;
  FlaqUser? user;

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
  }

  /// Apply referral
  applyReferral(String referralCode) async {
    final res = await _apiService.applyReferralCode(referralCode);
    if (res) {
      await getProfile(handleReferral: false);
      navigate();
    } else {
      return;
    }
  }

  /// Navigate to the right screen
  navigate() {
    if (user == null) {
      // Get.offAll(() => const LoginScreen());
      return;
    }
    if (user!.isAllowed) {
      // Get.offAll(() => const HomeScreen());
      Get.offAll(() => const NewHomeScreen());
      return;
    }
    if (!user!.isAllowed) {
      Get.offAll(() => const ReferralScreen());
    }
  }

  /// Get the user's profile
  getProfile({bool handleReferral = true}) async {
    EasyLoading.show();
    if (auth.currentUser == null) {
      EasyLoading.dismiss();
      return;
    }
    user = (await _apiService.getProfile());
    Get.log('Profile fetched');
    if (user == null) {
      Get.log('Signing out');
      signOut();
      EasyLoading.dismiss();
      return;
    }
    final homeController = Get.find<HomeController>();
    homeController.flaqValue(double.parse(user?.synFlaqBalance ?? '0'));
    EasyLoading.dismiss();
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  /// Signup a user
  signup(String email, String password) async {
    EasyLoading.show();
    try {
      final authResult = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (authResult.user != null) {
        Helper.toast('Signed up successfully');
        // Get.to(const LoginScreen());
      }
    } catch (e) {
      Helper.toast(e.toString().split(']')[1]);
    }
    EasyLoading.dismiss();
  }

  /// Set the initital screen
  _setInitialScreen(User? user) async {
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      debugPrint("User doesn't exist");
      Get.offAll(() => const LoginScreen());
    } else {
      debugPrint("user exists");
      await getProfile();
      navigate();
    }
  }

  /// Get the user's token in the local storage
  getUserToken() async {
    return await auth.currentUser?.getIdToken();
  }

  /// Login the user
  void login(String email, String password) async {
    try {
      EasyLoading.show();
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'User not found');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Incorrect Password');
      }
    } catch (e) {
      debugPrint("Error logging in ");
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (firebaseAuthException) {}
  }

  void signOut() async {
    await auth.signOut();
  }
}
