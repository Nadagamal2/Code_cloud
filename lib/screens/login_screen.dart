import 'dart:convert';

import 'package:copons/screens/sign_up_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

import '../components/app_style.dart';
import '../translations/locale_keys.g.dart';
import 'bottom_nav.dart';
import 'forgetPassword.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  final userData = GetStorage();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool? isChecked = false;
  void login(
    String email,
    String password,
  ) async {
    try {
      var response = await http.post(
          Uri.parse('http://saudi07-001-site2.itempurl.com/api/auth/Login'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "email": email,
            "password": password,
          }));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var log = json.decode(response.body);

        print('token${log['token']}');
        Map<String, dynamic> payload = Jwt.parseJwt(log['token']);
        var tokenId = payload['Id'];
        var userName = payload['FullName'];
        var Email = payload['Email'];
        var PhoneNumber = payload['PhoneNumber'];
        var ImgUrl = payload['ImgUrl'];
        print('tokenId ${tokenId}');

        print('read token ${userData.read('token')}');
        print('read userName ${userData.read('userName')}');
        print('read Email ${userData.read('Email')}');
        print('read PhoneNumber ${userData.read('PhoneNumber')}');
        print('read ImgUrl ${userData.read('ImgUrl')}');
        print('read IsSubscriped ${userData.read('IsSubscriped')}');

        userData.write('isLogged', true);
        userData.write('isLoggedByGoogle', false);
        userData.write('token', payload['Id']);
        userData.write('userName', payload['FullName']);
        userData.write('Email', payload['Email']);
        userData.write('PhoneNumber', payload['PhoneNumber']);
        userData.write('IsSubscriped', payload['IsSubscriped']);
        userData.write('ImgUrl', payload['ImgUrl']);

        userData.write('email', email);
        userData.write('password', password);
        Get.offAll(BottomNavScreen());

        //  return login.fromJson(jsonDecode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: '${data['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        print("Faild");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
          LocaleKeys.LOG_IN.tr(),
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
              Gap(40.h),
              Image(
                image: AssetImage('assets/logo.png'),
                height: 150.h,
              ),
              Gap(50.h),
              Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return LocaleKeys.please_enter_your_email.tr();
                            }
                          },
                          cursorColor: Colors.grey.shade400,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
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
                              labelText: LocaleKeys.Email.tr(),
                              hintText: LocaleKeys.Email.tr(),
                              labelStyle: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Tajawal7',
                                  color: Colors.grey.shade400),
                              hintStyle: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Tajawal7',
                                  color: Colors.grey.shade400),
                              prefixIcon: Icon(
                                FluentSystemIcons.ic_fluent_mail_filled,
                                color: Colors.grey,
                                size: 24.sp,
                              )),
                        ),
                        Gap(20.h),
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
                      ],
                    ),
                  ),
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Checkbox(
                      //
                      //       activeColor: Styles.defualtColor2,
                      //       side: BorderSide(color: Colors.grey.shade500,width: 1.8),
                      //       value: isChecked, onChanged:(bool? value) {
                      //       setState(() {
                      //         isChecked = value!;
                      //       });
                      //     },),
                      //     Text('ذكرني',style: TextStyle(
                      //       fontSize: 12.sp,
                      //       fontFamily: 'Tajawal7',
                      //       color: Colors.black,
                      //     ),)
                      //   ],
                      // ),

                      InkWell(
                        onTap: () {
                          Get.to(ForgetNumberScreen());
                        },
                        child: Text(
                          LocaleKeys.Forget_Your_Password.tr(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Tajawal7',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(35.h),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        login(emailController.text.toString(),
                            passwordController.text.toString());
                      }
                    },
                    child: Text(
                      LocaleKeys.LOG_IN.tr(),
                      style: TextStyle(
                        color: Styles.defualtColor3,
                        fontFamily: 'Tajawal7',
                        fontSize: 15.sp,
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
                  Gap(20.h),
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
                          Get.to(SignUpScreen());
                        },
                        child: Text(
                          LocaleKeys.Create_an_account.tr(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            decoration: TextDecoration.underline,
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
