import 'dart:convert';

import 'package:copons/components/app_style.dart';
import 'package:copons/screens/pressed_screen.dart';
import 'package:copons/screens/search.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/component.dart';
import '../models/categoryID.dart';
import '../models/category_model.dart';
import '../models/getAllCategory_model.dart';
import '../models/slider_model.dart';
import '../models/special_store.dart';
import '../translations/locale_keys.g.dart';
import 'bottom_nav.dart';
import 'noon_ticket.dart';

class PressedScreen extends StatefulWidget {
  String CatName;
  String img;
  PressedScreen({Key? key,required this.CatName,required this.img}) : super(key: key);

  @override
  State<PressedScreen> createState() => _PressedScreenState();
}

class _PressedScreenState extends State<PressedScreen> {

  Set<String> savedWords = Set<String>();
  bool isTapped2 = true;
  bool isTapped3 = true;
  static const likedKey = 'LikeKey';
  late bool liked = false;
  late bool isTapped = false;
  late PersistentBottomSheetController _controller; // <------ Instance variable
  final _scaffoldKey = GlobalKey<ScaffoldState>();   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _restorePressed();
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
  void _restorePressed() async {
    var prefs = await SharedPreferences.getInstance();
    var liked = prefs.getBool(likedKey);
    setState(() => this.liked = liked!);
  }

