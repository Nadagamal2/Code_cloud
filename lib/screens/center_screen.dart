import 'dart:convert';
import 'dart:io';

import 'package:copons/components/app_style.dart';
import 'package:copons/screens/bottom_nav.dart';
import 'package:copons/screens/login_screen.dart';
import 'package:copons/translations/locale_keys.g.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../models/addition_model.dart';
import '../models/centerDataModel.dart';
import 'done_add_store.dart';
import 'noon_ticket.dart';

class CenterScreen extends StatefulWidget {
  const CenterScreen({Key? key}) : super(key: key);

  @override
  State<CenterScreen> createState() => _CenterScreenState();
}

class _CenterScreenState extends State<CenterScreen> {
  final storeNameController = TextEditingController();
  final storelinkController = TextEditingController();
  final storedetailsController = TextEditingController();
  final storeofferController = TextEditingController();
  final storecodeController = TextEditingController();
  final storeaddressController = TextEditingController();
  final storephoneController = TextEditingController();
  final storecatIdController = TextEditingController();
  final storecountIdController = TextEditingController();
  final storeFavController = TextEditingController();
  void creatStore(
    String storeName,
    String storeLink,
    String storedetails,
    String storecode,
    String storeoffer,
    String storeaddress,
    String storephone,
    String storecatid,
    String storecountid,
    String img,
    String fav,
  ) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('http://saudi07-001-site2.itempurl.com/api/CreateStore'));
    request.fields.addAll({
      'Stor_Title': storeName,
      'Stor_Link': storeLink,
      'Stor_Deteils': storedetails,
      'Stor_Offer': storeoffer,
      'Stor_SaleCode': storecode,
      'Stor_Address': storeaddress,
      'Stor_PhoneNumber': storephone,
      'CatgId': storecatid,
      'CountId': storecountid,
      'User_Faviourites': fav
    });
    request.files.add(await http.MultipartFile.fromPath('Photo', img));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

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
  void dispose() {
    storeNameController.dispose();
    storelinkController.dispose();
    storedetailsController.dispose();
    storeofferController.dispose();
    storecodeController.dispose();
    storeaddressController.dispose();
    storephoneController.dispose();
    storecatIdController.dispose();
    storecountIdController.dispose();
    storeFavController.dispose();
    super.dispose();
  }

  final userData = GetStorage();
  Future<AdditionModel> getData() async {
    final response = await http.get(Uri.parse(
        'http://saudi07-001-site2.itempurl.com/api/GetAll_Addition_Terms'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(response.body);
      return AdditionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<subscribeText2Model> getData1() async {
    final response = await http.get(Uri.parse(
        'http://saudi07-001-site2.itempurl.com/api/GetAll_SubscriptionMessage'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(response.body);
      return subscribeText2Model.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return userData.read('isLogged') == true &&
            userData.read('IsSubscriped') == "True"
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Styles.defualtColor2,
              centerTitle: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(25.r))),
              title: Text(
                "Enter new code".tr(),
                style: TextStyle(
                  fontFamily: 'Tajawal2',
                  color: Styles.defualtColor3,
                  fontSize: 18.sp,
                ),
              ),
              toolbarHeight: 70.h,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(5.h),
                  SizedBox(
                    height: 535.h,
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.h, right: 20.h),
                              child: Container(
                                  height: 130.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Styles.defualtColor3,
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
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.h, vertical: 20.h),
                                    child: Column(
                                      children: [
                                        Text(
                                          LocaleKeys.Addition_terms.tr(),
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: 'Tajawal2',
                                          ),
                                        ),
                                        Gap(5.h),
                                        FutureBuilder(
                                          future: getData(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return SizedBox(
                                                height: 60.h,
                                                child: ListView.separated(
                                                    itemBuilder: (context,
                                                            index) =>
                                                        Row(
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundColor:
                                                                  Styles
                                                                      .defualtColor,
                                                              radius: 4.r,
                                                            ),
                                                            Gap(3.h),
                                                            Text(
                                                              '${snapshot.data!.records![index].details}',
                                                              style: TextStyle(
                                                                fontSize: 10.sp,
                                                                fontFamily:
                                                                    'Tajawal7',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            Gap(5.h),
                                                    itemCount: snapshot
                                                        .data!.records!.length),
                                              );
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Styles.defualtColor),
                                                ),
                                              );
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.h, right: 20.h, top: 10.h),
                              child: Container(
                                  height: 320.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Styles.defualtColor3,
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
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.h, vertical: 20.h),
                                    child: Column(
                                      children: [
                                        Text(
                                          LocaleKeys.Store_Details.tr(),
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: 'Tajawal2',
                                          ),
                                        ),

                                        TextFormField(
                                          cursorColor: Colors.grey.shade400,
                                          keyboardType: TextInputType.text,
                                          controller: storeNameController,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.h, 0, 10, 1.h),
                                            isDense: true,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            labelText:
                                                LocaleKeys.Store_name.tr(),
                                            hintText:
                                                LocaleKeys.Store_name.tr(),
                                            labelStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                            hintStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                        TextFormField(
                                          cursorColor: Colors.grey.shade400,
                                          keyboardType: TextInputType.text,
                                          controller: storelinkController,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.h, 0, 10, 1.h),
                                            isDense: true,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            labelText:
                                                LocaleKeys.Store_link.tr(),
                                            hintText:
                                                LocaleKeys.Store_link.tr(),
                                            labelStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                            hintStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                        TextFormField(
                                          cursorColor: Colors.grey.shade400,
                                          keyboardType: TextInputType.text,
                                          controller: storeaddressController,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.h, 0, 10, 1.h),
                                            isDense: true,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            labelText: LocaleKeys.Address.tr(),
                                            hintText: LocaleKeys.Address.tr(),
                                            labelStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                            hintStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                        TextFormField(
                                          cursorColor: Colors.grey.shade400,
                                          keyboardType: TextInputType.number,
                                          controller: storephoneController,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.h, 0, 10, 1.h),
                                            isDense: true,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            labelText:
                                                LocaleKeys.phone_Number.tr(),
                                            hintText:
                                                LocaleKeys.phone_Number.tr(),
                                            labelStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                            hintStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                        Gap(15.h),
                                        // DottedBorder(
                                        //   color: Styles.defualtColor,
                                        //   dashPattern: [5, 3],
                                        //   strokeWidth: 1,
                                        //   borderType: BorderType.RRect,
                                        //   radius: Radius.circular(5),
                                        //
                                        //   child: ClipRRect(
                                        //     borderRadius: BorderRadius.all(Radius.circular(5)),
                                        //     child: Container(
                                        //       height: 40,
                                        //       width: double.infinity,
                                        //       child: Row(
                                        //         mainAxisAlignment: MainAxisAlignment.center,
                                        //         children: [
                                        //           Image(image: AssetImage('assets/u.png')),
                                        //           Gap(15.h),
                                        //           Text(LocaleKeys.Download.tr(),
                                        //             style: TextStyle(
                                        //               fontSize: 12.sp,
                                        //               fontFamily: 'Tajawal2',
                                        //
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //
                                        //     ),
                                        //   ),
                                        // ),
                                        Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            file == null
                                                ? CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        'assets/2345.png'),
                                                    radius: 45.r,
                                                  )
                                                : CircleAvatar(
                                                    backgroundImage:
                                                        FileImage(file!),
                                                    radius: 45.r,
                                                  ),
                                            InkWell(
                                              onTap: () {
                                                getGallery();
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Color(0xff898A8F),
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
                                        Gap(15.h),
                                        Text(
                                          LocaleKeys
                                                  .Download_in_square_dimensions
                                              .tr(),
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.grey.shade400,
                                            fontFamily: 'Tajawal7',
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.h, right: 20.h, top: 10.h),
                              child: Container(
                                  height: 180.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Styles.defualtColor3,
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
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.h, vertical: 20.h),
                                    child: Column(
                                      children: [
                                        Text(
                                          LocaleKeys.Discount_details.tr(),
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: 'Tajawal2',
                                          ),
                                        ),
                                        TextFormField(
                                          cursorColor: Colors.grey.shade400,
                                          keyboardType: TextInputType.number,
                                          controller: storecodeController,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.h, 0, 10, 1.h),
                                            isDense: true,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            labelText: LocaleKeys
                                                .Offered_discount_code.tr(),
                                            hintText: LocaleKeys
                                                .Offered_discount_code.tr(),
                                            labelStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                            hintStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                        TextFormField(
                                          cursorColor: Colors.grey.shade400,
                                          keyboardType: TextInputType.text,
                                          controller: storeofferController,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.h, 0, 10, 1.h),
                                            isDense: true,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            labelText: LocaleKeys.Offer.tr(),
                                            hintText: LocaleKeys.Offer.tr(),
                                            labelStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                            hintStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                        TextFormField(
                                          cursorColor: Colors.grey.shade400,
                                          keyboardType: TextInputType.text,
                                          controller: storedetailsController,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.h, 0, 10, 1.h),
                                            isDense: true,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            labelText: LocaleKeys.Details.tr(),
                                            hintText: LocaleKeys.Details.tr(),
                                            labelStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                            hintStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                        TextFormField(
                                          cursorColor: Colors.grey.shade400,
                                          keyboardType: TextInputType.text,
                                          controller: storeFavController,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.h, 0, 10, 1.h),
                                            isDense: true,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            labelText: LocaleKeys.Favorite.tr(),
                                            hintText: LocaleKeys.Favorite.tr(),
                                            labelStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                            hintStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.h, right: 20.h, top: 10.h),
                              child: Container(
                                  height: 150.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Styles.defualtColor3,
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
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.h, vertical: 20.h),
                                    child: Column(
                                      children: [
                                        Text(
                                          LocaleKeys.Comments.tr(),
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: 'Tajawal2',
                                          ),
                                        ),
                                        TextFormField(
                                          cursorColor: Colors.grey.shade400,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.h, 0, 10, 1.h),
                                            isDense: true,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .5.r,
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            labelText: ' ',
                                            hintText: ' ',
                                            labelStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                            hintStyle: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Gap(10.h),
                            InkWell(
                              onTap: () {
                                creatStore(
                                    storeNameController.text.toString(),
                                    storelinkController.text.toString(),
                                    storeaddressController.text.toString(),
                                    storephoneController.text.toString(),
                                    storecodeController.text.toString(),
                                    storeofferController.text.toString(),
                                    storedetailsController.text.toString(),
                                    '${userData.read('id')}',
                                    '${userData.read('country')}',
                                    imag!,
                                    storeFavController.text.toString());
                                Get.offAll(DoneStoreScreen());
                              },
                              child: Container(
                                height: 40.h,
                                width: 200.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
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
                                    LocaleKeys.Create.tr(),
                                    style: TextStyle(
                                      fontFamily: 'Tajawal2',
                                      color: Colors.black,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Gap(15.h),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Styles.defualtColor2,
              centerTitle: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(25.r))),
              title: Text(
                "Enter new code".tr(),
                style: TextStyle(
                  fontFamily: 'Tajawal2',
                  color: Styles.defualtColor3,
                  fontSize: 18.sp,
                ),
              ),
              toolbarHeight: 70.h,
            ),
            body: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: getData1(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                          '${snapshot.data!.records![0].message} ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Styles.defualtColor),
                            ),
                          );
                        }
                      },
                    ),
                    // Gap(15.h),
                    // Text(
                    //   LocaleKeys.Login_Please.tr(),
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w500,
                    //     fontSize: 17.sp,
                    //   ),
                    // ),
                    // Gap(15.h),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       Get.offAll(LoginScreen());
                    //     },
                    //     style: ButtonStyle(
                    //         backgroundColor:
                    //             MaterialStateProperty.all(Styles.defualtColor),
                    //         padding:
                    //             MaterialStateProperty.all(EdgeInsets.all(20)),
                    //         textStyle: MaterialStateProperty.all(
                    //             TextStyle(fontSize: 15.sp))),
                    //     child: Text(
                    //       LocaleKeys.Move_to_Login_screen.tr(),
                    //     ))
                  ],
                ),
              ),
            ),
          );
  }
}
