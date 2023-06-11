
import 'dart:convert';
import 'dart:io';
import 'package:copons/screens/wait_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../components/app_style.dart';
import '../models/subscribe_model.dart';
import '../translations/locale_keys.g.dart';
import 'login_screen.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({Key? key}) : super(key: key);

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  Future<subscribeModel> getData() async {
    final response = await http.get(
        Uri.parse('http://saudi07-001-site2.itempurl.com/api/GetAll_BankDetails'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode==200) {

      print(response.body);
      return subscribeModel.fromJson(jsonDecode(response.body));
    } else {

      throw Exception('Failed to load album');
    }
  }
  void subscribe(
      String SubscriptionId,
      String ApplicationUserId,
      String img,
      )async{
    var request = http.MultipartRequest('POST', Uri.parse('http://saudi07-001-site2.itempurl.com/api/CreateSubscripeRequests'));
    request.fields.addAll({
      'SubscriptionId': SubscriptionId,
      'ApplicationUserId': ApplicationUserId
    });
    request.files.add(await http.MultipartFile.fromPath('Photo',img));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }

  }
  final userData =GetStorage();
  static File? file;
  String? imag;
  ImagePicker image = ImagePicker();
  getGallery() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
      print(img.path);

      imag = img.path;
      userData.write('path', file);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(

                  width: double.infinity,
                  padding: EdgeInsets.all(20.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Styles.defualtColor5,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(
                            0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15.r),
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(LocaleKeys.Account_Number.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(

                      fontSize: 18.sp,
                      color: Styles.defualtColor3,

                      fontFamily: 'Tajawal2',

                    ),),
                  ),
                  Gap(15.h),
                  FutureBuilder(
                    future: getData(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return Center(
                          child: SelectableText('${snapshot.data!.records![0].accountNumber}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                            fontSize: 15.sp,
                            color: Styles.defualtColor3,

                            fontFamily: 'Tajawal2',

                          ),),
                        );
                      }else {
                        return Center(
                          child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(Styles.defualtColor),),
                        );
                      }
                    },
                  ),
                  Gap(40.h),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      file == null
                          ? CircleAvatar(
                        backgroundImage: AssetImage('assets/2345.png'),
                        radius: 45.r,
                      )
                          : CircleAvatar(
                        backgroundImage: FileImage(file!),
                        radius: 45.r,
                      ),
                      InkWell(
                        onTap: () {
                          getGallery();
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0xff898A8F),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: Styles.defualtColor2,
                            size: 14.sp,
                          ),
                          radius: 13.r,
                        ),
                      )
                    ],
                  ),
                  Gap(120.h),
                  InkWell(
                    onTap: () {

                      subscribe('${userData.read('Subscribe')}','${userData.read('token')}',imag!);
                      Get.to(WaitScreen());
                    },
                    child: Container(
                      height: 40.h,
                      width: 200.h,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(20.r),
                        gradient: LinearGradient(
                          begin: Alignment(.8.h, -.7.h),
                          end: Alignment(0.8.h, 1.h),
                          colors: [
                            Color(0xffC3A358),
                            Color(0xffE2CD6D),
                            Color(0xffC39528),

                            //C3A358
                            //E2CD6D
                            //C39528
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          LocaleKeys.Subscribe.tr(),
                          style: TextStyle(
                            fontFamily: 'Tajawal2',
                            color: Colors.black,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              )

            ],
          ),
        ),
      ),

    );
  }
}
