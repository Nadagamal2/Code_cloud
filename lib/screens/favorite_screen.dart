import 'dart:convert';

import 'package:copons/components/app_style.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:favorite_button/favorite_button.dart';
  import 'package:fluentui_icons/fluentui_icons.dart';
  import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
   import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
  import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

  import '../components/component.dart';
import '../models/favModel.dart';
import '../translations/locale_keys.g.dart';
import 'bottom_nav.dart';
import 'noonFavorite.dart';
import 'noon_ticket.dart';
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool isTapped2 = true;
  bool isTapped3 = true;
  final userData =GetStorage();

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
  Future<favModel?> FavoritId(  )async{
    try{
      var response = await http.post(
          Uri.parse('http://saudi07-001-site2.itempurl.com/api/Get_Faviourites_byUserId/${userData.read('token')}'),
          headers: {
            "Content-Type": "application/json",
          },

          );
      var data=jsonDecode(response.body.toString());
      if(response.statusCode==200){
        print(data);

      }else{

        print("Faild");
      }
      return favModel.fromJson(jsonDecode(response.body));



    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar:    AppBar(
  backgroundColor: Styles.defualtColor2,
  centerTitle: true,
  elevation: 0,
  automaticallyImplyLeading: false,
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.r),bottomRight:Radius.circular(25.r) )
  ),

  title:  Text( "Favorite".tr(), style: TextStyle(
    fontFamily: 'Tajawal2',
    color: Styles.defualtColor3,
    fontSize: 18.sp,
  ),),
  toolbarHeight: 70.h,


),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(20.h),

        FutureBuilder (
          future: FavoritId(),
          builder: (context, snapshot){


            if (snapshot.hasData) {
              return SizedBox(
                height: 520.h,
                child: ListView.separated(
                  padding: EdgeInsets.all(5.h),
                  itemCount: snapshot.data!.newRecords!.length,
                  itemBuilder: (context, index) =>
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            child: InkWell(
                              onTap: () {
                                // Get.to(NoonTicketScreen(img:    CircleAvatar(
                                //   backgroundImage: NetworkImage(
                                //     'http://eibtek2-001-site5.atempurl.com/${snapshot.data!.records![index].stores!.storImgUrl}',
                                //
                                //   ),
                                //   backgroundColor: Colors.transparent,
                                //
                                //   radius: 40.r,
                                // ),
                                //   storePhone: '${snapshot.data!.records![index].stores!.storPhoneNumber}',
                                //   storeName: '${snapshot.data!.records![index].stores!.storTitle}',
                                //   storeOffer: '${snapshot.data!.records![index].stores!.storOffer}', storeDetails: '${snapshot.data!.records![index].stores!.storDeteils}',
                                //   storelink: (){
                                //     _launchUrl('${snapshot.data!.records![index].stores!.storLink}');
                                //
                                //   }, storeCode: '${snapshot.data!.records![index].stores!.storSaleCode}', isFavorite: snapshot.data!.records![index].stores!.isFaviourite!, isSpecial: snapshot.data!.records![index].stores!.isSpecial!,
                                // ));
                                userData.write('delete', snapshot.data!.newRecords![index].userFaviouriteId);
                                print(snapshot.data!.newRecords![index].userFaviouriteId);
                                print(snapshot.data!.newRecords![index].countries!.contName);
                                userData.write('storeId', snapshot.data!.newRecords![index].id);
                                userData.write('countryFavId', snapshot.data!.newRecords![index].countries!.contName);
                                print(snapshot.data!.newRecords![index].id);

                                Get.to(NoonTicketFavScreen(img:    CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    'http://saudi07-001-site2.itempurl.com/${snapshot.data!.newRecords![index].storImgUrl}',

                                  ),
                                  backgroundColor: Colors.transparent,

                                  radius: 50.r,
                                ),
                                  storeName: '${snapshot.data!.newRecords![index].storTitle}',
                                  storeOffer: ' ${snapshot.data!.newRecords![index].storOffer}', storeDetails: ' ${snapshot.data!.newRecords![index].storDeteils}',
                                  storelink: (){
                                    _launchUrl('${snapshot.data!.newRecords![index].storLink}');

                                  }, storePhone: '${snapshot.data!.newRecords![index].storPhoneNumber}', storeCode: '${snapshot.data!.newRecords![index].storSaleCode}', storeCountry: '${snapshot.data!.newRecords![index].countries!.contName}',
                                  fav: FavoriteButton(
                                    iconColor: Styles.defualtColor,
                                    iconSize: 30.sp,
                                    isFavorite:  true ,
                                    valueChanged: (val) {

                                      DelelteFavorite();

                                    },
                                  ),
                                ));
                                // showModalBottomSheet(
                                //     isScrollControlled:true,
                                //     backgroundColor: Color(0xffD9D9D9),
                                //     context: context, builder: (context){
                                //   return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                                //     return  SizedBox(
                                //       height: 520.h,
                                //       child: Padding(
                                //         padding:   EdgeInsets.symmetric(horizontal: 20.h, ),
                                //         child: Column(
                                //           children: [
                                //             Expanded(
                                //               child: SingleChildScrollView(
                                //                 child: Container(
                                //
                                //                   padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 20.h),
                                //                   decoration: BoxDecoration(
                                //                       color: Colors.white,
                                //                       borderRadius: BorderRadius.only(
                                //                         topRight: Radius.circular(
                                //                           20.h,
                                //                         ),
                                //                         topLeft: Radius.circular(
                                //                           20.h,
                                //                         ),
                                //                       )
                                //                   ),
                                //                   child: Column(
                                //                     mainAxisAlignment: MainAxisAlignment.center,
                                //                     crossAxisAlignment: CrossAxisAlignment.center,
                                //                     children: [
                                //
                                //
                                //                       Row(
                                //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //                         children: [
                                //                           InkWell(
                                //                             child: Icon(
                                //                               Icons.cancel_sharp,
                                //                               color: Styles.defualtColor2,
                                //                               size: 25.sp,
                                //                             ),
                                //                             onTap: () {
                                //                               Get.back();
                                //                             },
                                //                           ),
                                //
                                //                           InkWell(
                                //                             onTap: (){   _launchUrl('${snapshot.data!.records![index].stores!.storLink}');},
                                //                             child: Icon(
                                //                               Icons.share,
                                //                               color: Styles.defualtColor2,
                                //                               size: 25.sp,
                                //                             ),
                                //                           )
                                //                         ],
                                //                       ),
                                //                       Center(child:
                                //                       CircleAvatar(
                                //                         backgroundImage: NetworkImage(
                                //                           'http://eibtek2-001-site5.atempurl.com/Uploads/Stores/${snapshot.data!.records![index].stores!.storImgUrl}',
                                //
                                //                         ),
                                //                         backgroundColor: Colors.transparent,
                                //
                                //                         radius: 50.r,
                                //                       )
                                //
                                //                       ),
                                //
                                //                       Gap(20.h),
                                //                       Text(
                                //                         '${snapshot.data!.records![index].stores!.storTitle}',
                                //                         style: TextStyle(
                                //                           fontSize: 20.sp,
                                //                           fontFamily: 'Tajawal2',
                                //                         ),
                                //                         textAlign: TextAlign.center,
                                //                       ),
                                //                       Divider(
                                //                         height: 15.h,
                                //                         color:Colors.grey.shade600,
                                //                         thickness: .1,
                                //                       ),
                                //                       Gap(5.h),
                                //                       Text(
                                //                         '${LocaleKeys.Offer.tr()} :',
                                //                         style: TextStyle(
                                //                           fontSize: 15.sp,
                                //                           color: Styles.defualtColor,
                                //                           fontFamily: 'Tajawal7',
                                //                         ),
                                //                       ),
                                //                       Gap(5.h),
                                //                       Text(
                                //                         '${snapshot.data!.records![index].stores!.storOffer}',
                                //                         style: TextStyle(
                                //                           fontSize: 13.sp,
                                //                           color: Styles.defualtColor2,
                                //                           fontFamily: 'Tajawal7',
                                //                         ),
                                //                       ),
                                //                       Gap(10.h),
                                //                       Text(
                                //                         '${LocaleKeys.Offered_discount_code.tr()} :',
                                //                         style: TextStyle(
                                //                           fontSize: 15.sp,
                                //                           color: Styles.defualtColor,
                                //                           fontFamily: 'Tajawal7',
                                //                         ),
                                //                       ),
                                //                       Gap(5.h),
                                //                       SelectableText(
                                //                         '${snapshot.data!.records![index].stores!.storSaleCode}',
                                //                         style: TextStyle(
                                //                           fontSize: 13.sp,
                                //                           color: Styles.defualtColor2,
                                //                           fontFamily: 'Tajawal7',
                                //                         ),
                                //                       ),
                                //                       Gap(10.h),
                                //
                                //                       Text(
                                //                         '${LocaleKeys.Country.tr()} :',
                                //                         style: TextStyle(
                                //                           fontSize: 15.sp,
                                //                           color: Styles.defualtColor,
                                //                           fontFamily: 'Tajawal7',
                                //                         ),
                                //                       ),
                                //                       Gap(5.h),
                                //                       Text(
                                //                         '${userData.read('nameCountry')}',
                                //                         style: TextStyle(
                                //                           fontSize: 13.sp,
                                //                           color: Styles.defualtColor2,
                                //                           fontFamily: 'Tajawal7',
                                //                         ),
                                //                       ),
                                //
                                //
                                //                       Gap(10.h),
                                //                       Text(
                                //                         '${LocaleKeys.Details.tr()} :',
                                //                         style: TextStyle(
                                //                           fontSize: 15.sp,
                                //                           color: Styles.defualtColor,
                                //                           fontFamily: 'Tajawal7',
                                //                         ),
                                //                       ),
                                //                       Gap(5.h),
                                //                       Text(
                                //                         '${snapshot.data!.records![index].stores!.storDeteils}',
                                //                         style: TextStyle(
                                //                           fontSize: 13.sp,
                                //                           color: Styles.defualtColor2,
                                //                           fontFamily: 'Tajawal7',
                                //                         ),
                                //                       ),
                                //
                                //                       Gap(10.h),
                                //
                                //                       Row(
                                //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //                         children: [
                                //                           InkWell(
                                //                             onTap: (){
                                //                               _launchUrl('${snapshot.data!.records![index].stores!.storLink}');
                                //
                                //                             },
                                //                             child: Column(
                                //                               children: [
                                //                                 Icon(Icons.link),
                                //                                 Gap(5.h),
                                //                                 Text(
                                //                                   LocaleKeys.Link.tr(),
                                //                                   style: TextStyle(
                                //                                     fontSize: 12.sp,
                                //                                     color: Styles.defualtColor2,
                                //                                     fontFamily: 'Tajawal2',
                                //                                   ),
                                //                                 ),
                                //                               ],
                                //                             ),
                                //                           ),
                                //
                                //                           Column(
                                //                             children: [
                                //
                                //                               InkWell(
                                //                                   onTap: (){
                                //                                     DelelteFavorite();
                                //                                     Fluttertoast.showToast(
                                //                                         msg: LocaleKeys
                                //                                             .Deleted_From_Favorite_Successfully
                                //                                             .tr(),
                                //                                         toastLength: Toast.LENGTH_SHORT,
                                //                                         gravity: ToastGravity.BOTTOM,
                                //                                         timeInSecForIosWeb: 1,
                                //                                         textColor: Colors.white,
                                //                                         fontSize: 16.0);
                                //                                     Get.offAll(BottomNavScreen());
                                //                                   },
                                //                                   child: Icon(Icons.favorite_border,
                                //                                   )),
                                //                               Gap(5.h),
                                //                               Text(
                                //                                 LocaleKeys.UnFavorite.tr(),
                                //                                 style: TextStyle(
                                //                                   fontSize: 12.sp,
                                //                                   color: Styles.defualtColor2,
                                //                                   fontFamily: 'Tajawal2',
                                //                                 ),
                                //                               ),
                                //                             ],
                                //                           ),
                                //
                                //                           Column(
                                //                             children: [
                                //
                                //                               InkWell(
                                //                                   onTap: (){
                                //                                     Favorite();
                                //                                     Fluttertoast.showToast(
                                //                                         msg: LocaleKeys
                                //                                             .Added_To_Favorite_Successfully
                                //                                             .tr(),
                                //                                         toastLength: Toast.LENGTH_SHORT,
                                //                                         gravity: ToastGravity.BOTTOM,
                                //                                         timeInSecForIosWeb: 1,
                                //                                         textColor: Colors.white,
                                //                                         fontSize: 16.0);
                                //                                   },
                                //                                   child: Icon(Icons.favorite,
                                //                                   )),
                                //                               Gap(5.h),
                                //                               Text(
                                //                                 LocaleKeys.Favorite.tr(),
                                //                                 style: TextStyle(
                                //                                   fontSize: 12.sp,
                                //                                   color: Styles.defualtColor2,
                                //                                   fontFamily: 'Tajawal2',
                                //                                 ),
                                //                               ),
                                //                             ],
                                //                           ),
                                //
                                //                           InkWell(
                                //                             onTap: () {
                                //                               print(snapshot.data!.records![index].id);
                                //
                                //                               setState(() {
                                //                                 isTapped2 = !isTapped2;
                                //                               });
                                //                             },
                                //                             child: Column(
                                //                               children: [
                                //                                 Icon(
                                //                                   isTapped2
                                //                                       ? FluentSystemIcons
                                //                                       .ic_fluent_thumb_like_regular
                                //                                       : FluentSystemIcons
                                //                                       .ic_fluent_thumb_like_filled,
                                //                                 ),
                                //                                 Gap(5.h),
                                //                                 Text(
                                //                                   LocaleKeys.Effective.tr(),
                                //                                   style: TextStyle(
                                //                                     fontSize: 12.sp,
                                //                                     color: Styles.defualtColor2,
                                //                                     fontFamily: 'Tajawal2',
                                //                                   ),
                                //                                 ),
                                //                               ],
                                //                             ),
                                //                           ),
                                //
                                //                           InkWell(
                                //                             onTap: () {
                                //                               setState(() {
                                //                                 isTapped3 = !isTapped3;
                                //                               });
                                //                             },
                                //                             child: Column(
                                //                               children: [
                                //                                 Icon(
                                //                                   isTapped3
                                //                                       ? FluentSystemIcons
                                //                                       .ic_fluent_thumb_dislike_regular
                                //                                       : FluentSystemIcons
                                //                                       .ic_fluent_thumb_dislike_filled,
                                //                                 ),
                                //                                 Gap(5.h),
                                //                                 Text(
                                //                                   LocaleKeys.inactive.tr(),
                                //                                   style: TextStyle(
                                //                                     fontSize: 12.sp,
                                //                                     color: Styles.defualtColor2,
                                //                                     fontFamily: 'Tajawal2',
                                //                                   ),
                                //                                 ),
                                //                               ],
                                //                             ),
                                //                           ),
                                //                         ],
                                //                       )
                                //
                                //
                                //
                                //
                                //                     ],
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //             userData.read('lang')==true ?   Container(
                                //               color: Colors.white,
                                //               child: Row(
                                //
                                //                 children: [
                                //                   SizedBox(
                                //                     height: 30.h,
                                //                     width:15.h,
                                //                     child: DecoratedBox(
                                //                       decoration: BoxDecoration(
                                //                           color:  Color(0xffD9D9D9) ,
                                //                           borderRadius: BorderRadius.only(
                                //                             topLeft: Radius.circular(
                                //                               20.h,
                                //                             ),
                                //                             bottomLeft: Radius.circular(
                                //                               20.h,
                                //                             ),
                                //                           )),
                                //                     ),
                                //                   ),
                                //                   Expanded(
                                //                       child: Padding(
                                //                         padding: const EdgeInsets.all(12.0),
                                //                         child:
                                //                         LayoutBuilder(
                                //                           builder:
                                //                               (BuildContext context, BoxConstraints constraints) {
                                //                             return Flex(
                                //                                 direction: Axis.horizontal,
                                //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //                                 mainAxisSize: MainAxisSize.max,
                                //                                 children: List.generate(
                                //                                     (constraints.constrainWidth() / 15).floor(),
                                //                                         (index) => SizedBox(
                                //                                       width:5.h,
                                //                                       height:1.h,
                                //                                       child: DecoratedBox(
                                //                                         decoration: BoxDecoration(
                                //                                           color:
                                //                                           Colors.grey.shade300,
                                //                                         ),
                                //                                       ),
                                //                                     )));
                                //                           },
                                //                         ),
                                //                       )),
                                //                   SizedBox(
                                //                     height: 30.h,
                                //                     width:15.h,
                                //                     child: DecoratedBox(
                                //                       decoration: BoxDecoration(
                                //
                                //                           color: Color(0xffD9D9D9),
                                //                           borderRadius: BorderRadius.only(
                                //                             topRight: Radius.circular(
                                //                               20.h,
                                //                             ),
                                //                             bottomRight: Radius.circular(
                                //                               20.h,
                                //                             ),
                                //                           )),
                                //                     ),
                                //                   ),
                                //
                                //                 ],
                                //               ),
                                //             ):
                                //             Container(
                                //               color: Colors.white,
                                //               child: Row(
                                //
                                //                 children: [
                                //                   SizedBox(
                                //                     height: 30.h,
                                //                     width:15.h,
                                //                     child: DecoratedBox(
                                //                       decoration: BoxDecoration(
                                //
                                //                           color: Color(0xffD9D9D9),
                                //                           borderRadius: BorderRadius.only(
                                //                             topRight: Radius.circular(
                                //                               20.h,
                                //                             ),
                                //                             bottomRight: Radius.circular(
                                //                               20.h,
                                //                             ),
                                //                           )),
                                //                     ),
                                //                   ),
                                //                   Expanded(
                                //                       child: Padding(
                                //                         padding: const EdgeInsets.all(12.0),
                                //                         child:
                                //                         LayoutBuilder(
                                //                           builder:
                                //                               (BuildContext context, BoxConstraints constraints) {
                                //                             return Flex(
                                //                                 direction: Axis.horizontal,
                                //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //                                 mainAxisSize: MainAxisSize.max,
                                //                                 children: List.generate(
                                //                                     (constraints.constrainWidth() / 15).floor(),
                                //                                         (index) => SizedBox(
                                //                                       width:5.h,
                                //                                       height:1.h,
                                //                                       child: DecoratedBox(
                                //                                         decoration: BoxDecoration(
                                //                                           color:
                                //                                           Colors.grey.shade300,
                                //                                         ),
                                //                                       ),
                                //                                     )));
                                //                           },
                                //                         ),
                                //                       )),
                                //
                                //                   SizedBox(
                                //                     height: 30.h,
                                //                     width:15.h,
                                //                     child: DecoratedBox(
                                //                       decoration: BoxDecoration(
                                //                           color:  Color(0xffD9D9D9) ,
                                //                           borderRadius: BorderRadius.only(
                                //                             topLeft: Radius.circular(
                                //                               20.h,
                                //                             ),
                                //                             bottomLeft: Radius.circular(
                                //                               20.h,
                                //                             ),
                                //                           )),
                                //                     ),
                                //                   ),
                                //                 ],
                                //               ),
                                //             ),
                                //
                                //             Container(
                                //               height: 50.h,
                                //               width: double.infinity,
                                //               padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 10.h),
                                //               decoration: BoxDecoration(
                                //                   color: Colors.white,
                                //                   borderRadius: BorderRadius.only(
                                //                     bottomLeft: Radius.circular(
                                //                       20.h,
                                //                     ),
                                //                     bottomRight: Radius.circular(
                                //                       20.h,
                                //                     ),
                                //                   )
                                //               ),
                                //               child: Column(
                                //                 mainAxisAlignment: MainAxisAlignment.start,
                                //                 crossAxisAlignment: CrossAxisAlignment.start,
                                //                 children: [
                                //                   buildBottum(
                                //                     height: 30.h,
                                //                     decoration: BoxDecoration(
                                //                       color: Styles.defualtColor,
                                //                       borderRadius: BorderRadius.circular(25),
                                //                     ),
                                //                     width: double.infinity,
                                //                     text: Text(
                                //                       LocaleKeys.Copy.tr(),
                                //                       style: TextStyle(
                                //                           color: Colors.white,
                                //                           fontSize: 16.sp,
                                //                           fontWeight: FontWeight.w600),
                                //                       textAlign: TextAlign.center,
                                //                     ),
                                //                     onTap: () async {
                                //                       await Clipboard.setData(ClipboardData(text: '${snapshot.data!.records![index].stores!.storSaleCode}'));
                                //                       print('do');
                                //                       Fluttertoast.showToast(
                                //                           msg: LocaleKeys
                                //                               .Done
                                //                               .tr(),
                                //                           toastLength: Toast.LENGTH_SHORT,
                                //                           gravity: ToastGravity.BOTTOM,
                                //                           timeInSecForIosWeb: 1,
                                //                           textColor: Colors.white,
                                //                           fontSize: 16.0);
                                //                       // copied successfully
                                //                     },
                                //                   ),
                                //
                                //
                                //
                                //                 ],
                                //               ),
                                //             ),
                                //
                                //           ],
                                //         ),
                                //       ),
                                //     );
                                //   });
                                //    });
                              },
                              child: Column(
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
                                        // ClipPath(
                                        //   clipper: CouponClipper(
                                        //     // optional (defaults to TextDirection.ltr), works when
                                        //     // curveAxis set to Axis.vertical
                                        //     direction: Directionality.of(context),
                                        //   ),
                                        //   // width and height are important depending on the type
                                        //   // of the text direction
                                        //   child: Container(
                                        //     width: 100,
                                        //     height: 100,
                                        //     color: Colors.purple,
                                        //   ),
                                        // ),


                                        // Stack(
                                        //   alignment: Alignment.center,
                                        //   children: [
                                        //      Image(image: AssetImage('assets/1111.png') ,height: 75.h,),
                                        //   Row(
                                        //     mainAxisAlignment: MainAxisAlignment.start,
                                        //     children: [
                                        //
                                        //       Text('name'),
                                        //       Text('${e.storTitle}',
                                        //                style: TextStyle(
                                        //                   fontSize: 15.sp,
                                        //                   fontFamily: 'Tajawal2',
                                        //                  color: Styles.defualtColor2
                                        //                ),),
                                        //
                                        //
                                        //
                                        //     ],
                                        //   ),
                                        //
                                        // ],),
                                        // Positioned(
                                        //     right: -2.5.h,
                                        //
                                        //
                                        //     child: Image(image: AssetImage('assets/Path 4.png'),height: 75.h,)),

                                        // SvgPicture.asset('assets/Group 36785.svg',height: 75.h,width: 75.h,),
                                        CouponCard(
                                          height: 90.h,
                                          backgroundColor: Colors.transparent,
                                          clockwise: true,
                                          curvePosition: 110,
                                          curveRadius: 25,
                                          curveAxis: Axis.vertical,
                                          borderRadius: 10,
                                          firstChild: Container(
                                            alignment: Alignment.center,
                                            decoration:   BoxDecoration(
                                                color: Colors.white,

                                                image: DecorationImage(

                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        'http://saudi07-001-site2.itempurl.com/${snapshot.data!.newRecords![index].storImgUrl}'
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
                                                  '${snapshot.data!.newRecords![index].storTitle}',
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
                                                      '${LocaleKeys.Offer} :${snapshot.data!.newRecords![index].storOffer}',
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
                                  Gap(10.h)
                                ],
                              ),
                            ),
                          ),
                          Gap(15.h),


                        ],
                      ),
                  separatorBuilder: (BuildContext context, int index) {
                    return Gap(0.h);
                  },

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
        )




          ],
        ),
      ),
    );
  }
  Future<void> _launchUrl(String link ) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}
