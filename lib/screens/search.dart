import 'dart:convert';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

 import '../components/app_style.dart';
import '../components/component.dart';
import '../models/getAllCategory_model.dart';
 import '../models/search.dart';
import '../translations/locale_keys.g.dart';
import 'bottom_nav.dart';
import 'noon_ticket.dart';

class search extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';

          },
          icon: Icon(Icons.close))
    ];
  }
  @override
  String get searchFieldLabel =>LocaleKeys.Search_for_specific_store.tr();

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
          toolbarHeight: 65.h,
          color: Colors.grey,
          elevation: 0

      ),
      textSelectionTheme: TextSelectionThemeData(

          cursorColor: Colors.white,
          selectionColor: Colors.white,
          selectionHandleColor: Colors.white),

      inputDecorationTheme: InputDecorationTheme(


        hintStyle: TextStyle(
          color: Colors.white,
        ),
        isDense: true,
        contentPadding:
        EdgeInsets.fromLTRB(10.h, 5.h, 10.h, 7.h),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: Colors.white,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: Colors.white,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
        ),
      ),
    );
    assert(theme != null);
    return theme;
  }
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  List data = [];
  List<CategoryIdallSearchModel> result = [];
  Future<List<CategoryIdallSearchModel>?> catidSearch({  String? query}) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://saudi07-001-site2.itempurl.com/api/GetAllStores/${ userData.read('country')}'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({"SearchValue":query}));
      var dataa = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        data=dataa['records'];
         result=data.map((e) => CategoryIdallSearchModel.fromJson(e)).toList();
        if (query != null) {
          result = result
              .where((element) =>
              query.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
        print('dataId==${data}');
        print('result==${result}');
      } else {
        print("Faild");
      }
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  void DelelteFavorite(

      ) async {
    try {
      var request = http.Request('DELETE', Uri.parse('http://saudi07-001-site2.itempurl.com/api/DeleteFaviouriteById?Productid=${userData.read('storeId')}&userId=${userData.read('token')}'));


      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        Get.offAll(BottomNavScreen());

        Fluttertoast.showToast(
            msg: 'تم الحذف من المفضلة بنجاح',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      else {
        print(response.reasonPhrase);
      }



    } catch (e) {
      print(e.toString());
    }
  }
  void getDataId({required dynamic id}) async{

    try {
      var response = await http.post(
          Uri.parse(
              'http://saudi07-001-site2.itempurl.com/api/Get_Store_byId/${id}'),
          body: jsonEncode({"id": id}));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var log = json.decode(response.body);
        print('dataId==${data}');
      } else {
        print("Faild");
      }
    } catch (e) {
      print(e.toString());
    }
  }
  bool isTapped2 = true;
  bool isTapped3 = true;
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder (
      future: catallid( query),
      builder: (context, snapshot){

        if (snapshot.hasData) {

          return SingleChildScrollView(
            child: Column(
              children: snapshot.data!.records!.map((e) =>   Column(

                children: [

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: InkWell(
                      onTap: () {
                        userData.write('storeId', e.id);
                        print(e.id);

                        Get.to(NoonTicketScreen(img:    CircleAvatar(
                          backgroundImage: NetworkImage(
                            'http://saudi07-001-site2.itempurl.com/${e.storImgUrl}',

                          ),
                          backgroundColor: Colors.transparent,

                          radius: 50.r,
                        ),
                          storeName: '${e.storTitle}',
                          storeOffer: ' ${e.storOffer}', storeDetails: ' ${e.storDeteils}',
                          storelink: (){
                            _launchUrl('${e.storLink}');

                          }, storePhone: '${e.storPhoneNumber}', storeCode: '${e.storSaleCode}', storeCountry: '${e.countries!.contName}',
                          fav: FavoriteButton(
                            iconColor: Styles.defualtColor,
                            iconSize: 30.sp,
                            isFavorite: e.isFaviourite ,
                            valueChanged: (val) {
                              e.isFaviourite==false?
                              Favorite():DelelteFavorite();
                              val== e.isFaviourite;
                              print(e.isFaviourite);
                            },
                          ),
                        ));
                        // showModalBottomSheet(
                        //     isScrollControlled:true,
                        //     backgroundColor: Color(0xffD9D9D9),
                        //     context: context, builder: (context){
                        //       return
                        //         StatefulBuilder(builder: (BuildContext context, StateSetter setState){return   SizedBox(
                        //           height: 520.h,
                        //           child: Padding(
                        //             padding:   EdgeInsets.symmetric(horizontal: 20.h, ),
                        //             child: Column(
                        //               children: [
                        //                 Expanded(
                        //
                        //                   child: SingleChildScrollView(
                        //                     child: Container(
                        //
                        //                       padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 20.h),
                        //                       decoration: BoxDecoration(
                        //                           color: Colors.white,
                        //                           borderRadius: BorderRadius.only(
                        //                             topRight: Radius.circular(
                        //                               20.h,
                        //                             ),
                        //                             topLeft: Radius.circular(
                        //                               20.h,
                        //                             ),
                        //                           )
                        //                       ),
                        //                       child: Column(
                        //                         mainAxisAlignment: MainAxisAlignment.center,
                        //                         crossAxisAlignment: CrossAxisAlignment.center,
                        //                         children: [
                        //
                        //
                        //                           Row(
                        //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                             children: [
                        //                               InkWell(
                        //                                 child: Icon(
                        //                                   Icons.cancel_sharp,
                        //                                   color: Styles.defualtColor2,
                        //                                   size: 25.sp,
                        //                                 ),
                        //                                 onTap: () {
                        //                                   Get.back();
                        //                                 },
                        //                               ),
                        //
                        //                               InkWell(
                        //                                 onTap: (){   _launchUrl('${e.storLink}');},
                        //                                 child: Icon(
                        //                                   Icons.share,
                        //                                   color: Styles.defualtColor2,
                        //                                   size: 25.sp,
                        //                                 ),
                        //                               )
                        //                             ],
                        //                           ),
                        //                           Center(child:
                        //                           CircleAvatar(
                        //                             backgroundImage: NetworkImage(
                        //                               'http://eibtek2-001-site5.atempurl.com/${e.storImgUrl}',
                        //
                        //                             ),
                        //                             backgroundColor: Colors.transparent,
                        //
                        //                             radius: 50.r,
                        //                           )
                        //
                        //                           ),
                        //
                        //                           Gap(20.h),
                        //                           Text(
                        //                             '${e.storTitle}',
                        //                             style: TextStyle(
                        //                               fontSize: 20.sp,
                        //                               fontFamily: 'Tajawal2',
                        //                             ),
                        //                             textAlign: TextAlign.center,
                        //                           ),
                        //                           Divider(
                        //                             height: 15.h,
                        //                             color:Colors.grey.shade600,
                        //                             thickness: .1,
                        //                           ),
                        //                           Gap(5.h),
                        //                           Text(
                        //                             '${LocaleKeys.Offer.tr()} :',
                        //                             style: TextStyle(
                        //                               fontSize: 15.sp,
                        //                               color: Styles.defualtColor,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //                           Gap(5.h),
                        //                           Text(
                        //                             '${e.storOffer}',
                        //                             style: TextStyle(
                        //                               fontSize: 13.sp,
                        //                               color: Styles.defualtColor2,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //                           Gap(10.h),
                        //                           Text(
                        //                             '${LocaleKeys.Offered_discount_code.tr()} :',
                        //                             style: TextStyle(
                        //                               fontSize: 15.sp,
                        //                               color: Styles.defualtColor,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //                           Gap(5.h),
                        //                           SelectableText(
                        //                             '${e.storSaleCode}',
                        //                             style: TextStyle(
                        //                               fontSize: 13.sp,
                        //                               color: Styles.defualtColor2,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //                           Gap(10.h),
                        //
                        //                           Text(
                        //                             '${LocaleKeys.Country.tr()} :',
                        //                             style: TextStyle(
                        //                               fontSize: 15.sp,
                        //                               color: Styles.defualtColor,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //                           Gap(5.h),
                        //                           Text(
                        //                             '${userData.read('nameCountry')}',
                        //                             style: TextStyle(
                        //                               fontSize: 13.sp,
                        //                               color: Styles.defualtColor2,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //
                        //
                        //                           Gap(10.h),
                        //                           Text(
                        //                             '${LocaleKeys.Details.tr()} :',
                        //                             style: TextStyle(
                        //                               fontSize: 15.sp,
                        //                               color: Styles.defualtColor,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //                           Gap(5.h),
                        //                           Text(
                        //                             '${e.storDeteils}',
                        //                             style: TextStyle(
                        //                               fontSize: 13.sp,
                        //                               color: Styles.defualtColor2,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //
                        //                           Gap(10.h),
                        //
                        //
                        //                           Row(
                        //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                             children: [
                        //                               InkWell(
                        //                                 onTap: (){
                        //                                   _launchUrl('${e.storLink}');
                        //
                        //                                 },
                        //                                 child: Column(
                        //                                   children: [
                        //                                     Icon(Icons.link),
                        //                                     Gap(5.h),
                        //                                     Text(
                        //                                       LocaleKeys.Link.tr(),
                        //                                       style: TextStyle(
                        //                                         fontSize: 12.sp,
                        //                                         color: Styles.defualtColor2,
                        //                                         fontFamily: 'Tajawal2',
                        //                                       ),
                        //                                     ),
                        //                                   ],
                        //                                 ),
                        //                               ),
                        //
                        //                               // Column(
                        //                               //   children: [
                        //                               //
                        //                               //     InkWell(
                        //                               //         onTap: (){
                        //                               //           DelelteFavorite();
                        //                               //           Fluttertoast.showToast(
                        //                               //               msg: LocaleKeys
                        //                               //                   .Deleted_From_Favorite_Successfully
                        //                               //                   .tr(),
                        //                               //               toastLength: Toast.LENGTH_SHORT,
                        //                               //               gravity: ToastGravity.BOTTOM,
                        //                               //               timeInSecForIosWeb: 1,
                        //                               //               textColor: Colors.white,
                        //                               //               fontSize: 16.0);
                        //                               //         },
                        //                               //         child: Icon(Icons.favorite_border,
                        //                               //           )),
                        //                               //     Gap(5.h),
                        //                               //     Text(
                        //                               //       LocaleKeys.UnFavorite.tr(),
                        //                               //       style: TextStyle(
                        //                               //         fontSize: 12.sp,
                        //                               //         color: Styles.defualtColor2,
                        //                               //         fontFamily: 'Tajawal2',
                        //                               //       ),
                        //                               //     ),
                        //                               //   ],
                        //                               // ),
                        //
                        //                               Column(
                        //                                 children: [
                        //
                        //                                   InkWell(
                        //                                       onTap: (){
                        //                                         Favorite();
                        //                                         print(e.id);
                        //
                        //                                         Fluttertoast.showToast(
                        //                                             msg: LocaleKeys
                        //                                                 .Added_To_Favorite_Successfully
                        //                                                 .tr(),
                        //                                             toastLength: Toast.LENGTH_SHORT,
                        //                                             gravity: ToastGravity.BOTTOM,
                        //                                             timeInSecForIosWeb: 1,
                        //                                             textColor: Colors.white,
                        //                                             fontSize: 16.0);
                        //                                       },
                        //                                       child: Icon(Icons.favorite,
                        //                                       )),
                        //                                   Gap(5.h),
                        //                                   Text(
                        //                                     LocaleKeys.Favorite.tr(),
                        //                                     style: TextStyle(
                        //                                       fontSize: 12.sp,
                        //                                       color: Styles.defualtColor2,
                        //                                       fontFamily: 'Tajawal2',
                        //                                     ),
                        //                                   ),
                        //                                 ],
                        //                               ),
                        //
                        //                               InkWell(
                        //                                 onTap: () {
                        //                                   setState(() {
                        //                                     isTapped2 = !isTapped2;
                        //                                     print('object');
                        //                                   });
                        //                                 },
                        //                                 child: Column(
                        //                                   children: [
                        //                                     Icon(
                        //                                       isTapped2
                        //                                           ? FluentSystemIcons
                        //                                           .ic_fluent_thumb_like_regular
                        //                                           : FluentSystemIcons
                        //                                           .ic_fluent_thumb_like_filled,
                        //                                     ),
                        //                                     Gap(5.h),
                        //                                     Text(
                        //                                       LocaleKeys.Effective.tr(),
                        //                                       style: TextStyle(
                        //                                         fontSize: 12.sp,
                        //                                         color: Styles.defualtColor2,
                        //                                         fontFamily: 'Tajawal2',
                        //                                       ),
                        //                                     ),
                        //                                   ],
                        //                                 ),
                        //                               ),
                        //
                        //                               InkWell(
                        //                                 onTap: () {
                        //                                   setState(() {
                        //                                     isTapped3 = !isTapped3;
                        //                                     print('object');
                        //                                   });
                        //                                 },
                        //                                 child: Column(
                        //                                   children: [
                        //                                     Icon(
                        //                                       isTapped3
                        //                                           ? FluentSystemIcons
                        //                                           .ic_fluent_thumb_dislike_regular
                        //                                           : FluentSystemIcons
                        //                                           .ic_fluent_thumb_dislike_filled,
                        //                                     ),
                        //                                     Gap(5.h),
                        //                                     Text(
                        //                                       LocaleKeys.inactive.tr(),
                        //                                       style: TextStyle(
                        //                                         fontSize: 12.sp,
                        //                                         color: Styles.defualtColor2,
                        //                                         fontFamily: 'Tajawal2',
                        //                                       ),
                        //                                     ),
                        //                                   ],
                        //                                 ),
                        //                               ),
                        //                             ],
                        //                           )
                        //
                        //
                        //
                        //
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 userData.read('lang')==true ?   Container(
                        //                   color: Colors.white,
                        //                   child: Row(
                        //
                        //                     children: [
                        //                       SizedBox(
                        //                         height: 30.h,
                        //                         width:15.h,
                        //                         child: DecoratedBox(
                        //                           decoration: BoxDecoration(
                        //                               color:  Color(0xffD9D9D9) ,
                        //                               borderRadius: BorderRadius.only(
                        //                                 topLeft: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                                 bottomLeft: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                               )),
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                           child: Padding(
                        //                             padding: const EdgeInsets.all(12.0),
                        //                             child:
                        //                             LayoutBuilder(
                        //                               builder:
                        //                                   (BuildContext context, BoxConstraints constraints) {
                        //                                 return Flex(
                        //                                     direction: Axis.horizontal,
                        //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                                     mainAxisSize: MainAxisSize.max,
                        //                                     children: List.generate(
                        //                                         (constraints.constrainWidth() / 15).floor(),
                        //                                             (index) => SizedBox(
                        //                                           width:5.h,
                        //                                           height:1.h,
                        //                                           child: DecoratedBox(
                        //                                             decoration: BoxDecoration(
                        //                                               color:
                        //                                               Colors.grey.shade300,
                        //                                             ),
                        //                                           ),
                        //                                         )));
                        //                               },
                        //                             ),
                        //                           )),
                        //                       SizedBox(
                        //                         height: 30.h,
                        //                         width:15.h,
                        //                         child: DecoratedBox(
                        //                           decoration: BoxDecoration(
                        //
                        //                               color: Color(0xffD9D9D9),
                        //                               borderRadius: BorderRadius.only(
                        //                                 topRight: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                                 bottomRight: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                               )),
                        //                         ),
                        //                       ),
                        //
                        //                     ],
                        //                   ),
                        //                 ):
                        //                 Container(
                        //                   color: Colors.white,
                        //                   child: Row(
                        //
                        //                     children: [
                        //                       SizedBox(
                        //                         height: 30.h,
                        //                         width:15.h,
                        //                         child: DecoratedBox(
                        //                           decoration: BoxDecoration(
                        //
                        //                               color: Color(0xffD9D9D9),
                        //                               borderRadius: BorderRadius.only(
                        //                                 topRight: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                                 bottomRight: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                               )),
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                           child: Padding(
                        //                             padding: const EdgeInsets.all(12.0),
                        //                             child:
                        //                             LayoutBuilder(
                        //                               builder:
                        //                                   (BuildContext context, BoxConstraints constraints) {
                        //                                 return Flex(
                        //                                     direction: Axis.horizontal,
                        //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                                     mainAxisSize: MainAxisSize.max,
                        //                                     children: List.generate(
                        //                                         (constraints.constrainWidth() / 15).floor(),
                        //                                             (index) => SizedBox(
                        //                                           width:5.h,
                        //                                           height:1.h,
                        //                                           child: DecoratedBox(
                        //                                             decoration: BoxDecoration(
                        //                                               color:
                        //                                               Colors.grey.shade300,
                        //                                             ),
                        //                                           ),
                        //                                         )));
                        //                               },
                        //                             ),
                        //                           )),
                        //
                        //                       SizedBox(
                        //                         height: 30.h,
                        //                         width:15.h,
                        //                         child: DecoratedBox(
                        //                           decoration: BoxDecoration(
                        //                               color:  Color(0xffD9D9D9) ,
                        //                               borderRadius: BorderRadius.only(
                        //                                 topLeft: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                                 bottomLeft: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                               )),
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //
                        //                 Container(
                        //                   height: 50.h,
                        //                   width: double.infinity,
                        //                   padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 10.h),
                        //                   decoration: BoxDecoration(
                        //                       color: Colors.white,
                        //                       borderRadius: BorderRadius.only(
                        //                         bottomLeft: Radius.circular(
                        //                           20.h,
                        //                         ),
                        //                         bottomRight: Radius.circular(
                        //                           20.h,
                        //                         ),
                        //                       )
                        //                   ),
                        //                   child: Column(
                        //                     mainAxisAlignment: MainAxisAlignment.start,
                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                     children: [
                        //                       buildBottum(
                        //                         height: 30.h,
                        //                         decoration: BoxDecoration(
                        //                           color: Styles.defualtColor,
                        //                           borderRadius: BorderRadius.circular(25),
                        //                         ),
                        //                         width: double.infinity,
                        //                         text: Text(
                        //                           LocaleKeys.Copy.tr(),
                        //                           style: TextStyle(
                        //                               color: Colors.white,
                        //                               fontSize: 16.sp,
                        //                               fontWeight: FontWeight.w600),
                        //                           textAlign: TextAlign.center,
                        //                         ),
                        //                         onTap: () async {
                        //                           await Clipboard.setData(ClipboardData(text: '${e.storSaleCode}'));
                        //                           print('do');
                        //                           Fluttertoast.showToast(
                        //                               msg: LocaleKeys
                        //                                   .Done
                        //                                   .tr(),
                        //                               toastLength: Toast.LENGTH_SHORT,
                        //                               gravity: ToastGravity.BOTTOM,
                        //                               timeInSecForIosWeb: 1,
                        //                               textColor: Colors.white,
                        //                               fontSize: 16.0);
                        //                           // copied successfully
                        //                         },
                        //                       ),
                        //
                        //
                        //
                        //                     ],
                        //                   ),
                        //                 ),
                        //
                        //               ],
                        //             ),
                        //           ),
                        //         );});});
                        //
                        //
                      },
                      child:
                      Column(
                        children: [
                          Container(
                            height: 90.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 1,
                                  blurRadius: 13,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],

                            ),
                            child: Column(

                              children: [

                                CouponCard(
                                  height: 90.h,
                                  backgroundColor: Colors.transparent,
                                  clockwise: true,
                                  curvePosition: 110,
                                  curveRadius: 25,
                                  curveAxis: Axis.vertical,
                                  borderRadius: 8,


                                  firstChild: Container(
                                    alignment: Alignment.center,
                                    decoration:   BoxDecoration(
                                        color: Colors.white,

                                        image: DecorationImage(

                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                'http://saudi07-001-site2.itempurl.com/${e.storImgUrl}'
                                            )
                                        )
                                    ),

                                  ),
                                  secondChild: Container(
                                    alignment: Alignment.centerLeft,
                                    width: double.maxFinite,
                                    padding:   EdgeInsets.all(18.h),
                                    decoration:   BoxDecoration(

                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${ e.storTitle}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        SizedBox(height: 4.h),
                                        Expanded(
                                          flex: 4,
                                          child: SizedBox(
                                            width: 100.h,
                                            child: Text(
                                              '${LocaleKeys.Offer} :${e.storOffer}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade400,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                )



                              ],
                            ),
                          ),
                          Gap(20.h)
                        ],
                      ),





                      // Container(
                      //   //
                      //   // padding: EdgeInsets.symmetric(
                      //   //     horizontal: 15.h,  vertical: 5.h),
                      //   decoration: BoxDecoration(
                      //     // color: Styles.defualtColor3,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.grey.shade400,
                      //         spreadRadius: 1,
                      //         blurRadius: 2,
                      //         offset: Offset(0, 1),
                      //       ),
                      //     ],
                      //
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment
                      //         .center,
                      //     crossAxisAlignment: CrossAxisAlignment
                      //         .center,
                      //     children: [
                      //       SvgPicture.asset('assets/Path 5.svg',height: 60.h,),
                      //       SvgPicture.asset('assets/Path 4.svg',height: 60.h,),
                      //
                      //       // CircleAvatar(
                      //       //   backgroundImage: NetworkImage(
                      //       //     'http://eibtek2-001-site5.atempurl.com/${e.storImgUrl}',
                      //       //
                      //       //   ),
                      //       //   backgroundColor: Colors.transparent,
                      //       //
                      //       //   radius: 30.r,
                      //       // ),
                      //       // Gap(20.h),
                      //       // Column(
                      //       //   mainAxisAlignment: MainAxisAlignment
                      //       //       .center,
                      //       //   crossAxisAlignment: CrossAxisAlignment
                      //       //       .start,
                      //       //   children: [
                      //       //     Text('${e.storTitle}',
                      //       //       style: TextStyle(
                      //       //           fontSize: 15.sp,
                      //       //           fontFamily: 'Tajawal2',
                      //       //           color: Styles.defualtColor2
                      //       //       ),),
                      //       //     Gap(3.h),
                      //       //     Flexible(
                      //       //       child: SizedBox(
                      //       //         width: 180.h,
                      //       //         child: Text('${LocaleKeys.Offer.tr()} : ${e.storOffer}',
                      //       //           maxLines: 1,
                      //       //           style: TextStyle(
                      //       //               fontSize: 14.sp,
                      //       //               fontFamily: 'Tajawal7',
                      //       //               color: Styles.defualtColor4
                      //       //           ),),
                      //       //       ),
                      //       //     ),
                      //       //   ],
                      //       // ),
                      //
                      //
                      //
                      //
                      //
                      //
                      //     ],
                      //   ),
                      // ),
                    ),
                  ),
                  // Gap(15.h),

                ],
              ),).toList(),

            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Styles.defualtColor),
            ),
          );
        }
      },
    );
  }
  final userData =GetStorage();
  Future<CategoryIdallModel?> catallid( String? query ) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://saudi07-001-site2.itempurl.com/api/GetAllStores/${ userData.read('country')}'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "SearchValue":query,
            "userId":userData.read('token'),

          }));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var log = json.decode(response.body);
        print('dataId==${data}');
        if (query != null) {
          result = result
              .where((element) =>
              query.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print("Faild");
      }
      return CategoryIdallModel.fromJson(data);
    } catch (e) {
      print(e.toString());
    }
  }

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
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
       // Get.offAll(BottomNavScreen());
        Fluttertoast.showToast(
            msg: LocaleKeys
                .Added_To_Favorite_Successfully
                .tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());
    }
  }
  double rating=0;
  Set<String> savedWords = Set<String>();

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder (
      future: catallid(''),
      builder: (context, snapshot){


        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: snapshot.data!.records!.map((e) =>   Column(

                children: [

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: InkWell(
                      onTap: () {
                        userData.write('storeId', e.id);
                        print(e.id);

                        Get.to(NoonTicketScreen(img:    CircleAvatar(
                          backgroundImage: NetworkImage(
                            'http://saudi07-001-site2.itempurl.com/${e.storImgUrl}',

                          ),
                          backgroundColor: Colors.transparent,

                          radius: 50.r,
                        ),
                          storeName: '${e.storTitle}',
                          storeOffer: ' ${e.storOffer}', storeDetails: ' ${e.storDeteils}',
                          storelink: (){
                            _launchUrl('${e.storLink}');

                          }, storePhone: '${e.storPhoneNumber}', storeCode: '${e.storSaleCode}', storeCountry: '${e.countries!.contName}',
                          fav: FavoriteButton(
                            iconColor: Styles.defualtColor,
                            iconSize: 30.sp,
                            isFavorite: e.isFaviourite ,
                            valueChanged: (val) {
                              e.isFaviourite==false?
                              Favorite():DelelteFavorite();
                              val== e.isFaviourite;
                              print(e.isFaviourite);
                            },
                          ),
                        ));
                        // showModalBottomSheet(
                        //     isScrollControlled:true,
                        //     backgroundColor: Color(0xffD9D9D9),
                        //     context: context, builder: (context){
                        //       return
                        //         StatefulBuilder(builder: (BuildContext context, StateSetter setState){return   SizedBox(
                        //           height: 520.h,
                        //           child: Padding(
                        //             padding:   EdgeInsets.symmetric(horizontal: 20.h, ),
                        //             child: Column(
                        //               children: [
                        //                 Expanded(
                        //
                        //                   child: SingleChildScrollView(
                        //                     child: Container(
                        //
                        //                       padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 20.h),
                        //                       decoration: BoxDecoration(
                        //                           color: Colors.white,
                        //                           borderRadius: BorderRadius.only(
                        //                             topRight: Radius.circular(
                        //                               20.h,
                        //                             ),
                        //                             topLeft: Radius.circular(
                        //                               20.h,
                        //                             ),
                        //                           )
                        //                       ),
                        //                       child: Column(
                        //                         mainAxisAlignment: MainAxisAlignment.center,
                        //                         crossAxisAlignment: CrossAxisAlignment.center,
                        //                         children: [
                        //
                        //
                        //                           Row(
                        //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                             children: [
                        //                               InkWell(
                        //                                 child: Icon(
                        //                                   Icons.cancel_sharp,
                        //                                   color: Styles.defualtColor2,
                        //                                   size: 25.sp,
                        //                                 ),
                        //                                 onTap: () {
                        //                                   Get.back();
                        //                                 },
                        //                               ),
                        //
                        //                               InkWell(
                        //                                 onTap: (){   _launchUrl('${e.storLink}');},
                        //                                 child: Icon(
                        //                                   Icons.share,
                        //                                   color: Styles.defualtColor2,
                        //                                   size: 25.sp,
                        //                                 ),
                        //                               )
                        //                             ],
                        //                           ),
                        //                           Center(child:
                        //                           CircleAvatar(
                        //                             backgroundImage: NetworkImage(
                        //                               'http://eibtek2-001-site5.atempurl.com/${e.storImgUrl}',
                        //
                        //                             ),
                        //                             backgroundColor: Colors.transparent,
                        //
                        //                             radius: 50.r,
                        //                           )
                        //
                        //                           ),
                        //
                        //                           Gap(20.h),
                        //                           Text(
                        //                             '${e.storTitle}',
                        //                             style: TextStyle(
                        //                               fontSize: 20.sp,
                        //                               fontFamily: 'Tajawal2',
                        //                             ),
                        //                             textAlign: TextAlign.center,
                        //                           ),
                        //                           Divider(
                        //                             height: 15.h,
                        //                             color:Colors.grey.shade600,
                        //                             thickness: .1,
                        //                           ),
                        //                           Gap(5.h),
                        //                           Text(
                        //                             '${LocaleKeys.Offer.tr()} :',
                        //                             style: TextStyle(
                        //                               fontSize: 15.sp,
                        //                               color: Styles.defualtColor,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //                           Gap(5.h),
                        //                           Text(
                        //                             '${e.storOffer}',
                        //                             style: TextStyle(
                        //                               fontSize: 13.sp,
                        //                               color: Styles.defualtColor2,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //                           Gap(10.h),
                        //                           Text(
                        //                             '${LocaleKeys.Offered_discount_code.tr()} :',
                        //                             style: TextStyle(
                        //                               fontSize: 15.sp,
                        //                               color: Styles.defualtColor,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //                           Gap(5.h),
                        //                           SelectableText(
                        //                             '${e.storSaleCode}',
                        //                             style: TextStyle(
                        //                               fontSize: 13.sp,
                        //                               color: Styles.defualtColor2,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //                           Gap(10.h),
                        //
                        //                           Text(
                        //                             '${LocaleKeys.Country.tr()} :',
                        //                             style: TextStyle(
                        //                               fontSize: 15.sp,
                        //                               color: Styles.defualtColor,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //                           Gap(5.h),
                        //                           Text(
                        //                             '${userData.read('nameCountry')}',
                        //                             style: TextStyle(
                        //                               fontSize: 13.sp,
                        //                               color: Styles.defualtColor2,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //
                        //
                        //                           Gap(10.h),
                        //                           Text(
                        //                             '${LocaleKeys.Details.tr()} :',
                        //                             style: TextStyle(
                        //                               fontSize: 15.sp,
                        //                               color: Styles.defualtColor,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //                           Gap(5.h),
                        //                           Text(
                        //                             '${e.storDeteils}',
                        //                             style: TextStyle(
                        //                               fontSize: 13.sp,
                        //                               color: Styles.defualtColor2,
                        //                               fontFamily: 'Tajawal7',
                        //                             ),
                        //                           ),
                        //
                        //                           Gap(10.h),
                        //
                        //
                        //                           Row(
                        //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                             children: [
                        //                               InkWell(
                        //                                 onTap: (){
                        //                                   _launchUrl('${e.storLink}');
                        //
                        //                                 },
                        //                                 child: Column(
                        //                                   children: [
                        //                                     Icon(Icons.link),
                        //                                     Gap(5.h),
                        //                                     Text(
                        //                                       LocaleKeys.Link.tr(),
                        //                                       style: TextStyle(
                        //                                         fontSize: 12.sp,
                        //                                         color: Styles.defualtColor2,
                        //                                         fontFamily: 'Tajawal2',
                        //                                       ),
                        //                                     ),
                        //                                   ],
                        //                                 ),
                        //                               ),
                        //
                        //                               // Column(
                        //                               //   children: [
                        //                               //
                        //                               //     InkWell(
                        //                               //         onTap: (){
                        //                               //           DelelteFavorite();
                        //                               //           Fluttertoast.showToast(
                        //                               //               msg: LocaleKeys
                        //                               //                   .Deleted_From_Favorite_Successfully
                        //                               //                   .tr(),
                        //                               //               toastLength: Toast.LENGTH_SHORT,
                        //                               //               gravity: ToastGravity.BOTTOM,
                        //                               //               timeInSecForIosWeb: 1,
                        //                               //               textColor: Colors.white,
                        //                               //               fontSize: 16.0);
                        //                               //         },
                        //                               //         child: Icon(Icons.favorite_border,
                        //                               //           )),
                        //                               //     Gap(5.h),
                        //                               //     Text(
                        //                               //       LocaleKeys.UnFavorite.tr(),
                        //                               //       style: TextStyle(
                        //                               //         fontSize: 12.sp,
                        //                               //         color: Styles.defualtColor2,
                        //                               //         fontFamily: 'Tajawal2',
                        //                               //       ),
                        //                               //     ),
                        //                               //   ],
                        //                               // ),
                        //
                        //                               Column(
                        //                                 children: [
                        //
                        //                                   InkWell(
                        //                                       onTap: (){
                        //                                         Favorite();
                        //                                         print(e.id);
                        //
                        //                                         Fluttertoast.showToast(
                        //                                             msg: LocaleKeys
                        //                                                 .Added_To_Favorite_Successfully
                        //                                                 .tr(),
                        //                                             toastLength: Toast.LENGTH_SHORT,
                        //                                             gravity: ToastGravity.BOTTOM,
                        //                                             timeInSecForIosWeb: 1,
                        //                                             textColor: Colors.white,
                        //                                             fontSize: 16.0);
                        //                                       },
                        //                                       child: Icon(Icons.favorite,
                        //                                       )),
                        //                                   Gap(5.h),
                        //                                   Text(
                        //                                     LocaleKeys.Favorite.tr(),
                        //                                     style: TextStyle(
                        //                                       fontSize: 12.sp,
                        //                                       color: Styles.defualtColor2,
                        //                                       fontFamily: 'Tajawal2',
                        //                                     ),
                        //                                   ),
                        //                                 ],
                        //                               ),
                        //
                        //                               InkWell(
                        //                                 onTap: () {
                        //                                   setState(() {
                        //                                     isTapped2 = !isTapped2;
                        //                                     print('object');
                        //                                   });
                        //                                 },
                        //                                 child: Column(
                        //                                   children: [
                        //                                     Icon(
                        //                                       isTapped2
                        //                                           ? FluentSystemIcons
                        //                                           .ic_fluent_thumb_like_regular
                        //                                           : FluentSystemIcons
                        //                                           .ic_fluent_thumb_like_filled,
                        //                                     ),
                        //                                     Gap(5.h),
                        //                                     Text(
                        //                                       LocaleKeys.Effective.tr(),
                        //                                       style: TextStyle(
                        //                                         fontSize: 12.sp,
                        //                                         color: Styles.defualtColor2,
                        //                                         fontFamily: 'Tajawal2',
                        //                                       ),
                        //                                     ),
                        //                                   ],
                        //                                 ),
                        //                               ),
                        //
                        //                               InkWell(
                        //                                 onTap: () {
                        //                                   setState(() {
                        //                                     isTapped3 = !isTapped3;
                        //                                     print('object');
                        //                                   });
                        //                                 },
                        //                                 child: Column(
                        //                                   children: [
                        //                                     Icon(
                        //                                       isTapped3
                        //                                           ? FluentSystemIcons
                        //                                           .ic_fluent_thumb_dislike_regular
                        //                                           : FluentSystemIcons
                        //                                           .ic_fluent_thumb_dislike_filled,
                        //                                     ),
                        //                                     Gap(5.h),
                        //                                     Text(
                        //                                       LocaleKeys.inactive.tr(),
                        //                                       style: TextStyle(
                        //                                         fontSize: 12.sp,
                        //                                         color: Styles.defualtColor2,
                        //                                         fontFamily: 'Tajawal2',
                        //                                       ),
                        //                                     ),
                        //                                   ],
                        //                                 ),
                        //                               ),
                        //                             ],
                        //                           )
                        //
                        //
                        //
                        //
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 userData.read('lang')==true ?   Container(
                        //                   color: Colors.white,
                        //                   child: Row(
                        //
                        //                     children: [
                        //                       SizedBox(
                        //                         height: 30.h,
                        //                         width:15.h,
                        //                         child: DecoratedBox(
                        //                           decoration: BoxDecoration(
                        //                               color:  Color(0xffD9D9D9) ,
                        //                               borderRadius: BorderRadius.only(
                        //                                 topLeft: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                                 bottomLeft: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                               )),
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                           child: Padding(
                        //                             padding: const EdgeInsets.all(12.0),
                        //                             child:
                        //                             LayoutBuilder(
                        //                               builder:
                        //                                   (BuildContext context, BoxConstraints constraints) {
                        //                                 return Flex(
                        //                                     direction: Axis.horizontal,
                        //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                                     mainAxisSize: MainAxisSize.max,
                        //                                     children: List.generate(
                        //                                         (constraints.constrainWidth() / 15).floor(),
                        //                                             (index) => SizedBox(
                        //                                           width:5.h,
                        //                                           height:1.h,
                        //                                           child: DecoratedBox(
                        //                                             decoration: BoxDecoration(
                        //                                               color:
                        //                                               Colors.grey.shade300,
                        //                                             ),
                        //                                           ),
                        //                                         )));
                        //                               },
                        //                             ),
                        //                           )),
                        //                       SizedBox(
                        //                         height: 30.h,
                        //                         width:15.h,
                        //                         child: DecoratedBox(
                        //                           decoration: BoxDecoration(
                        //
                        //                               color: Color(0xffD9D9D9),
                        //                               borderRadius: BorderRadius.only(
                        //                                 topRight: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                                 bottomRight: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                               )),
                        //                         ),
                        //                       ),
                        //
                        //                     ],
                        //                   ),
                        //                 ):
                        //                 Container(
                        //                   color: Colors.white,
                        //                   child: Row(
                        //
                        //                     children: [
                        //                       SizedBox(
                        //                         height: 30.h,
                        //                         width:15.h,
                        //                         child: DecoratedBox(
                        //                           decoration: BoxDecoration(
                        //
                        //                               color: Color(0xffD9D9D9),
                        //                               borderRadius: BorderRadius.only(
                        //                                 topRight: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                                 bottomRight: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                               )),
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                           child: Padding(
                        //                             padding: const EdgeInsets.all(12.0),
                        //                             child:
                        //                             LayoutBuilder(
                        //                               builder:
                        //                                   (BuildContext context, BoxConstraints constraints) {
                        //                                 return Flex(
                        //                                     direction: Axis.horizontal,
                        //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                                     mainAxisSize: MainAxisSize.max,
                        //                                     children: List.generate(
                        //                                         (constraints.constrainWidth() / 15).floor(),
                        //                                             (index) => SizedBox(
                        //                                           width:5.h,
                        //                                           height:1.h,
                        //                                           child: DecoratedBox(
                        //                                             decoration: BoxDecoration(
                        //                                               color:
                        //                                               Colors.grey.shade300,
                        //                                             ),
                        //                                           ),
                        //                                         )));
                        //                               },
                        //                             ),
                        //                           )),
                        //
                        //                       SizedBox(
                        //                         height: 30.h,
                        //                         width:15.h,
                        //                         child: DecoratedBox(
                        //                           decoration: BoxDecoration(
                        //                               color:  Color(0xffD9D9D9) ,
                        //                               borderRadius: BorderRadius.only(
                        //                                 topLeft: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                                 bottomLeft: Radius.circular(
                        //                                   20.h,
                        //                                 ),
                        //                               )),
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //
                        //                 Container(
                        //                   height: 50.h,
                        //                   width: double.infinity,
                        //                   padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 10.h),
                        //                   decoration: BoxDecoration(
                        //                       color: Colors.white,
                        //                       borderRadius: BorderRadius.only(
                        //                         bottomLeft: Radius.circular(
                        //                           20.h,
                        //                         ),
                        //                         bottomRight: Radius.circular(
                        //                           20.h,
                        //                         ),
                        //                       )
                        //                   ),
                        //                   child: Column(
                        //                     mainAxisAlignment: MainAxisAlignment.start,
                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                     children: [
                        //                       buildBottum(
                        //                         height: 30.h,
                        //                         decoration: BoxDecoration(
                        //                           color: Styles.defualtColor,
                        //                           borderRadius: BorderRadius.circular(25),
                        //                         ),
                        //                         width: double.infinity,
                        //                         text: Text(
                        //                           LocaleKeys.Copy.tr(),
                        //                           style: TextStyle(
                        //                               color: Colors.white,
                        //                               fontSize: 16.sp,
                        //                               fontWeight: FontWeight.w600),
                        //                           textAlign: TextAlign.center,
                        //                         ),
                        //                         onTap: () async {
                        //                           await Clipboard.setData(ClipboardData(text: '${e.storSaleCode}'));
                        //                           print('do');
                        //                           Fluttertoast.showToast(
                        //                               msg: LocaleKeys
                        //                                   .Done
                        //                                   .tr(),
                        //                               toastLength: Toast.LENGTH_SHORT,
                        //                               gravity: ToastGravity.BOTTOM,
                        //                               timeInSecForIosWeb: 1,
                        //                               textColor: Colors.white,
                        //                               fontSize: 16.0);
                        //                           // copied successfully
                        //                         },
                        //                       ),
                        //
                        //
                        //
                        //                     ],
                        //                   ),
                        //                 ),
                        //
                        //               ],
                        //             ),
                        //           ),
                        //         );});});
                        //
                        //
                      },
                      child:
                      Column(
                        children: [
                          Container(
                            height: 90.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 1,
                                  blurRadius: 13,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],

                            ),
                            child: Column(

                              children: [

                                CouponCard(
                                  height: 90.h,
                                  backgroundColor: Colors.transparent,
                                  clockwise: true,
                                  curvePosition: 110,
                                  curveRadius: 25,
                                  curveAxis: Axis.vertical,
                                  borderRadius: 8,


                                  firstChild: Container(
                                    alignment: Alignment.center,
                                    decoration:   BoxDecoration(
                                        color: Colors.white,

                                        image: DecorationImage(

                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                'http://saudi07-001-site2.itempurl.com/${e.storImgUrl}'
                                            )
                                        )
                                    ),

                                  ),
                                  secondChild: Container(
                                    alignment: Alignment.centerLeft,
                                    width: double.maxFinite,
                                    padding:   EdgeInsets.all(18.h),
                                    decoration:   BoxDecoration(

                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${ e.storTitle}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        SizedBox(height: 4.h),
                                        Expanded(
                                          flex: 4,
                                          child: SizedBox(
                                            width: 100.h,
                                            child: Text(
                                              '${LocaleKeys.Offer} :${e.storOffer}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade400,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                )



                              ],
                            ),
                          ),
                          Gap(20.h)
                        ],
                      ),





                      // Container(
                      //   //
                      //   // padding: EdgeInsets.symmetric(
                      //   //     horizontal: 15.h,  vertical: 5.h),
                      //   decoration: BoxDecoration(
                      //     // color: Styles.defualtColor3,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.grey.shade400,
                      //         spreadRadius: 1,
                      //         blurRadius: 2,
                      //         offset: Offset(0, 1),
                      //       ),
                      //     ],
                      //
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment
                      //         .center,
                      //     crossAxisAlignment: CrossAxisAlignment
                      //         .center,
                      //     children: [
                      //       SvgPicture.asset('assets/Path 5.svg',height: 60.h,),
                      //       SvgPicture.asset('assets/Path 4.svg',height: 60.h,),
                      //
                      //       // CircleAvatar(
                      //       //   backgroundImage: NetworkImage(
                      //       //     'http://eibtek2-001-site5.atempurl.com/${e.storImgUrl}',
                      //       //
                      //       //   ),
                      //       //   backgroundColor: Colors.transparent,
                      //       //
                      //       //   radius: 30.r,
                      //       // ),
                      //       // Gap(20.h),
                      //       // Column(
                      //       //   mainAxisAlignment: MainAxisAlignment
                      //       //       .center,
                      //       //   crossAxisAlignment: CrossAxisAlignment
                      //       //       .start,
                      //       //   children: [
                      //       //     Text('${e.storTitle}',
                      //       //       style: TextStyle(
                      //       //           fontSize: 15.sp,
                      //       //           fontFamily: 'Tajawal2',
                      //       //           color: Styles.defualtColor2
                      //       //       ),),
                      //       //     Gap(3.h),
                      //       //     Flexible(
                      //       //       child: SizedBox(
                      //       //         width: 180.h,
                      //       //         child: Text('${LocaleKeys.Offer.tr()} : ${e.storOffer}',
                      //       //           maxLines: 1,
                      //       //           style: TextStyle(
                      //       //               fontSize: 14.sp,
                      //       //               fontFamily: 'Tajawal7',
                      //       //               color: Styles.defualtColor4
                      //       //           ),),
                      //       //       ),
                      //       //     ),
                      //       //   ],
                      //       // ),
                      //
                      //
                      //
                      //
                      //
                      //
                      //     ],
                      //   ),
                      // ),
                    ),
                  ),
                  // Gap(15.h),

                ],
              ),).toList(),

            ),
          );



        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Styles.defualtColor),
            ),
          );
        }
      },
    );
  }
  Future<void> _launchUrl(String link ) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}