import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';



class RatingController extends GetxController {
  int currentRating = 0;
  final box = GetStorage();
  SharedPreferences? prefs;

  @override
  void onInit() { // called whenever we initialize the controller
    super.onInit();
    currentRating = box.read('rating') ?? 0; // initializing current rating from storage or 0 if storage is null
  }
  Future<void> initSp() async {
    prefs = await SharedPreferences.getInstance();
    currentRating = prefs!.getInt('rating') ?? 0;
  }
  // void updateAndStoreRating(int rating) {
  //   currentRating = rating;
  //   box.write('rating', rating); // stores to local database
  //   update(); // triggers a rebuild of the GetBuilder Widget
  // }

  Widget buildRatingStar(int index) {
    if (index < currentRating) {
      return Icon(
        Icons.star,
        color: Colors.yellow,
        size: 20.h,
      );
    } else {
      return Icon(
        Icons.star,
        size: 20.h,
        color: Colors.grey,
      );
    }
  }
  void updateAndStoreRating(int rating) {
    currentRating = rating;
    prefs!.setInt('rating', rating); //SharedPreferences way
    update(); // triggers a rebuild of the GetBuilder Widget
  }
}