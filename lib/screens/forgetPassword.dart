import 'dart:convert';


import 'package:copons/components/component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../components/app_style.dart';
import '../translations/locale_keys.g.dart';
import 'checkemail.dart';


class ForgetNumberScreen extends StatefulWidget {
  const ForgetNumberScreen({Key? key}) : super(key: key);

  @override
  State<ForgetNumberScreen> createState() => _ForgetNumberScreenState();
}

class _ForgetNumberScreenState extends State<ForgetNumberScreen> {
  final userData =GetStorage();
  final emailController=TextEditingController();
  void forget(String email)async{
    try{
      var request = http.Request('POST', Uri.parse('http://saudi07-001-site2.itempurl.com/api/auth/ForgetPassword/${email}'));


      var streamedResponse  = await request.send();
      var response   = await http.Response.fromStream(streamedResponse);
      final result = jsonDecode(response .body) as Map<String, dynamic>;
      print(result['isSuccess']);
      if (result['isSuccess']==true) {
        print(result);
        Get.to(CheckEmail());

      }else {
        print('response.reasonPhrase');
      }


    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 50.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30.sp,
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 33.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Image.asset(
                        'assets/99.png',
                        fit: BoxFit.cover,
                        height: 130.h,
                        width: 130.h,
                        color: Colors.grey.shade600,
                      )),
                  Gap(20.h),
                  Text(
                    LocaleKeys.Forget_Your_Password.tr(),
                    style: TextStyle(
                      color: Styles.defualtColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(12.h),
                  Text(
                    LocaleKeys.Provide_your_email.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Gap(32.h),
                  defaultFieldForm(
                    controller: emailController,
                    padding: EdgeInsets.symmetric(vertical: 3),
                    Type: TextInputType.emailAddress,
                    prefix: FluentSystemIcons.ic_fluent_mail_regular,
                    lable: "Email".tr(),
                    hint: "Email".tr(),
                  ),
                  Gap(60.h),
                  buildBottum(
                    height: 42.h,
                    width: 290.h,
                    decoration: BoxDecoration(
                      color: Styles.defualtColor,
                      borderRadius: BorderRadius.circular(7.5.r),
                    ),
                    text: Text(
                      LocaleKeys.Next.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:  Color(0xffffffff),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                    onTap: () {
                      forget(emailController.text.toString());

                    },
                  ),
                  Gap(8.h),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Back".tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget defaultFieldForm({
  required TextInputType Type,
  required IconData prefix,
  required String lable,
  required String hint,
  required EdgeInsets? padding,
  String? Function(String?)? validator,
  String? Function(String?)? onChanged,
  TextEditingController? controller,
}) =>
    TextFormField(
      validator: validator,
      onChanged: onChanged,
      cursorColor: Colors.grey.shade400,
      keyboardType: Type,
      controller: controller,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: padding,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: .5.h),
          borderRadius: BorderRadius.circular(6.r),
        ),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: .5.h),
          borderRadius: BorderRadius.circular(6.r),
        ),
        prefixIcon: Icon(
          prefix,
          size: 20.sp,
          color: Styles.defualtColor,
        ),
        labelText: lable,
        hintText: hint,
      ),
    );
