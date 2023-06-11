import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
 import 'package:jwt_decode/jwt_decode.dart';

 import '../components/app_style.dart';
import '../components/component.dart';
import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'done_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final userData = GetStorage();

  final userNameController = new TextEditingController();
  final PhoneNumberController = new TextEditingController();
  final emailController = new TextEditingController();

  var formKey = GlobalKey<FormState>();
void edit(  String FullName,
    PhoneNumber,
    email,)async{
  var request = http.MultipartRequest('POST', Uri.parse('http://saudi07-001-site2.itempurl.com/api/auth/EditeAccount/${userData.read('token')}'));
  request.fields.addAll({
    'Email': email,
    'Name': FullName,
    'Phone': PhoneNumber
  });


  var streamedResponse  = await request.send();
  var response   = await http.Response.fromStream(streamedResponse);
  final result = jsonDecode(response .body) as Map<String, dynamic>;

  if (response.statusCode == 200) {
    print(result);
    print(result['token']);
    Map<String, dynamic> payload = Jwt.parseJwt(result['token']);
    var  tokenId=payload['Id'];
    var userName=payload['FullName'];
    var Email=payload['Email'];
    var PhoneNumber=payload['PhoneNumber'];


    userData.write('Email', payload['Email']);
    userData.write('PhoneNumbe', payload['PhoneNumber']);
    userData.write('FullName', payload['FullName']);
     userData.write('token', payload['Id']);
     print(result);

    Get.offAll(DoneScreen());
  }
  else {
  print(response.reasonPhrase);
  Fluttertoast.showToast(
      msg: '${response.reasonPhrase}',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Styles.defualtColor,
      timeInSecForIosWeb: 1,
      textColor: Colors.black,
      fontSize: 16.0);

  }
}
  void editProfile(
      String FullName,
      PhoneNumber,
      email,

      ) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://saudi07-001-site2.itempurl.com/api/auth/EditeAccount/${userData.read('token')}'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "FullName": FullName,
            "PhoneNumber": PhoneNumber,
            "email": email,

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

        userData.write('isLogged', true);
        userData.write('Email', payload['Email']);
        userData.write('PhoneNumbe', payload['PhoneNumber']);
        userData.write('FullName', payload['FullName']);
        userData.write('CountId', payload['CountId']);
        userData.write('token', payload['Id']);
        // userData.write('email', email);
        // userData.write('password', password);
        // userData.write('confirmPassword', confirmPassword);

        Get.offAll(DoneScreen());
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

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(70.h),
              Text(
                LocaleKeys.Modify_your_Account.tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(30.h),

              Gap(30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Colors.grey.shade400,
                        keyboardType: TextInputType.text,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return LocaleKeys.Please_Enter_Your_Updated_Name.tr();
                          }
                        },
                        controller: userNameController,
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
                            labelText: LocaleKeys.new_user_name.tr(),
                            hintText: LocaleKeys.new_user_name.tr(),
                            labelStyle: TextStyle(
                                fontSize: 15.sp, color: Colors.grey.shade400),
                            hintStyle: TextStyle(
                                fontSize: 15.sp, color: Colors.grey.shade400)),
                      ),
                      Gap(15.h),
                      TextFormField(
                        cursorColor: Colors.grey.shade400,
                        keyboardType: TextInputType.number,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return LocaleKeys.Please_Enter_Your_Updated_Number.tr();
                          }
                        },
                        controller: PhoneNumberController,
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
                            labelText: LocaleKeys.new_phone_number.tr(),
                            hintText:LocaleKeys.new_phone_number.tr(),
                            labelStyle: TextStyle(
                                fontSize: 15.sp, color: Colors.grey.shade400),
                            hintStyle: TextStyle(
                                fontSize: 15.sp, color: Colors.grey.shade400)),
                      ),
                      Gap(15.h),
                      TextFormField(
                        cursorColor: Colors.grey.shade400,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return LocaleKeys.Please_Enter_Your_Updated_Email.tr();
                          }
                        },
                        controller: emailController,
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
                            labelText: LocaleKeys.new_email.tr(),
                            hintText: LocaleKeys.new_email.tr(),
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
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          if (formKey.currentState!.validate()

                          ){edit(
                              userNameController.text.toString(),
                              PhoneNumberController.text.toString(),
                              emailController.text.toString(),
                              );}


                        },
                      ),
                    ],
                  ),
                ),
              ),
              Gap(20.h),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text( LocaleKeys.Back.tr(),
                      style: TextStyle(color: Colors.grey, fontSize: 16.sp))),
            ],
          ),
        ),
      ),
    );
  }
}
