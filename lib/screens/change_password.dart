import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../components/app_style.dart';
import '../components/component.dart';
import '../translations/locale_keys.g.dart';
import 'donePassword_screen.dart';
class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final userData =GetStorage();

  final OldPaasswordController=TextEditingController();
  final NewPasswordController=TextEditingController();
  final ConfirmNewPasswordController=TextEditingController();

  void changePassword({
    required dynamic OldPaassword,
    required dynamic NewPassword,
    required dynamic ConfirmNewPassword,
  }) async {
    var response = await http.post(
        Uri.parse('http://saudi07-001-site2.itempurl.com/api/auth/EditePassword/${userData.read('token')}'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "OldPaassword": OldPaassword,
          "NewPassword": NewPassword,
          "ConfirmNewPassword": ConfirmNewPassword
        }
        ));
    if (response.statusCode == 200) {
      var data=jsonDecode(response.body.toString());
      print('done');
      userData.write("isChanged", true);
      userData.write('NewPassword', NewPassword);
      userData.write('ConfirmNewPassword', ConfirmNewPassword);
      print( data);
      Get.offAll(DonePassScreen());

    } else {
      print('fail');
    }


  }

  @override
  void dispose() {
    OldPaasswordController.dispose();
    NewPasswordController.dispose();
    ConfirmNewPasswordController.dispose();


    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:   Padding(
        padding:   EdgeInsets.symmetric(horizontal: 20.h),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text( LocaleKeys.Change_Your_Password.tr(),style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),),
              Gap(40.h),
              TextFormField(
                cursorColor: Colors.grey.shade400,
                keyboardType: TextInputType.text,

                controller: OldPaasswordController,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 3.h, horizontal: 10.h),
                    filled: true,
                    fillColor: Color(0xffF6F5F5),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: .1.r, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: .1.r, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    labelText: LocaleKeys.Old_Password.tr(),
                    hintText:LocaleKeys.Old_Password.tr(),
                    labelStyle: TextStyle(
                        fontSize: 15.sp, color: Colors.grey.shade400),
                    hintStyle: TextStyle(
                        fontSize: 15.sp, color: Colors.grey.shade400)),
              ),

              Gap(15.h),
              TextFormField(
                cursorColor: Colors.grey.shade400,
                keyboardType: TextInputType.text,

                controller: NewPasswordController,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 3.h, horizontal: 10.h),
                    filled: true,
                    fillColor: Color(0xffF6F5F5),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: .1.r, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: .1.r, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    labelText: LocaleKeys.New_Password.tr(),
                    hintText: LocaleKeys.New_Password.tr(),
                    labelStyle: TextStyle(
                        fontSize: 15.sp, color: Colors.grey.shade400),
                    hintStyle: TextStyle(
                        fontSize: 15.sp, color: Colors.grey.shade400)),
              ),

              Gap(15.h),
              TextFormField(
                cursorColor: Colors.grey.shade400,
                keyboardType: TextInputType.text,

                controller: ConfirmNewPasswordController,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 3.h, horizontal: 10.h),
                    filled: true,
                    fillColor: Color(0xffF6F5F5),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: .1.r, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: .1.r, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    labelText: LocaleKeys.Confirm_Password.tr(),
                    hintText:  LocaleKeys.Confirm_Password.tr(),
                    labelStyle: TextStyle(
                        fontSize: 15.sp, color: Colors.grey.shade400),
                    hintStyle: TextStyle(
                        fontSize: 15.sp, color: Colors.grey.shade400)),
              ),
              Gap(80.h),
              buildBottum(
                height: 52,
                decoration: BoxDecoration(
                  color: Styles.defualtColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                width: double.infinity,

                text: Text(
                  LocaleKeys.Change.tr(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  changePassword(OldPaassword: OldPaasswordController.text.toString(), NewPassword: NewPasswordController.text.toString(), ConfirmNewPassword: ConfirmNewPasswordController.text.toString());



                },
              ),
              Gap(20.h),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                      LocaleKeys.Back.tr(),
                      style:  TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp
                      )
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