  void _pressed() async {

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
        "countryName":'${userData.read('countryFavId')}',
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


  Future<speacialStore> getData() async {
    final response = await http.get(
        Uri.parse('http://saudi07-001-site2.itempurl.com/api/GetSpecial'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode==200) {

      print(response.body);
      return speacialStore.fromJson(jsonDecode(response.body));
    } else {

      throw Exception('Failed to load album');
    }
  }
  Future<List<CategoryModel>> fetchCategory() async {
    final response = await http.get(Uri.parse(
        'http://saudi07-001-site2.itempurl.com/api/GetAllCategories'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      List jsonData = (data['records']);

      return jsonData
          .map((categoryData) => CategoryModel.fromJson(categoryData))
          .toList();
    } else {
      throw Exception('Failed to load clinics');
    }
  }
  void getDataId({required dynamic id}) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://saudi07-001-site2.itempurl.com/api/Get_Store_byId/${id}'),
          body: jsonEncode({

            "id": id}));
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
  Future<CategoryIdModel?> catid( ) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://saudi07-001-site2.itempurl.com/api/GetByCatgId/${userData.read('id')}'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({

            "count_id":  userData.read('country'),
            "userId":'${userData.read('token')}'


          }));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var log = json.decode(response.body);
        print('dataId==${data}');
      } else {
        print("Faild");
      }
      return CategoryIdModel.fromJson(data);
    } catch (e) {
      print(e.toString());
    }
  }
  int counter = 0;
  int counter1 = 0;
  bool catall=true;
  int? id;
  final userData = GetStorage();
  Future<CategoryIdallModel?> catallid( ) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://saudi07-001-site2.itempurl.com/api/GetAllStores/${ userData.read('country')}'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "SearchValue":'',
            "userId":userData.read('token'),

          }));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var log = json.decode(response.body);
        print('dataId==${data}');
      } else {
        print("Faild");
      }
      return CategoryIdallModel.fromJson(data);
    } catch (e) {
      print(e.toString());
    }
  }
  Future<CategoryIdallModel?> catAllid( ) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('http://saudi07-001-site2.itempurl.com/api/GetAllStores/${ userData.read('country')}'));
      request.body = json.encode({
        "SearchValue": " ",
        "userId": userData.read('token'),
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('await response.stream.bytesToString()');
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());
    }
  }
  Future<SliderModel> getData2() async {
    final response = await http.get(Uri.parse(
        'http://saudi07-001-site2.itempurl.com/api/GetAllSlider'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(response.body.length);
      return SliderModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
  List<SvgPicture>iconImage2=[
    SvgPicture.asset('assets/Mask Group 27.svg'),
    SvgPicture.asset('assets/Mask Group 27.svg'),




  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar:   AppBar(
          backgroundColor: Styles.defualtColor2,
          automaticallyImplyLeading: false,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.r),bottomRight:Radius.circular(25.r) )
          ),
          // leading: Builder(
          //   builder: (context)=>Padding(
          //     padding: EdgeInsets.only(right: 10.h,top: 20.h,bottom: 20.h,left: 10.h ),
          //     child: ElevatedButton(
          //
          //       onPressed: () {
          //         Scaffold.of(context).openDrawer();
          //
          //       },
          //       child: Icon(FluentSystemIcons.ic_fluent_text_bullet_list_regular,color: Styles.defualtColor3,size: 20.sp,),
          //       style: ElevatedButton.styleFrom(
          //
          //         fixedSize: Size(35.h, 35.h),
          //         //maximumSize:Size(5.h, 30.h) ,
          //         minimumSize: Size(35.h, 35.h),
          //         padding: EdgeInsets.all(3.h),
          //
          //         backgroundColor:Styles.defualtColor4,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.r),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
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
        // drawer: Drawer(
        //   backgroundColor: Styles.defualtColor2,
        //
        //    width: 250.h,
        //    child: ListView(
        //      children: [
        //        InkWell(
        //          onTap: (){
        //            Get.back();
        //          },
        //          child: Padding(
        //            padding:  EdgeInsets.only( left:20.h,top: 15.h ,right: 20.h),
        //            child: Row(
        //              mainAxisAlignment: MainAxisAlignment.end,
        //              children: [
        //                CircleAvatar(
        //                  radius: 15.r,
        //                  backgroundColor: Styles.defualtColor4,
        //                  child: Image(
        //                    height: 12.h,
        //                    width: 12.h,
        //
        //                    image: AssetImage('assets/wrong-14.png',)
        //
        //                        ,color: Styles.defualtColor3,
        //
        //
        //                  )
        //                ),
        //              ],
        //            ),
        //          ),
        //        ),
        //        InkWell(
        //          onTap: (){
        //            Get.to(BottomNavScreen());
        //          },
        //          child: Padding(
        //            padding:   EdgeInsets.symmetric(horizontal:20.h,vertical: 20.h),
        //            child: Column(
        //              mainAxisAlignment: MainAxisAlignment.center,
        //              children: [
        //                Text(LocaleKeys.All.tr(),style: TextStyle(
        //                  fontFamily: 'Tajawal2',
        //                  fontSize: 15.h,
        //                  color: Styles.defualtColor,
        //
        //                ),),
        //                FutureBuilder<List<CategoryModel?>>(
        //                  future: fetchCategory(),
        //                  builder: (context, snapshot) {
        //                    if (snapshot.hasData) {
        //                      List<CategoryModel?>? item = snapshot.data;
        //
        //                      return SizedBox(
        //                        width: 200.h,
        //                        height: 500.h,
        //                        child: ListView.separated(
        //
        //                          itemBuilder: (context, index) =>  InkWell(
        //                            onTap: (){
        //                              Get.back();
        //
        //                              setState(() {
        //                                id = item[index]?.id;
        //                                userData.write('id', id);
        //                                // catall=false;
        //                                catid(
        //                                    countId:
        //                                    '${userData.read('country')}',
        //                                    id: userData.read('id'));
        //
        //                                print(item[index]?.id);
        //                                print('item[index]?.id');
        //                                print(userData.read('country'),);
        //
        //                              });
        //
        //                            },
        //                            child: Column(
        //                              children: [
        //                                Divider(
        //                                  height: 25.h,
        //                                  color: Styles.defualtColor3,
        //                                  thickness: .3,
        //                                ),
        //                                Padding(
        //                                  padding:   EdgeInsets.only(right: 20.h),
        //                                  child: Row(
        //                                    children: [
        //                                      Image(image: NetworkImage(
        //                                          'http://eibtek2-001-site5.atempurl.com${item[index]!.catedIconUrl}'
        //                                      ),height: 10.h,),
        //                                      Gap(20.h),
        //                                      Text(
        //                                        '${item[index]!.categName}',
        //                                        style: TextStyle(
        //                                          color: Colors.white,
        //                                          fontFamily: 'Tajawal7',
        //                                          fontSize: 11.sp,
        //                                        ),
        //                                      ),
        //                                    ],
        //                                  ),
        //                                ),
        //
        //                              ],
        //                            ),
        //                          ),
        //                          itemCount: item!.length,
        //                          separatorBuilder:
        //                              (BuildContext context, int index) {
        //                            return Gap(0.h);
        //                          },
        //                        ),
        //                      );
        //                    } else {
        //                      return Center(
        //                        child: CircularProgressIndicator(
        //                          valueColor: AlwaysStoppedAnimation<Color>(
        //                              Styles.defualtColor),
        //                        ),
        //                      );
        //                    }
        //                  },
        //                ),
        //
        //
        //
        //              ],
        //            ),
        //          ),
        //        )
        //
        //      ],
        //    ),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              Gap(15.h),

              FutureBuilder(
                future: getData2(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return CarouselSlider(
                        options: CarouselOptions(
                          height: 110.h,

                          autoPlay: false,
                          viewportFraction: .8.h,
                          onPageChanged: (index, reason) {
                            setState(() {
                              counter1=index;

                            });
                          },
                          enlargeCenterPage: true,

                          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                          pauseAutoPlayOnTouch: true,
                          //enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 900),
                          //  viewportFraction: .8,
                        ),
                        items:snapshot.data!.records!.map((e) =>   Stack(
                          fit : StackFit.values.last,
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(


                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(15.h),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      'http://saudi07-001-site2.itempurl.com${e.sliderImgUrl}',
                                    ),
                                  )
                              ),



                              height: 120.h,
                              width:  300.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                for(int i=0;i<snapshot.data!.records!.length;i++)
                                  Container(
                                    height: 6.h,
                                    width: 6.h,
                                    margin: EdgeInsets.symmetric(horizontal: 3.h,vertical: 10.h),
                                    decoration: BoxDecoration(
                                      color: counter1==i?Color(0xff858583):  Color(0xff014678),
                                      shape: BoxShape.circle,

                                    ),
                                  ),
                              ],
                            ),


                          ],
                        )).toList()

                    );
                  }else {
                    return Center(
                      child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(Styles.defualtColor),),
                    );
                  }
                },
              ),


                  Gap(15.h),
                  Container(
                    height: 450.h,
                    width: double.infinity,
                    color: Color(0xffF7F7F7),
                    child: SingleChildScrollView(
                      child: Column(

                        children: [
                          Row(

                            children: [
                              Stack(


                                children: [
                                  InkWell(
                                    onTap: () {

                                    },
                                    child:  Padding(
                                      padding:   EdgeInsets.symmetric(horizontal: 35.h,vertical: 15.h),
                                      child: Container(
                                        height: 25.h,
                                       padding: EdgeInsets.symmetric(horizontal: 10.h,),
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
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image(image: NetworkImage(
                                                widget.img,
                                            ),height: 12.h,),
                                            Gap(5.h),


                                            Text(
                                           widget.CatName,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Tajawal7',
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: -6.h,
                                      left: 13.h,


                                      child
                                          : IconButton( color: Color(0xff67564d), onPressed: () {Get.back();  }, icon: Icon(Icons.cancel),)),

                                ],

                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                          ),
                          FutureBuilder (
                            future: catid(),


                            builder: (context, snapshot){


                              if (snapshot.hasData) {
                                return Column(
                                  children: snapshot.data!.records!.map((e) =>   Column(

                                    children: [

                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                                        child: InkWell(
                                          onTap: () {
                                            userData.write('storeId', e.id);


                                            Get.to(NoonTicketScreen(
                                              fav:  FavoriteButton(
                                                iconColor: Styles.defualtColor,
                                                iconSize: 30.sp,
                                                isFavorite: e.isFaviourite ,
                                                valueChanged: (val) {
                                                  e.isFaviourite==false?
                                                  Favorite():DelelteFavorite();
                                                  val== e.isFaviourite;
                                                },
                                              ),
                                              storeCountry: '${e.countries!.contName}',
                                              img:    CircleAvatar(
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

                                              }, storePhone: '${e.storPhoneNumber}', storeCode: '${e.storSaleCode}',
                                            ));

                                            print(e.id);



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
                          // FutureBuilder(
                          //   future: categoryId(),
                          //
                          //     builder: (context,snapshot){
                          //     if(snapshot.hasData){
                          //       return Text('fff${snapshot.data['records'][0]['stor_Title']}');
                          //     }
                          //     else{
                          //       return CircularProgressIndicator();
                          //     }
                          //
                          //     })
                        ],
                      ),
                    ),
                  )
                ],
              ),

          ),
    );
    // FutureBuilder(
    //                         future: catid(
    //                           countId:'${ userData.read('country')}',
    //                           id: userData.read('id'),
    //                         ),
    //                         builder: (context, snapshot) {
    //                           if (snapshot.hasData) {
    //                             return StatefulBuilder(builder: (BuildContext context, StateSetter setState){return Padding(
    //                               padding: EdgeInsets.symmetric(horizontal: 20.h),
    //                               child: SizedBox(
    //                                 height: 400.h,
    //                                 child: ListView.separated(
    //                                   itemBuilder: (context, index) => InkWell(
    //                                     onTap: () {
    //                                       // showDialog(
    //                                       //   context: context,
    //                                       //   builder:(context)=>
    //                                       //       Dialog(
    //                                       //         shape: RoundedRectangleBorder(
    //                                       //             borderRadius: BorderRadius.circular(30)),
    //                                       //
    //                                       //         child: Container(
    //                                       //           height: 210,
    //                                       //           width: 250,
    //                                       //
    //                                       //           child: Column(
    //                                       //             mainAxisAlignment: MainAxisAlignment.center,
    //                                       //             children: [
    //                                       //               Text('قم بإضافة رأيك',style: TextStyle(
    //                                       //                 fontWeight: FontWeight.w500,
    //                                       //                 fontSize: 17.sp,
    //                                       //               ),),
    //                                       //               Text('يرجي تقييم الخدمة وإضافة رأيك في العملية  ',style: TextStyle(
    //                                       //                 fontWeight: FontWeight.w500,
    //                                       //                 color: Styles.defualtColor2,
    //                                       //                 fontSize: 14.sp,
    //                                       //               ),),
    //                                       //               Gap(10.h),
    //                                       //               RatingBar.builder(
    //                                       //                 initialRating: rating,
    //                                       //                 minRating: 1,
    //                                       //                 itemSize: 30,
    //                                       //                 itemPadding: EdgeInsets.symmetric(horizontal: 2),
    //                                       //                 itemBuilder: (context,_)=>Icon(
    //                                       //                   Icons.star,
    //                                       //                   color: Colors.yellow.shade300,
    //                                       //                   size: 18.sp,
    //                                       //                 ),
    //                                       //                 updateOnDrag: true,
    //                                       //                 onRatingUpdate: (rating)=>setState(() {
    //                                       //                   this.rating=rating;
    //                                       //                 }),
    //                                       //               ),
    //                                       //               Gap(20.h),
    //                                       //               InkWell(
    //                                       //                 onTap: (){
    //                                       //                   Get.back();
    //                                       //                 },
    //                                       //                 child: Container(
    //                                       //                   height: 40.h,
    //                                       //                   width: 100.h,
    //                                       //                   decoration: BoxDecoration(
    //                                       //                     borderRadius: BorderRadius.circular(5.h),
    //                                       //                     color: Styles.defualtColor,
    //                                       //                   ),
    //                                       //                 child: Icon(Icons.send,color: Colors.white,),
    //                                       //                 ),
    //                                       //               )
    //                                       //
    //                                       //             ],
    //                                       //           ),
    //                                       //         ),
    //                                       //
    //                                       //       ),
    //                                       //
    //                                       // );
    //                                       getDataId(
    //                                           id: snapshot
    //                                               .data!.records![index].id);
    //                                       Get.to(OfferScreen(
    //                                         title: snapshot
    //                                             .data!.records![index].storTitle!,
    //                                         storeAddress: '${snapshot.data!.records![index].storAddress}',
    //                                         storedetails:
    //                                         '${snapshot.data!.records![index].storDeteils}',
    //                                         storeimg: 'http://eibtekone-001-site18.atempurl.com/Uploads/Stores/${snapshot.data!.records![index].storImgUrl}',
    //                                         storeLink: '${snapshot.data!.records![index].storLink}',
    //                                         storephone: '${snapshot.data!.records![index].storPhoneNumber}',
    //                                         storevip: snapshot.data!.records![index].acceptLocoCard!,
    //                                         stor_SaleCode: '${snapshot.data!.records![index].storSaleCode}',
    //                                         slider:  CarouselSlider(
    //                                             options: CarouselOptions(
    //                                               height: 160.h,
    //
    //                                               autoPlay: false,
    //                                               viewportFraction: .7.h,
    //                                               onPageChanged: (index, reason) {
    //                                                 setState(() {
    //                                                   counter1=index;
    //                                                   print('counter1  ${counter1}');
    //                                                 });
    //                                               },
    //                                               enlargeCenterPage: false,
    //
    //                                               autoPlayCurve: Curves.fastLinearToSlowEaseIn,
    //                                               pauseAutoPlayOnTouch: true,
    //                                               //enableInfiniteScroll: true,
    //                                               autoPlayAnimationDuration: Duration(milliseconds: 900),
    //                                               //  viewportFraction: .8,
    //                                             ),
    //                                             items:  snapshot.data!.records![index].storeSlider!.map((e) => Column(
    //                                               children: [
    //                                                 Container(
    //
    //                                                   decoration: BoxDecoration(
    //                                                     color: Colors.white,
    //                                                     borderRadius: BorderRadius.circular(30.h),
    //                                                     image: DecorationImage(
    //                                                       fit: BoxFit.cover,
    //                                                       image:  NetworkImage(
    //                                                         'http://eibtekone-001-site18.atempurl.com/Uploads/Stores/${e.imageUrl}',
    //                                                       ),
    //                                                     ),
    //                                                   ),
    //                                                   margin: EdgeInsets.symmetric(horizontal: 10.h),
    //                                                   height: 130.h,
    //                                                   width:  250.h,
    //                                                 ),
    //                                                 // Row(
    //                                                 //   mainAxisAlignment: MainAxisAlignment.center,
    //                                                 //   children: [
    //                                                 //     for(int i=0;i < snapshot.data!.records![index].storeSlider!.length;i++)
    //                                                 //
    //                                                 //       Container(
    //                                                 //         height: 6.h,
    //                                                 //         width: 6.h,
    //                                                 //         margin: EdgeInsets.symmetric(horizontal: 3.h,vertical: 10.h),
    //                                                 //         decoration: BoxDecoration(
    //                                                 //           color: counter1==i? Styles.defualtColor:Styles.defaultColor7,
    //                                                 //           shape: BoxShape.circle,
    //                                                 //
    //                                                 //         ),
    //                                                 //       ),
    //                                                 //   ],
    //                                                 // ),
    //
    //
    //                                               ],
    //                                             )).toList()
    //
    //                                         ),
    //                                       ));
    //                                     },
    //                                     child: Container(
    //                                       height:75.h,
    //                                       width: double.infinity,
    //                                       decoration: BoxDecoration(
    //                                         boxShadow: [
    //                                           BoxShadow(
    //                                             color: Colors.grey.shade200,
    //                                             spreadRadius: 1,
    //                                             blurRadius: 3,
    //                                             offset: Offset(0, 3), // changes position of shadow
    //                                           ),
    //                                         ],
    //                                         color: Styles.defaultColor5,
    //                                         borderRadius: BorderRadius.circular(10.r),
    //                                       ),
    //                                       child: Row(
    //                                         children: [
    //                                           Container(
    //                                             height:75.h,
    //                                             width: 80.h,
    //                                             decoration: BoxDecoration(
    //                                                 borderRadius: BorderRadius.only(topRight: Radius.circular(10.r),bottomRight: Radius.circular(10.r)),
    //
    //                                                 image: DecorationImage(
    //                                                   fit: BoxFit.cover,
    //
    //                                                   image: NetworkImage(
    //                                                     'http://eibtekone-001-site18.atempurl.com/Uploads/Stores/${snapshot.data!.records[index].storImgUrl}',
    //                                                   ),
    //                                                 )
    //                                             ),
    //                                           ),
    //
    //                                          Container(
    //                                            height: 75.h,
    //                                            width: 200.h,
    //                                            padding: EdgeInsets.symmetric(horizontal: 10.h,vertical: 10.h),
    //                                            decoration: BoxDecoration(
    //                                              color: Styles.defaultColor5,
    //                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),bottomLeft: Radius.circular(10.r)),
    //                                            ),
    //                                            child:  Column(
    //                                              mainAxisAlignment:
    //                                              MainAxisAlignment.center,
    //                                              crossAxisAlignment:
    //                                              CrossAxisAlignment.start,
    //                                              children: [
    //                                                Row(
    //                                                  children: [
    //                                                    Text(
    //                                                      '${snapshot.data!.records[index].storTitle}',
    //                                                      style: TextStyle(
    //                                                          color: Colors.black,
    //                                                          fontSize: 14.sp),
    //                                                    ),
    //
    //                                                    // Text(
    //                                                    //   'vvv',
    //                                                    //   style: TextStyle(
    //                                                    //       color: Colors.grey.shade400,
    //                                                    //       fontSize: 10.sp),
    //                                                    // ),
    //                                                    // Gap(5.h),
    //                                                    // RatingBar.builder(
    //                                                    //   initialRating: rating,
    //                                                    //   minRating: 1,
    //                                                    //   itemSize: 11,
    //                                                    //   itemPadding:
    //                                                    //   EdgeInsets.symmetric(horizontal: 1),
    //                                                    //   itemBuilder: (context, _) => Icon(
    //                                                    //     Icons.star,
    //                                                    //     color: Colors.yellow.shade300,
    //                                                    //     size: 15.sp,
    //                                                    //   ),
    //                                                    //   updateOnDrag: true,
    //                                                    //   onRatingUpdate: (rating)  {},
    //                                                    // ),
    //                                                  ],
    //                                                ),
    //                                                Gap(3.h),
    //                                                Row(
    //                                                  children: [
    //                                                    Text(
    //                                                      LocaleKeys.Store_link.tr(),
    //                                                      style: TextStyle(
    //                                                        fontSize: 10.sp,
    //                                                        color:
    //                                                        Colors.grey.shade400,
    //                                                      ),
    //                                                    ),
    //                                                    Gap(5.h),
    //                                                    Icon(
    //                                                      Icons
    //                                                          .arrow_forward_ios_outlined,
    //                                                      size: 10.sp,
    //                                                      color: Colors.grey.shade400,
    //                                                    ),
    //                                                    Gap(5.h),
    //                                                    InkWell(
    //                                                      onTap: () {
    //                                                        _launchUrl(
    //                                                            '${snapshot.data!.records![index].storLink}');
    //                                                      },
    //                                                      child: Text(
    //                                                        '${snapshot.data!.records![index].storLink}',
    //                                                        style: TextStyle(
    //                                                          fontSize: 10.sp,
    //                                                          color: Colors
    //                                                              .grey.shade400,
    //                                                        ),
    //                                                      ),
    //                                                    ),
    //                                                  ],
    //                                                ),
    //                                                Gap(3.h),
    //                                                Flexible(
    //                                                  child: SizedBox(
    //                                                    width: 180.h,
    //                                                    child: Text(
    //
    //                                                      '${snapshot.data!.records![index].storDeteils}',
    //                                                      style: TextStyle(
    //
    //                                                        fontSize: 8.sp,
    //                                                        color: Colors.grey.shade600,
    //                                                      ),
    //                                                      maxLines: 1,
    //                                                    ),
    //                                                  ),
    //                                                ),
    //                                              ],
    //                                            ),
    //                                          )
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   separatorBuilder: (context, index) =>
    //                                       Gap(5.h),
    //                                   itemCount: snapshot.data!.records!.length,
    //                                 ),
    //                               ),
    //                             );});
    //                           } else {
    //                             return Center(
    //                               child: Text(
    //                                 'choose Category Above',
    //                                 style: TextStyle(
    //                                     color: Styles.defualtColor,
    //                                     fontSize: 15.sp),
    //                               ),
    //                             );
    //                           }
    //                         },
    //                       )
  }

  Future<void> _launchUrl(String link) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}

// Container(
//                                           height: 30.h,
//                                           width: 85.h,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(20.r),
//                                             gradient: LinearGradient(
//                                               // begin: Alignment.topRight,
//                                               // end: Alignment.bottomRight ,
//
//                                               colors: [
//                                                 Colors.grey.shade300,
//                                                 Colors.grey.shade400,
//                                               ],
//                                             ),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               'الأسر المنتجة',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 12.sp,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
