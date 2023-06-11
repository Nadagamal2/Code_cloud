import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

 import '../components/app_style.dart';
import '../translations/locale_keys.g.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
    bool lang=true;
  final userData =GetStorage();


  @override
  Widget build(BuildContext  ) {
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
          "Language".tr(),
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                LocaleKeys.Change_your_Language.tr(),
                style: TextStyle(
                  color: Styles.defualtColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                )
            ).tr(),
            Gap(30.h),
            ElevatedButton(
              onPressed: () async {

                await  context.setLocale(Locale('en'));
                Get.updateLocale(Locale('en'));
                print( Locale('en'));
                lang=false;
                userData.write('lang', lang);

              },
              child: Text(
                LocaleKeys.English.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(120.h, 43.h),
                maximumSize: Size(120.h, 43.h),
                minimumSize: Size(120.h, 43.h),
                backgroundColor: Styles.defualtColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ),
            Gap(30.h),
            ElevatedButton(
              onPressed: () async {
                await  context.setLocale(Locale('ar'));
                Get.updateLocale(Locale('ar'));
                print( Locale('ar'));
                lang=true;
                userData.write('lang', lang);
              },
              child: Text(
                LocaleKeys.Arabic.tr() ,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(120.h, 43.h),
                maximumSize: Size(120.h, 43.h),
                minimumSize: Size(120.h, 43.h),
                backgroundColor: Styles.defualtColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ),
            // Gap(10.h),
            // InkWell(
            //
            //   child: Container(
            //     height: 45.h,
            //     width: 90.w,
            //     decoration: BoxDecoration(
            //       color: Styles.defualtColor,
            //       borderRadius: BorderRadius.circular(15.r),
            //     ),
            //     child: Center(
            //       child: Text(
            //         "English".tr(),
            //         style: TextStyle(
            //           color: Styles.ScafoldColor,
            //           fontWeight: FontWeight.w600,
            //           fontSize: 18.sp,
            //         ),
            //       ),
            //     ),
            //   ),
            //   onTap: () {
            //     setState(() {
            //       context.setLocale(Locale('en'));
            //     });
            //   },
            // ),
            // Gap(10.h),
            // InkWell(
            //   child: Container(
            //     height: 45.h,
            //     width: 90.w,
            //     decoration: BoxDecoration(
            //       color: Color(0xffBCBCBB),
            //       borderRadius: BorderRadius.circular(15.r),
            //     ),
            //     child: Center(
            //       child: Text(
            //         "Arabic".tr(),
            //         style: TextStyle(
            //           color: Styles.ScafoldColor,
            //           fontWeight: FontWeight.w600,
            //           fontSize: 18.sp,
            //         ),
            //       ),
            //     ),
            //   ),
            //   onTap: () {
            //     setState(() {
            //       context.setLocale(Locale('ar'));
            //       Get.back();
            //     });
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
