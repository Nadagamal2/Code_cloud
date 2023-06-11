 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';
 import 'package:easy_localization/easy_localization.dart';
 import 'package:get/get_core/src/get_main.dart';
 import 'package:get/get_navigation/get_navigation.dart';
import '../components/app_style.dart';
import '../translations/locale_keys.g.dart';
import 'Language_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen ({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool light = true;
  bool light2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              alignment: Alignment.bottomCenter,
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.r),bottomRight: Radius.circular(25.r)),
              ),
              child: Padding(
                padding:   EdgeInsets.symmetric(horizontal: 15.h,vertical: 28.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                          height: 20.h,
                          width: 20.h,

                          decoration: BoxDecoration(
                            color: Styles.defualtColor3,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(0.r),

                          ),
                          child:  Icon(Icons.arrow_back,size: 19.h,)
                      ),
                    ),
                    Gap(95.h),
                    Text(LocaleKeys.Settings.tr(), style: TextStyle(
                      fontFamily: 'Tajawal2',
                      color: Styles.defualtColor2,
                      fontSize: 18.sp,
                    ),),

                  ],
                ),
              ),
            ),

            Gap(5.h),


            Padding(
              padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 8.h),
              child: Column(

                children: [





                  Container(
                      height: 50.h,
                      width: double.infinity,

                      decoration: BoxDecoration(
                        color: Styles.defualtColor3,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15.r),

                      ),
                      child:  Padding(
                        padding:    EdgeInsets.symmetric(horizontal:20.h,vertical: 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text(LocaleKeys.Notifications.tr(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Tajawal2',

                              ),


                            ),
                        Switch(
                          // This bool value toggles the switch.
                          value: light,
                          activeColor: Styles.defualtColor,
                           onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              light = value;
                            });
                          },
                        ),

                          ],
                        ),
                      )
                  ),

                ],
              ),
            ),
            Padding(
              padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 8.h),
              child: Column(

                children: [





                  Container(
                      height: 50.h,
                      width: double.infinity,

                      decoration: BoxDecoration(
                        color: Styles.defualtColor3,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15.r),

                      ),
                      child:  Padding(
                        padding:    EdgeInsets.symmetric(horizontal:20.h,vertical: 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text(LocaleKeys.Dark_mode.tr(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Tajawal2',

                              ),


                            ),
                            Switch(
                              // This bool value toggles the switch.
                              value: light2,
                              activeColor: Styles.defualtColor,
                              onChanged: (bool value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  light2 = value;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
