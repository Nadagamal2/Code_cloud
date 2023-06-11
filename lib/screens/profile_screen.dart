import 'package:copons/components/app_style.dart';
import 'package:copons/screens/bottom_nav.dart';
import 'package:copons/screens/permission_screen.dart';
import 'package:copons/screens/profileData_screen.dart';
import 'package:copons/screens/question_screen.dart';
import 'package:copons/screens/rate_us.dart';
import 'package:copons/screens/setting_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:gap/gap.dart';
 import 'package:get_storage/get_storage.dart';

import '../translations/locale_keys.g.dart';
import 'Language_screen.dart';
import 'country_screen.dart';
import 'login_screen.dart';
import 'noon_ticket.dart';
class ProfileScreen extends StatelessWidget {
    ProfileScreen({Key? key}) : super(key: key);
  final userData = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar:   AppBar(
  backgroundColor: Styles.defualtColor2,
  centerTitle: true,
  elevation: 0,
  automaticallyImplyLeading: false,
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.r),bottomRight:Radius.circular(25.r) )
  ),

  title:  Text("Profile".tr(), style: TextStyle(
    fontFamily: 'Tajawal2',
    color: Styles.defualtColor3,
    fontSize: 18.sp,
  ),),
  toolbarHeight: 70.h,


),

      body: SingleChildScrollView(
        child: Column(
          children: [

            Gap(5.h),

            Padding(
              padding:    EdgeInsets.only(  top: 22.h),
              child: Column(

                children: [

                  userData.read('isLogged')==true?  buildProfile(
                    text:  '${userData.read('FullName')}',
                    icon: FluentSystemIcons.ic_fluent_person_regular,
                    onTap: (){
                      Get.to(ProfileDataScreen());
                    }
                  ): buildProfile(
                  text: LocaleKeys.Login_Please.tr(),
                  icon: FluentSystemIcons.ic_fluent_person_regular,
                  onTap: (){
                    showDialog(
                                                            context: context,
                                                            builder: (context) => Dialog(
                                                              shape:
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      30)),
                                                              child: Container(
                                                                height: 210,
                                                                width: 250,
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      35.h,
                                                                      vertical: 15.h),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      Text(
                                                                        LocaleKeys
                                                                            .You_are_not_subscribed
                                                                            .tr(),
                                                                        style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                          fontSize: 17.sp,
                                                                        ),
                                                                      ),
                                                                      Gap(20.h),
                                                                      Text(
                                                                        LocaleKeys
                                                                            .Move_to_Login_screen
                                                                            .tr(),
                                                                        style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                          color: Styles
                                                                              .defualtColor2,
                                                                          fontSize: 14.sp,
                                                                        ),
                                                                      ),
                                                                      Gap(10.h),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap: () {
                                                                              Get.back();
                                                                            },
                                                                            child:
                                                                            Container(
                                                                              height:
                                                                              35.h,
                                                                              width: 50.h,
                                                                              decoration:
                                                                              BoxDecoration(
                                                                                borderRadius:
                                                                                BorderRadius.circular(
                                                                                    5.h),
                                                                                color: Styles
                                                                                    .defualtColor,
                                                                              ),
                                                                              child:
                                                                              Center(
                                                                                child:
                                                                                Text(
                                                                                  LocaleKeys.Cancel
                                                                                      .tr(),
                                                                                  style:
                                                                                  TextStyle(
                                                                                    fontWeight:
                                                                                    FontWeight.w500,
                                                                                    color:
                                                                                    Styles.defualtColor3,
                                                                                    fontSize:
                                                                                    14.sp,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Gap(20.h),
                                                                          InkWell(
                                                                            onTap: () {
                                                                              Get.to(
                                                                                  LoginScreen());
                                                                            },
                                                                            child:
                                                                            Container(
                                                                              height:
                                                                              35.h,
                                                                              width: 50.h,
                                                                              decoration:
                                                                              BoxDecoration(
                                                                                borderRadius:
                                                                                BorderRadius.circular(
                                                                                    5.h),
                                                                                color: Styles
                                                                                    .defualtColor,
                                                                              ),
                                                                              child:
                                                                              Center(
                                                                                child:
                                                                                Text(
                                                                                  LocaleKeys.Ok
                                                                                      .tr(),
                                                                                  style:
                                                                                  TextStyle(
                                                                                    fontWeight:
                                                                                    FontWeight.w500,
                                                                                    color:
                                                                                    Styles.defualtColor3,
                                                                                    fontSize:
                                                                                    14.sp,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ));
                    Fluttertoast.showToast(
                        msg: LocaleKeys.Login_Please.tr(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
              ),
                  // buildProfile(
                  //   text:    LocaleKeys.Favorite.tr(),
                  //   icon: FluentSystemIcons.ic_fluent_heart_regular,
                  //   onTap: (){}
                  // ),
                  // buildProfile(
                  //     text: LocaleKeys.Contact_Us.tr(),
                  //     icon: FluentSystemIcons.ic_fluent_mail_regular,
                  //     onTap: (){}
                  // ),

                  buildProfile(
                      text: LocaleKeys.Language_.tr(),
                      icon: FluentSystemIcons.ic_fluent_local_language_regular,
                      onTap: (){ Get.to(LanguageScreen());}
                  ),
                  buildProfile(
                      text:LocaleKeys.Rate_us.tr(),
                      icon: FluentSystemIcons.ic_fluent_star_regular,
                      onTap: (){
                        Get.to(Rate());
                      }
                  ),
                  buildProfile(
                      text:LocaleKeys.Common_questions.tr(),
                      icon: FluentSystemIcons.ic_fluent_help_circle_regular,
                      onTap: (){
                        Get.to(QuestionScreen());
                      }
                  ),    buildProfile(
                      text:LocaleKeys.Country.tr(),
                      icon: FluentSystemIcons.ic_fluent_location_regular,
                      onTap: (){
                        Get.to(MapScreen());
                      }
                  ),
                  buildProfile(
                      text:LocaleKeys.Terms_and_Conditions.tr(),
                      icon: FluentSystemIcons.ic_fluent_notepad_regular,
                      onTap: (){Get.to(PermissionScreen());}
                  ),
                  // buildProfile(
                  //     text:LocaleKeys.Settings.tr(),
                  //     icon: FluentSystemIcons.ic_fluent_settings_regular,
                  //     onTap: (){
                  //       Get.to(SettingScreen());
                  //     }
                  // ),
                  buildProfile(
                      text:LocaleKeys.Log_out.tr(),
                      icon: Icons.logout,
                      onTap: (){
                        userData.write('isLogged', false);

                        userData.remove('name');
                        userData.remove('img');
                        userData.remove('email');
                        userData.remove('email');
                        userData.remove('password');

                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(LocaleKeys.Log_out.tr()),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    LocaleKeys.Are_you_sure_to_leave.tr(),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Get.offAll(() => BottomNavScreen()),
                                    child: Text(
                                      LocaleKeys.Ok.tr(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )),
                                TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text(
                                      LocaleKeys.Cancel.tr(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            ));
                      }
                  ),
                  Gap(15.h),









                ],
              ),
            ),



          ],
        ),
      ),
    );
  }
}
Widget buildProfile({
  required IconData icon,
  required String text,
  required Function() onTap,
})=> InkWell(
  onTap: onTap,
  child: Padding(
    padding:    EdgeInsets.only(  top: 18.h),
    child: Column(

      children: [
        Padding(
          padding:   EdgeInsets.only( left: 20.h,right: 20.h),
          child: Container(
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
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Icon(icon ,color: Styles.defualtColor,),
                    Gap(10.h),
                    Text(text,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Tajawal2',

                      ),
                    ),


                  ],
                ),
              )
          ),
        ),



      ],
    ),
  ),
);