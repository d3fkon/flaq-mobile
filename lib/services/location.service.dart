import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService extends GetxService {
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permissionGranted;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Show a dialog asking to enable location services
      Get.dialog(
        AlertDialog(
          title: const Text('Location Service Disabled'),
          content: const Text('Please enable location services'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      );
      return null;
    }
    permissionGranted = await Geolocator.checkPermission();
    if (permissionGranted == LocationPermission.denied) {
      permissionGranted = await Geolocator.requestPermission();
      if (permissionGranted == LocationPermission.denied) {
        Get.dialog(
          AlertDialog(
            title: const Text('Location Permission Denied'),
            content: const Text('Please enable location services for Flaq'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
        return null;
      }
      return null;
    }
    if (permissionGranted == LocationPermission.deniedForever) {
      Get.dialog(
        AlertDialog(
          title: const Text('Location Permission Denied'),
          content: const Text(
              'Please enable location services for Flaq in Settings'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      );
      return null;
    }
    return Geolocator.getCurrentPosition();
  }
}
