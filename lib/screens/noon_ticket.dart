import 'dart:convert';

import 'package:copons/components/app_style.dart';
import 'package:copons/screens/search.dart';
import 'package:copons/translations/locale_keys.g.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/component.dart';
import 'bottom_nav.dart';
import 'classTicket.dart';

class NoonTicketScreen extends StatefulWidget {
  Widget img;
  String storeName;
  String storeOffer;
  String storeCode;
  String storeDetails;
  String storePhone;
  String storeCountry;
  Function() storelink;
  Widget fav;

  NoonTicketScreen({
    Key? key,
    required this.img,
    required this.storeName,
    required this.storeOffer,
    required this.storeDetails,
    required this.storelink,
    required this.storePhone,
    required this.storeCode,
    required this.storeCountry,
    required this.fav,

  }) : super(key: key);

  @override
  State<NoonTicketScreen> createState() => _NoonTicketScreenState();
}

class _NoonTicketScreenState extends State<NoonTicketScreen> {
  final userData = GetStorage();
  static const likedKey = 'LikeKey';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  _restorePressed();
  }
  // void _restorePressed() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   var liked = prefs.getBool(likedKey);
  //   setState(() => this.widget.isFavorite = liked!);
  // }
  //
  // void _pressed() async {
  //   setState(() {
  //     this.widget.isFavorite = !widget.isFavorite;
  //     if(widget.isFavorite==true){
  //       Favorite( );
  //       Fluttertoast.showToast(
  //                                           msg: LocaleKeys
  //                                                   .Added_To_Favorite_Successfully
  //                                               .tr(),
  //                                           toastLength: Toast.LENGTH_SHORT,
  //                                           gravity: ToastGravity.BOTTOM,
  //                                           timeInSecForIosWeb: 1,
  //                                           textColor: Colors.white,
  //                                           fontSize: 16.0);
  //     }else{
  //       DelelteFavorite();
  //       Fluttertoast.showToast(
  //                                           msg: LocaleKeys
  //                                                   .Deleted_From_Favorite_Successfully
  //                                               .tr(),
  //                                           toastLength: Toast.LENGTH_SHORT,
  //                                           gravity: ToastGravity.BOTTOM,
  //                                           timeInSecForIosWeb: 1,
  //                                           textColor: Colors.white,
  //                                           fontSize: 16.0);
  //       print('object');
  //     }
  //
  //   });
  //   var prefs = await SharedPreferences.getInstance();
  //   prefs.setBool(likedKey, widget.isFavorite);
  // }

  void Favorite(

      ) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('http://saudi07-001-site2.itempurl.com/api/CreateUser_Faviourites'));
      request.body = json.encode({
        "userId":'${userData.read('token')}',
        "storeId": '${userData.read('storeId')}',
        "countryName":'${userData.read('countryFavId')}',
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());
    }
  }
  void DelelteFavorite(

      ) async {
    try {
      var request = http.Request('DELETE', Uri.parse('http://saudi07-001-site2.itempurl.com/api/DeleteFaviourite/${userData.read('delete')}'));
      request.body = '''''';

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());
    }
  }


  Widget icon = Icon(
    FluentSystemIcons.ic_fluent_heart_regular,
  );

  bool isTapped2 = true;
  bool isTapped3 = true;
  int counter = 0;
  int counter1 = 0;
  List<AssetImage> iconImage2 = [
    AssetImage('assets/Scroll Group 4.png'),
    AssetImage('assets/Scroll Group 4.png'),
  ];
  Future<bool?> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tap', userData.read('tap'));
    final bool? repeat = prefs.getBool('tap');
    print('repeat${repeat}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: Styles.defualtColor2,
        automaticallyImplyLeading: false,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.r),bottomRight:Radius.circular(25.r) )
        ),

        title: SizedBox(
          height: 35.h,
          width: double.infinity.h,
          child: InkWell(
            onTap: (){
              showSearch(context: context, delegate: search());
            },
            child: Container(

              decoration: BoxDecoration(
                color: Styles.defualtColor4,
                borderRadius: BorderRadius.circular(20.h),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gap(25.h),
                    Icon(
                        FluentSystemIcons.ic_fluent_search_regular,
                        size: 24.sp,
                        color: Styles.defualtColor3
                    ),
                    Gap(15.h),
                    Text(
                      "What are you looking for".tr(),
                      style:       TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Tajawal7',
                          color: Styles.defualtColor3
                      ),

                    ),
                  ],
                ),
              ),
            ),
          ),
        ) ,
        toolbarHeight: 70.h,


      ),
      backgroundColor: Color(0xffD9D9D9),
        body: SingleChildScrollView(
          child: couponWidget(),






        ));
          //       SizedBox(
          //   height: 570.h,
          //   child: Padding(
          //     padding:   EdgeInsets.symmetric(horizontal: 20.h, ),
          //     child: Column(
          //       children: [
          //         Container(
          //           height: 485.h,
          //           padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 20.h),
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.only(
          //                 topRight: Radius.circular(
          //                   20.h,
          //                 ),
          //                 topLeft: Radius.circular(
          //                   20.h,
          //                 ),
          //               )
          //           ),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //
          //
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   InkWell(
          //                     child: Icon(
          //                       Icons.cancel_sharp,
          //                       color: Styles.defualtColor2,
          //                       size: 25.sp,
          //                     ),
          //                     onTap: () {
          //                       Get.back();
          //                     },
          //                   ),
          //
          //                   InkWell(
          //                     onTap: (){
          //                       widget.storelink;
          //                     },
          //                     child: Icon(
          //                       Icons.share,
          //                       color: Styles.defualtColor2,
          //                       size: 25.sp,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               Center(child:
          //           widget.img
          //
          //               ),
          //
          //               Gap(20.h),
          //               Text(
          //                 widget.storeName,
          //                 style: TextStyle(
          //                   fontSize: 20.sp,
          //                   fontFamily: 'Tajawal2',
          //                 ),
          //                 textAlign: TextAlign.center,
          //               ),
          //               Divider(
          //                 height: 15.h,
          //                 color:Colors.grey.shade600,
          //                 thickness: .1,
          //               ),
          //               Gap(5.h),
          //               Text(
          //                 '${LocaleKeys.Offer.tr()} :',
          //                 style: TextStyle(
          //                   fontSize: 15.sp,
          //                   color: Styles.defualtColor,
          //                   fontFamily: 'Tajawal7',
          //                 ),
          //               ),
          //               Gap(5.h),
          //               Text(
          //                 widget.storeOffer,
          //                 style: TextStyle(
          //                   fontSize: 13.sp,
          //                   color: Styles.defualtColor2,
          //                   fontFamily: 'Tajawal7',
          //                 ),
          //               ),
          //               Gap(10.h),
          //               Text(
          //                 '${LocaleKeys.Offered_discount_code.tr()} :',
          //                 style: TextStyle(
          //                   fontSize: 15.sp,
          //                   color: Styles.defualtColor,
          //                   fontFamily: 'Tajawal7',
          //                 ),
          //               ),
          //               Gap(5.h),
          //               SelectableText(
          //                 widget.storeCode,
          //                 style: TextStyle(
          //                   fontSize: 13.sp,
          //                   color: Styles.defualtColor2,
          //                   fontFamily: 'Tajawal7',
          //                 ),
          //               ),
          //               Gap(10.h),
          //
          //               Text(
          //                 '${LocaleKeys.Country.tr()} :',
          //                 style: TextStyle(
          //                   fontSize: 15.sp,
          //                   color: Styles.defualtColor,
          //                   fontFamily: 'Tajawal7',
          //                 ),
          //               ),
          //               Gap(5.h),
          //               Text(
          //                 '${userData.read('nameCountry')}',
          //                 style: TextStyle(
          //                   fontSize: 13.sp,
          //                   color: Styles.defualtColor2,
          //                   fontFamily: 'Tajawal7',
          //                 ),
          //               ),
          //
          //
          //               Gap(10.h),
          //               Text(
          //                 '${LocaleKeys.Details.tr()} :',
          //                 style: TextStyle(
          //                   fontSize: 15.sp,
          //                   color: Styles.defualtColor,
          //                   fontFamily: 'Tajawal7',
          //                 ),
          //               ),
          //               Gap(5.h),
          //               Text(
          //                 widget.storeDetails,
          //                 style: TextStyle(
          //                   fontSize: 13.sp,
          //                   color: Styles.defualtColor2,
          //                   fontFamily: 'Tajawal7',
          //                 ),
          //               ),
          //
          //               Gap(10.h),
          //               Text(
          //                 '${LocaleKeys.phone_Number.tr()} :',
          //                 style: TextStyle(
          //                   fontSize: 15.sp,
          //                   color: Styles.defualtColor,
          //                   fontFamily: 'Tajawal7',
          //                 ),
          //               ),
          //               Gap(5.h),
          //               Text(
          //               widget.storePhone,
          //                 style: TextStyle(
          //                   fontSize: 13.sp,
          //                   color: Styles.defualtColor2,
          //                   fontFamily: 'Tajawal7',
          //                 ),
          //               ),
          //               Gap(5.h),
          //
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   InkWell(
          //                     onTap:  widget.storelink,
          //                     child: Column(
          //                       children: [
          //                         Icon(Icons.link),
          //                         Gap(5.h),
          //                         Text(
          //                           LocaleKeys.Link.tr(),
          //                           style: TextStyle(
          //                             fontSize: 12.sp,
          //                             color: Styles.defualtColor2,
          //                             fontFamily: 'Tajawal2',
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //
          //                   Column(
          //                     children: [
          //
          //                       InkWell(
          //                           onTap: (){
          //                             DelelteFavorite();
          //                             Fluttertoast.showToast(
          //                                 msg: LocaleKeys
          //                                     .Deleted_From_Favorite_Successfully
          //                                     .tr(),
          //                                 toastLength: Toast.LENGTH_SHORT,
          //                                 gravity: ToastGravity.BOTTOM,
          //                                 timeInSecForIosWeb: 1,
          //                                 textColor: Colors.white,
          //                                 fontSize: 16.0);
          //                           },
          //                           child: Icon(Icons.favorite_border,
          //                           )),
          //                       Gap(5.h),
          //                       Text(
          //                         LocaleKeys.UnFavorite.tr(),
          //                         style: TextStyle(
          //                           fontSize: 12.sp,
          //                           color: Styles.defualtColor2,
          //                           fontFamily: 'Tajawal2',
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //
          //                   Column(
          //                     children: [
          //
          //                       InkWell(
          //                           onTap: (){
          //                             Favorite();
          //                             Fluttertoast.showToast(
          //                                 msg: LocaleKeys
          //                                     .Added_To_Favorite_Successfully
          //                                     .tr(),
          //                                 toastLength: Toast.LENGTH_SHORT,
          //                                 gravity: ToastGravity.BOTTOM,
          //                                 timeInSecForIosWeb: 1,
          //                                 textColor: Colors.white,
          //                                 fontSize: 16.0);
          //                           },
          //                           child: Icon(Icons.favorite,
          //                           )),
          //                       Gap(5.h),
          //                       Text(
          //                         LocaleKeys.Favorite.tr(),
          //                         style: TextStyle(
          //                           fontSize: 12.sp,
          //                           color: Styles.defualtColor2,
          //                           fontFamily: 'Tajawal2',
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //
          //                   InkWell(
          //                     onTap: () {
          //                       setState(() {
          //                         isTapped2 = !isTapped2;
          //                       });
          //                     },
          //                     child: Column(
          //                       children: [
          //                         Icon(
          //                           isTapped2
          //                               ? FluentSystemIcons
          //                               .ic_fluent_thumb_like_regular
          //                               : FluentSystemIcons
          //                               .ic_fluent_thumb_like_filled,
          //                         ),
          //                         Gap(5.h),
          //                         Text(
          //                           LocaleKeys.Effective.tr(),
          //                           style: TextStyle(
          //                             fontSize: 12.sp,
          //                             color: Styles.defualtColor2,
          //                             fontFamily: 'Tajawal2',
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //
          //                   InkWell(
          //                     onTap: () {
          //                       setState(() {
          //                         isTapped3 = !isTapped3;
          //                       });
          //                     },
          //                     child: Column(
          //                       children: [
          //                         Icon(
          //                           isTapped3
          //                               ? FluentSystemIcons
          //                               .ic_fluent_thumb_dislike_regular
          //                               : FluentSystemIcons
          //                               .ic_fluent_thumb_dislike_filled,
          //                         ),
          //                         Gap(5.h),
          //                         Text(
          //                           LocaleKeys.inactive.tr(),
          //                           style: TextStyle(
          //                             fontSize: 12.sp,
          //                             color: Styles.defualtColor2,
          //                             fontFamily: 'Tajawal2',
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               )
          //
          //
          //
          //
          //             ],
          //           ),
          //         ),
          //         userData.read('lang')==true ?   Container(
          //           color: Colors.white,
          //           child: Row(
          //
          //             children: [
          //               SizedBox(
          //                 height: 30.h,
          //                 width:15.h,
          //                 child: DecoratedBox(
          //                   decoration: BoxDecoration(
          //                       color:  Color(0xffD9D9D9) ,
          //                       borderRadius: BorderRadius.only(
          //                         topLeft: Radius.circular(
          //                           20.h,
          //                         ),
          //                         bottomLeft: Radius.circular(
          //                           20.h,
          //                         ),
          //                       )),
          //                 ),
          //               ),
          //               Expanded(
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(12.0),
          //                     child:
          //                     LayoutBuilder(
          //                       builder:
          //                           (BuildContext context, BoxConstraints constraints) {
          //                         return Flex(
          //                             direction: Axis.horizontal,
          //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                             mainAxisSize: MainAxisSize.max,
          //                             children: List.generate(
          //                                 (constraints.constrainWidth() / 15).floor(),
          //                                     (index) => SizedBox(
          //                                   width:5.h,
          //                                   height:1.h,
          //                                   child: DecoratedBox(
          //                                     decoration: BoxDecoration(
          //                                       color:
          //                                       Colors.grey.shade300,
          //                                     ),
          //                                   ),
          //                                 )));
          //                       },
          //                     ),
          //                   )),
          //               SizedBox(
          //                 height: 30.h,
          //                 width:15.h,
          //                 child: DecoratedBox(
          //                   decoration: BoxDecoration(
          //
          //                       color: Color(0xffD9D9D9),
          //                       borderRadius: BorderRadius.only(
          //                         topRight: Radius.circular(
          //                           20.h,
          //                         ),
          //                         bottomRight: Radius.circular(
          //                           20.h,
          //                         ),
          //                       )),
          //                 ),
          //               ),
          //
          //             ],
          //           ),
          //         ):
          //         Container(
          //           color: Colors.white,
          //           child: Row(
          //
          //             children: [
          //               SizedBox(
          //                 height: 30.h,
          //                 width:15.h,
          //                 child: DecoratedBox(
          //                   decoration: BoxDecoration(
          //
          //                       color: Color(0xffD9D9D9),
          //                       borderRadius: BorderRadius.only(
          //                         topRight: Radius.circular(
          //                           20.h,
          //                         ),
          //                         bottomRight: Radius.circular(
          //                           20.h,
          //                         ),
          //                       )),
          //                 ),
          //               ),
          //               Expanded(
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(12.0),
          //                     child:
          //                     LayoutBuilder(
          //                       builder:
          //                           (BuildContext context, BoxConstraints constraints) {
          //                         return Flex(
          //                             direction: Axis.horizontal,
          //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                             mainAxisSize: MainAxisSize.max,
          //                             children: List.generate(
          //                                 (constraints.constrainWidth() / 15).floor(),
          //                                     (index) => SizedBox(
          //                                   width:5.h,
          //                                   height:1.h,
          //                                   child: DecoratedBox(
          //                                     decoration: BoxDecoration(
          //                                       color:
          //                                       Colors.grey.shade300,
          //                                     ),
          //                                   ),
          //                                 )));
          //                       },
          //                     ),
          //                   )),
          //
          //               SizedBox(
          //                 height: 30.h,
          //                 width:15.h,
          //                 child: DecoratedBox(
          //                   decoration: BoxDecoration(
          //                       color:  Color(0xffD9D9D9) ,
          //                       borderRadius: BorderRadius.only(
          //                         topLeft: Radius.circular(
          //                           20.h,
          //                         ),
          //                         bottomLeft: Radius.circular(
          //                           20.h,
          //                         ),
          //                       )),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //
          //         Container(
          //           height: 50.h,
          //           width: double.infinity,
          //           padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 10.h),
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.only(
          //                 bottomLeft: Radius.circular(
          //                   20.h,
          //                 ),
          //                 bottomRight: Radius.circular(
          //                   20.h,
          //                 ),
          //               )
          //           ),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               buildBottum(
          //                 height: 30.h,
          //                 decoration: BoxDecoration(
          //                   color: Styles.defualtColor,
          //                   borderRadius: BorderRadius.circular(25),
          //                 ),
          //                 width: double.infinity,
          //                 text: Text(
          //                   LocaleKeys.Copy.tr(),
          //
          //                   style: TextStyle(
          //                       color: Colors.white,
          //                       fontSize: 16.sp,
          //                       fontWeight: FontWeight.w600),
          //                   textAlign: TextAlign.center,
          //                 ),
          //                 onTap: () async {
          //                   await Clipboard.setData(ClipboardData(text: widget.storeCode));
          //                   print('do');
          //                   Fluttertoast.showToast(
          //                       msg: LocaleKeys
          //                           .Done
          //                           .tr(),
          //                       toastLength: Toast.LENGTH_SHORT,
          //                       gravity: ToastGravity.BOTTOM,
          //                       timeInSecForIosWeb: 1,
          //                       textColor: Colors.white,
          //                       fontSize: 16.0);
          //                   // copied successfully
          //                 },
          //               ),
          //
          //
          //
          //             ],
          //           ),
          //         ),
          //
          //       ],
          //     ),
          //   ),
          // )

  }
  //  setState(() {
//                                       isTapped = !isTapped;
//                                       print(isTapped);
//                                       if (isTapped == true) {
//                                         userData.write('tap', isTapped);
//                                         Favorite('${userData.read('token')}',
//                                             '${userData.read('storeId')}');
//                                         save();
//                                         icon = Icon(
//                                           FluentSystemIcons
//                                               .ic_fluent_heart_filled,
//                                         );
//                                         Fluttertoast.showToast(
//                                             msg: LocaleKeys
//                                                     .Added_To_Favorite_Successfully
//                                                 .tr(),
//                                             toastLength: Toast.LENGTH_SHORT,
//                                             gravity: ToastGravity.BOTTOM,
//                                             timeInSecForIosWeb: 1,
//                                             textColor: Colors.white,
//                                             fontSize: 16.0);
//                                       } else {
//                                         icon = Icon(
//                                           FluentSystemIcons
//                                               .ic_fluent_heart_regular,
//                                         );
//                                         Fluttertoast.showToast(
//                                             msg: LocaleKeys
//                                                     .Deleted_From_Favorite_Successfully
//                                                 .tr(),
//                                             toastLength: Toast.LENGTH_SHORT,
//                                             gravity: ToastGravity.BOTTOM,
//                                             timeInSecForIosWeb: 1,
//                                             textColor: Colors.white,
//                                             fontSize: 16.0);
//                                       }
//                                     });
  Widget couponWidget() {
    return Container(
      //Add height as per requirement
      width: double.infinity,//Add width as per requirement,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: ClipPath(
        clipper: DolDurmaClipper(holeRadius: 20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.h,vertical: 10.h),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.cancel_sharp,
                      color: Styles.defualtColor2,
                      size: 25.sp,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),

                  InkWell(
                    onTap: (){
                      _launchUrl('https://play.google.com/store/apps/details?id=on.sam.code');
                      
                    },
                    child: Icon(
                      Icons.share,
                      color: Styles.defualtColor2,
                      size: 25.sp,
                    ),
                  )
                ],
              ),
              Center(child:
              widget.img

              ),
              Gap(20.h),
              Padding( //Separater line
                padding:   EdgeInsets.only(left: 0, right: 0),
                child: Container(
                  color: Colors.grey,
                  height: 1,
                ),
              ),
              Gap(20.h),
          Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.storeName,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: 'Tajawal2',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(10.h),
                  Text(
                    '${LocaleKeys.Offer.tr()} :',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Styles.defualtColor,
                      fontFamily: 'Tajawal7',
                    ),
                  ),
                  Gap(5.h),
                  Text(
                    widget.storeOffer,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Styles.defualtColor2,
                      fontFamily: 'Tajawal7',
                    ),
                  ),
                  Gap(10.h),
                  Text(
                    '${LocaleKeys.Offered_discount_code.tr()} :',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Styles.defualtColor,
                      fontFamily: 'Tajawal7',
                    ),
                  ),
                  Gap(5.h),
                  SelectableText(
                    widget.storeCode,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Styles.defualtColor2,
                      fontFamily: 'Tajawal7',
                    ),
                  ),
                  Gap(10.h),

                  Text(
                    '${LocaleKeys.Country.tr()} :',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Styles.defualtColor,
                      fontFamily: 'Tajawal7',
                    ),
                  ),
                  Gap(5.h),
                  Text(
                    widget.storeCountry,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Styles.defualtColor2,
                      fontFamily: 'Tajawal7',
                    ),
                  ),


                  Gap(10.h),
                  Text(
                    '${LocaleKeys.Details.tr()} :',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Styles.defualtColor,
                      fontFamily: 'Tajawal7',
                    ),
                  ),

                  Text(
                    widget.storeDetails,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Styles.defualtColor2,
                      fontFamily: 'Tajawal7',
                    ),
                  ),

                  Gap(10.h),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap:  widget.storelink,
                        child: Column(
                          children: [
                            Icon(Icons.link),
                            Gap(5.h),
                            Text(
                              LocaleKeys.Link.tr(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Styles.defualtColor2,
                                fontFamily: 'Tajawal2',
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Column(
                      //   children: [
                      //
                      //     InkWell(
                      //         onTap: (){
                      //           DelelteFavorite();
                      //           Fluttertoast.showToast(
                      //               msg: LocaleKeys
                      //                   .Deleted_From_Favorite_Successfully
                      //                   .tr(),
                      //               toastLength: Toast.LENGTH_SHORT,
                      //               gravity: ToastGravity.BOTTOM,
                      //               timeInSecForIosWeb: 1,
                      //               textColor: Colors.white,
                      //               fontSize: 16.0);
                      //         },
                      //         child: Icon(Icons.favorite_border,
                      //           )),
                      //     Gap(5.h),
                      //     Text(
                      //       LocaleKeys.UnFavorite.tr(),
                      //       style: TextStyle(
                      //         fontSize: 12.sp,
                      //         color: Styles.defualtColor2,
                      //         fontFamily: 'Tajawal2',
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      Column(
                        children: [
                          widget.fav,


                          Gap(5.h),
                          Text(
                            LocaleKeys.Favorite.tr(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Styles.defualtColor2,
                              fontFamily: 'Tajawal2',
                            ),
                          ),
                        ],
                      ),

                      InkWell(
                        onTap: () {
                          setState(() {
                            isTapped2 = !isTapped2;
                            print('object');
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              isTapped2
                                  ? FluentSystemIcons
                                  .ic_fluent_thumb_like_regular
                                  : FluentSystemIcons
                                  .ic_fluent_thumb_like_filled,
                            ),
                            Gap(5.h),
                            Text(
                              LocaleKeys.Effective.tr(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Styles.defualtColor2,
                                fontFamily: 'Tajawal2',
                              ),
                            ),
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          setState(() {
                            isTapped3 = !isTapped3;
                            print('object');
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              isTapped3
                                  ? FluentSystemIcons
                                  .ic_fluent_thumb_dislike_regular
                                  : FluentSystemIcons
                                  .ic_fluent_thumb_dislike_filled,
                            ),
                            Gap(5.h),
                            Text(
                              LocaleKeys.inactive.tr(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Styles.defualtColor2,
                                fontFamily: 'Tajawal2',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 60.h,
                    padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 10.h),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildBottum(
                          height: 40.h,
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
                          width: double.infinity,
                          text: Text(
                            LocaleKeys.Copy.tr(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(text:  widget.storeCode,));
                            print('do');
                            Fluttertoast.showToast(
                                msg: LocaleKeys
                                    .Done
                                    .tr(),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            // copied successfully
                          },
                        ),



                      ],
                    ),
                  ),
                 



                ],
              ),

            ],
          ),
        ]),
      ),


      ) );



  }
  Future<void> _launchUrl(String link ) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}
// Padding(
//                         padding:   EdgeInsets.only( right: 70.h,left: 70.h,bottom: 50.h,top: 8.h),
//                         child: InkWell(
//                           onTap: (){},
//                           child: Container(
//                             height: 33.h,
//                             width: 150.h,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(14.r),
//                               gradient: LinearGradient(
//                                 begin: Alignment(.8.h, -.7.h),
//                                 end: Alignment(0.8.h, 1.h),
//                                 colors: [
//                                   Color(0xffC3A358),
//                                   Color(0xffE2CD6D),
//                                   Color(0xffC39528),
//
//                                   //C3A358
//                                   //E2CD6D
//                                   //C39528
//
//
//                                 ],
//
//                               ),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 'نسخ',
//                                 style: TextStyle(
//                                   fontFamily: 'Tajawal2',
//                                   color: Colors.black,
//                                   fontSize: 14.sp,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
