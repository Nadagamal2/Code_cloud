import 'dart:convert';

import 'package:copons/screens/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:get_storage/get_storage.dart';
 import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../components/app_style.dart';
import '../translations/locale_keys.g.dart';
import 'bottom_nav.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  final userNameController = new TextEditingController();
  final PhoneNumberController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmPasswordController = new TextEditingController();
  bool? isChecked = false;
  final userData = GetStorage();
  void re(
    String FullName,
    PhoneNumber,
    email,
    password,
    confirmPassword,
  ) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://saudi07-001-site2.itempurl.com/api/auth/Register/1'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "FullName": FullName,
            "PhoneNumber": PhoneNumber,
            "email": email,
            "password": password,
            "confirmPassword": confirmPassword
          }));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        print(await response.body);
        var log = json.decode(response.body);
        print('token${log['token']}');
        Map<String, dynamic> payload = Jwt.parseJwt(log['token']);
        var tokenId = payload['Id'];
        var Email = payload['Email'];
        var PhoneNumbe = payload['PhoneNumbe'];
        var CountId = payload['CountId'];
        print('tokenId ${tokenId}');
        print('read token ${userData.read('token')}');
        print('read token ${userData.read('CountId')}');
        print('read IsSubscriped ${userData.read('IsSubscriped')}');

        userData.write('IsSubscriped', payload['IsSubscriped']);

        userData.write('isLogged', true);
        userData.write('Email', payload['Email']);
        userData.write('PhoneNumbe', payload['PhoneNumber']);
        userData.write('FullName', payload['FullName']);
        userData.write('CountId', payload['CountId']);
        userData.write('token', payload['Id']);
        // userData.write('email', email);
        // userData.write('password', password);
        // userData.write('confirmPassword', confirmPassword);

        Get.offAll(BottomNavScreen());
      } else {
        Fluttertoast.showToast(
            msg: '${data['errors']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        print(await response.body);
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    PhoneNumberController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.h,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          LocaleKeys.sign_Up.tr(),
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal2',
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(10.h),
              Image(
                image: AssetImage('assets/logo.png'),
                height: 110.h,
              ),
              Gap(10.h),
              Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return LocaleKeys.please_enter_your_name.tr();
                            }
                          },
                          cursorColor: Colors.grey.shade400,
                          keyboardType: TextInputType.name,
                          controller: userNameController,
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.h),
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
                              labelText: LocaleKeys.User_Name.tr(),
                              hintText: LocaleKeys.User_Name.tr(),
                              labelStyle: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Tajawal7',
                                  color: Colors.grey.shade400),
                              hintStyle: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Tajawal7',
                                  color: Colors.grey.shade400),
                              prefixIcon: Icon(
                                FluentSystemIcons.ic_fluent_phone_filled,
                                color: Colors.grey,
                                size: 24.sp,
                              )),
                        ),
                        Gap(18.h),
                        TextFormField(
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return LocaleKeys.please_enter_your_number.tr();
                            }
                          },
                          cursorColor: Colors.grey.shade400,
                          keyboardType: TextInputType.number,
                          controller: PhoneNumberController,
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.h),
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
                              labelText: LocaleKeys.phone_Number.tr(),
                              hintText:  LocaleKeys.phone_Number.tr(),
                              labelStyle: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Tajawal7',
                                  color: Colors.grey.shade400),
                              hintStyle: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Tajawal7',
                                  color: Colors.grey.shade400),
                              prefixIcon: Icon(
                                FluentSystemIcons.ic_fluent_phone_filled,
                                color: Colors.grey,
                                size: 24.sp,
                              )),
                        ),
                        // Gap(18.h),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     SizedBox(
                        //       width: 140.h,
                        //       child: TextFormField(
                        //
                        //
                        //         cursorColor: Colors.grey.shade400,
                        //         keyboardType: TextInputType.text,
                        //         controller: emailController,
                        //         decoration: InputDecoration(
                        //             floatingLabelBehavior: FloatingLabelBehavior.never,
                        //             contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.h),
                        //             filled: true,
                        //             fillColor: Color(0xffF6F5F5),
                        //
                        //
                        //             focusedBorder: OutlineInputBorder(
                        //               borderSide: BorderSide(width: .1.r,color: Colors.transparent),
                        //               borderRadius: BorderRadius.circular(10),
                        //             ),
                        //             border: OutlineInputBorder(),
                        //
                        //             enabledBorder: OutlineInputBorder(
                        //               borderSide: BorderSide(width: .1.r,color: Colors.transparent),
                        //               borderRadius: BorderRadius.circular(10.r),
                        //             ),
                        //
                        //
                        //             labelText:    'الإسم الأول',
                        //             hintText:  'الإسم الأول',
                        //             labelStyle: TextStyle(
                        //                 fontSize: 13.sp,
                        //                 fontFamily: 'Tajawal7',
                        //                 color: Colors.grey.shade400
                        //             ),
                        //
                        //             hintStyle: TextStyle(
                        //                 fontSize: 13.sp,
                        //                 fontFamily: 'Tajawal7',
                        //                 color: Colors.grey.shade400
                        //             ),
                        //
                        //
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 140.h,
                        //       child: TextFormField(
                        //
                        //
                        //         cursorColor: Colors.grey.shade400,
                        //         keyboardType: TextInputType.text,
                        //         controller: emailController,
                        //         decoration: InputDecoration(
                        //             floatingLabelBehavior: FloatingLabelBehavior.never,
                        //             contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.h),
                        //             filled: true,
                        //             fillColor: Color(0xffF6F5F5),
                        //
                        //
                        //             focusedBorder: OutlineInputBorder(
                        //               borderSide: BorderSide(width: .1.r,color: Colors.transparent),
                        //               borderRadius: BorderRadius.circular(10),
                        //             ),
                        //             border: OutlineInputBorder(),
                        //
                        //             enabledBorder: OutlineInputBorder(
                        //               borderSide: BorderSide(width: .1.r,color: Colors.transparent),
                        //               borderRadius: BorderRadius.circular(10.r),
                        //             ),
                        //
                        //
                        //             labelText:    'إسم العائلة',
                        //             hintText:    'إسم العائلة',
                        //             labelStyle: TextStyle(
                        //                 fontSize: 13.sp,
                        //                 fontFamily: 'Tajawal7',
                        //                 color: Colors.grey.shade400
                        //             ),
                        //
                        //             hintStyle: TextStyle(
                        //                 fontSize: 13.sp,
                        //                 fontFamily: 'Tajawal7',
                        //                 color: Colors.grey.shade400
                        //             ),
                        //
                        //
                        //         ),
                        //       ),
                        //     ),
                        //
                        //   ],
                        // ),
                        Gap(18.h),
                        TextFormField(
                          cursorColor: Colors.grey.shade400,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return LocaleKeys.please_enter_your_email.tr();
                            }
                          },
                          decoration: InputDecoration(
                            floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3.h, horizontal: 10.h),
                            filled: true,
                            isDense: true,
                            fillColor: Color(0xffF6F5F5),
                            // suffixText: 'إختياري',

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

                            labelText: LocaleKeys.Email.tr(),
                            hintText: LocaleKeys.Email.tr(),
                            labelStyle: TextStyle(
                                fontFamily: 'Tajawal7',
                                fontSize: 13.sp,
                                color: Colors.grey.shade400),

                            hintStyle: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: 'Tajawal7',
                                color: Colors.grey.shade400),
                            prefixIcon: Icon(
                              FluentSystemIcons.ic_fluent_mail_filled,
                              size: 24.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Gap(18.h),
                        TextFormField(
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return LocaleKeys.please_enter_your_password.tr();
                            }
                          },
                          cursorColor: Colors.grey.shade400,
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                              labelText: LocaleKeys.Password_.tr(),
                              hintText: LocaleKeys.Password_.tr(),
                              labelStyle: TextStyle(
                                  fontFamily: 'Tajawal7',
                                  fontSize: 13.sp,
                                  color: Colors.grey.shade400),
                              hintStyle: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Tajawal7',
                                  color: Colors.grey.shade400),
                              prefixIcon: Icon(
                                FluentSystemIcons.ic_fluent_lock_filled,
                                size: 24.sp,
                                color: Colors.grey,
                              )),
                        ),
                        Gap(18.h),
                        TextFormField(
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return LocaleKeys.please_enter_your_password_again.tr();
                            }
                          },
                          cursorColor: Colors.grey.shade400,
                          keyboardType: TextInputType.text,
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                              hintText: LocaleKeys.Confirm_Password.tr(),
                              labelStyle: TextStyle(
                                  fontFamily: 'Tajawal7',
                                  fontSize: 13.sp,
                                  color: Colors.grey.shade400),
                              hintStyle: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Tajawal7',
                                  color: Colors.grey.shade400),
                              prefixIcon: Icon(
                                FluentSystemIcons.ic_fluent_lock_filled,
                                size: 24.sp,
                                color: Colors.grey,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Gap(40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        activeColor: Styles.defualtColor2,
                        side: BorderSide(
                            color: Colors.grey.shade500, width: 1.8),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                            userData.write('select', value);
                            print(value);
                          });
                        },

                      ),
                      Text(
                        LocaleKeys.Accept_all.tr(),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontFamily: 'Tajawal7',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        LocaleKeys.Terms_and_Conditions.tr(),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontFamily: 'Tajawal7',
                          color: Styles.defualtColor,
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate() &&
                          passwordController.text == confirmPasswordController.text&&userData.read('select')==true
                      ) {
                        re(
                            userNameController.text.toString(),
                            PhoneNumberController.text.toString(),
                            emailController.text.toString(),
                            passwordController.text.toString(),
                            confirmPasswordController.text.toString());
                      }
                    },
                    child: Text(
                      LocaleKeys.sign_Up.tr(),
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
                      backgroundColor: Styles.defualtColor2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                  ),
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.Dont_have_an_account.tr(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Tajawal2',
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(LoginScreen());
                        },
                        child: Text(
                          LocaleKeys.Login.tr(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Tajawal2',
                            color: Styles.defualtColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
