import 'package:copons/screens/bottom_nav.dart';
import 'package:copons/screens/ticket_screen.dart';
import 'package:copons/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
class WaitScreen extends StatelessWidget {
  const WaitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(LocaleKeys.Service_in_progress.tr(),
              style: TextStyle(
                fontFamily: 'Tajawal2',
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            Gap(30.h),
            TextButton(
                onPressed: () {
                  Get.offAll(BottomNavScreen());
                },
                child: Text(
                  LocaleKeys.Back.tr(),
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                )),

          ],
        ),
      ),
    );
  }
}