//     Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           InkWell(
//                                                             onTap: (){
//                                                               _launchUrl('${snapshot.data!.records![index].stores!.storLink}');
//
//                                                             },
//                                                             child: Column(
//                                                               children: [
//                                                                 Icon(Icons.link),
//                                                                 Gap(5.h),
//                                                                 Text(
//                                                                   LocaleKeys.Link.tr(),
//                                                                   style: TextStyle(
//                                                                     fontSize: 12.sp,
//                                                                     color: Styles.defualtColor2,
//                                                                     fontFamily: 'Tajawal2',
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//
//                                                           Column(
//                                                             children: [
//
//                                                               InkWell(
//                                                                   onTap: (){
//                                                                     DelelteFavorite();
//                                                                     Fluttertoast.showToast(
//                                                                         msg: LocaleKeys
//                                                                             .Deleted_From_Favorite_Successfully
//                                                                             .tr(),
//                                                                         toastLength: Toast.LENGTH_SHORT,
//                                                                         gravity: ToastGravity.BOTTOM,
//                                                                         timeInSecForIosWeb: 1,
//                                                                         textColor: Colors.white,
//                                                                         fontSize: 16.0);
//                                                                     Get.offAll(BottomNavScreen());
//                                                                   },
//                                                                   child: Icon(Icons.favorite_border,
//                                                                   )),
//                                                               Gap(5.h),
//                                                               Text(
//                                                                 LocaleKeys.UnFavorite.tr(),
//                                                                 style: TextStyle(
//                                                                   fontSize: 12.sp,
//                                                                   color: Styles.defualtColor2,
//                                                                   fontFamily: 'Tajawal2',
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//
//                                                           Column(
//                                                             children: [
//
//                                                               InkWell(
//                                                                   onTap: (){
//                                                                     Favorite();
//                                                                     Fluttertoast.showToast(
//                                                                         msg: LocaleKeys
//                                                                             .Added_To_Favorite_Successfully
//                                                                             .tr(),
//                                                                         toastLength: Toast.LENGTH_SHORT,
//                                                                         gravity: ToastGravity.BOTTOM,
//                                                                         timeInSecForIosWeb: 1,
//                                                                         textColor: Colors.white,
//                                                                         fontSize: 16.0);
//                                                                   },
//                                                                   child: Icon(Icons.favorite,
//                                                                   )),
//                                                               Gap(5.h),
//                                                               Text(
//                                                                 LocaleKeys.Favorite.tr(),
//                                                                 style: TextStyle(
//                                                                   fontSize: 12.sp,
//                                                                   color: Styles.defualtColor2,
//                                                                   fontFamily: 'Tajawal2',
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//
//                                                           InkWell(
//                                                             onTap: () {
//                                                               print(snapshot.data!.records![index].id);
//
//                                                               setState(() {
//                                                                 isTapped2 = !isTapped2;
//                                                               });
//                                                             },
//                                                             child: Column(
//                                                               children: [
//                                                                 Icon(
//                                                                   isTapped2
//                                                                       ? FluentSystemIcons
//                                                                       .ic_fluent_thumb_like_regular
//                                                                       : FluentSystemIcons
//                                                                       .ic_fluent_thumb_like_filled,
//                                                                 ),
//                                                                 Gap(5.h),
//                                                                 Text(
//                                                                   LocaleKeys.Effective.tr(),
//                                                                   style: TextStyle(
//                                                                     fontSize: 12.sp,
//                                                                     color: Styles.defualtColor2,
//                                                                     fontFamily: 'Tajawal2',
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//
//                                                           InkWell(
//                                                             onTap: () {
//                                                               setState(() {
//                                                                 isTapped3 = !isTapped3;
//                                                               });
//                                                             },
//                                                             child: Column(
//                                                               children: [
//                                                                 Icon(
//                                                                   isTapped3
//                                                                       ? FluentSystemIcons
//                                                                       .ic_fluent_thumb_dislike_regular
//                                                                       : FluentSystemIcons
//                                                                       .ic_fluent_thumb_dislike_filled,
//                                                                 ),
//                                                                 Gap(5.h),
//                                                                 Text(
//                                                                   LocaleKeys.inactive.tr(),
//                                                                   style: TextStyle(
//                                                                     fontSize: 12.sp,
//                                                                     color: Styles.defualtColor2,
//                                                                     fontFamily: 'Tajawal2',
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       )