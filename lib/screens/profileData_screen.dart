import 'dart:convert';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/app_style.dart';
import '../components/component.dart';
import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';


import 'package:http/http.dart' as http;

import 'change_password.dart';
import 'edit_account.dart';

class ProfileDataScreen extends StatefulWidget {
  const ProfileDataScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDataScreen> createState() => _ProfileDataScreenState();
}

class _ProfileDataScreenState extends State<ProfileDataScreen> {
  final userData = GetStorage();
  // Future<ProfileDataModel?> accountDetail() async {
  //   try {
  //     var response = await http.post(
  //       Uri.parse(
  //           'http://eibtekone-001-site18.atempurl.com/api/auth/GetAccountData/${userData.read('token')}'),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print(userData.read('token'));
  //       var data = jsonDecode(response.body.toString());
  //       print(data);
  //       return ProfileDataModel.fromJson(jsonDecode(response.body));
  //     } else {
  //       print('fail');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 65.h,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Styles.defualtColor,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 30.sp,
            )),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 17.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Gap(30.h),
                    Container(
                      height: 44.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffF6F5F5),
                        borderRadius: BorderRadius.circular(11.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.h),
                        child: Row(
                          children: [
                            Icon(
                              FluentSystemIcons.ic_fluent_person_regular,
                              color: Styles.defualtColor,
                            ),
                            Gap(15.h),
                            Text(
                                '${userData.read('FullName')}',
                                style:  TextStyle(color: Color(0xffB6B6B6), fontWeight: FontWeight.w600,fontSize: 12.sp,)
                            )
                          ],
                        ),
                      ),
                    ),
                    Gap(10.h),
                    Container(
                      height: 44.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffF6F5F5),
                          borderRadius: BorderRadius.circular(11.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.h),
                        child: Row(
                          children: [
                            Icon(
                              FluentSystemIcons.ic_fluent_phone_regular,
                              color: Styles.defualtColor,
                            ),
                            Gap(15.h),
                            Text(
                                '${userData.read('PhoneNumbe')}',
                              style:  TextStyle(color: Color(0xffB6B6B6), fontWeight: FontWeight.w600,fontSize: 12.sp,)
                            )
                          ],
                        ),
                      ),
                    ),
                    Gap(10.h),
                    Container(
                      height: 44.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffF6F5F5),
                        borderRadius: BorderRadius.circular(11.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.h),
                        child: Row(
                          children: [
                            Icon(
                              FluentSystemIcons.ic_fluent_mail_regular,
                              color: Styles.defualtColor,
                            ),
                            Gap(15.h),
                            Text(
                                '${userData.read('Email')}',
                                style:  TextStyle(color: Color(0xffB6B6B6), fontWeight: FontWeight.w600,fontSize: 12.sp,)
                            )
                          ],
                        ),
                      ),
                    ),
                    Gap(50.h),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(EditProfileScreen());

                      },
                      child: Text(
                        LocaleKeys.Modify_your_Account.tr(),
                        style: TextStyle(
                          color: Styles.defualtColor3,
                          fontFamily: 'Tajawal7',
                          fontSize: 14.sp,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(double.infinity, 45.h),
                        maximumSize: Size(double.infinity, 45.h),
                        minimumSize: Size(double.infinity, 45.h),
                        backgroundColor: Styles.defualtColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.r),
                        ),
                      ),
                    ),
                    Gap(20.h),
                    ElevatedButton(
                      onPressed: () {
                         Get.to(EditPasswordScreen());
                      },
                      child: Text(
                        LocaleKeys.Change_Your_Password.tr(),
                        style: TextStyle(
                          color: Styles.defualtColor3,
                          fontFamily: 'Tajawal7',
                          fontSize: 14.sp,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(double.infinity, 45.h),
                        maximumSize: Size(double.infinity, 45.h),
                        minimumSize: Size(double.infinity, 45.h),
                        backgroundColor: Styles.defualtColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(50.h),
              TextButton(
                  onPressed: () {
                    Get.back();
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
        )
      ),
    );
  }
}
