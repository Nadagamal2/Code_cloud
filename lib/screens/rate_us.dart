import 'package:copons/components/ratingController.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
  import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../components/app_style.dart';
import '../translations/locale_keys.g.dart';

 class Rate extends StatefulWidget {
  const Rate({Key? key}) : super(key: key);

  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {
  static const id = 'rating_page'; // see GetMaterialApp for this usage

  final controller = Get.find<RatingController>(); // finding the same instance of initialized controller

  Widget _buildBody() {
    final stars = List<Widget>.generate(5, (index) {
      return GetBuilder<RatingController>( // rebuilds when update() is called from GetX class
        builder: (controller) => Expanded(
          child: GestureDetector(
            child: controller.buildRatingStar(index),
            onTap: () {
              controller.updateAndStoreRating(index + 1); // +1 because index starts at 0 otherwise the star rating is offset by one
            },
          ),
        ),
      );
    });
    return Padding(
      padding:   EdgeInsets.symmetric(horizontal: 50.h),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: stars,
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                controller.updateAndStoreRating(0);
              },
              child: Text(
                LocaleKeys.Cancel.tr(),
                style: TextStyle(color: Colors.grey,fontSize: 10.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.h,
        elevation: 0,
        backgroundColor: Styles.defualtColor,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 30,
            )),
        centerTitle: true,
        title: Text(
          LocaleKeys.Rate_us.tr(),
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
      ),
body: Center(
  child:   Column(

    mainAxisAlignment: MainAxisAlignment.center,

    crossAxisAlignment: CrossAxisAlignment.center,

    children: [
    Padding(
      padding:   EdgeInsets.symmetric(horizontal: 20.h),
      child: Container(
      height: 200.h,

      width: double.infinity,
      decoration: BoxDecoration(
        color: Styles.defualtColor5,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(
                0, 3), // changes position of shadow
          ),

        ],
        borderRadius: BorderRadius.circular(15.r),
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildBody(),
          Gap(20.h),
          InkWell(
            onTap: () {
              Get.back();

            },
            child: Container(
              height: 30.h,
              width: 60.h,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(10.r),
                gradient: LinearGradient(
                  begin: Alignment(.8.h, -.7.h),
                  end: Alignment(0.8.h, 1.h),
                  colors: [
                    Color(0xffC3A358),
                    Color(0xffE2CD6D),
                    Color(0xffC39528),

                    //C3A358
                    //E2CD6D
                    //C39528
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  LocaleKeys.Ok.tr(),
                  style: TextStyle(
                    fontFamily: 'Tajawal2',
                    color: Colors.black,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),),
    ),



    ],

  ),
),
    );
  }
}
