  import 'package:copons/screens/profile_screen.dart';
import 'package:copons/screens/ticket_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
  import 'package:easy_localization/easy_localization.dart';
  import 'package:get/get_core/src/get_main.dart';
  import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
 import '../components/app_style.dart';
import '../translations/locale_keys.g.dart';
import 'center_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
 class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final userData =GetStorage();
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar:  appBar[currentIndex],
      // drawer: Drawer(
      //   backgroundColor: Styles.defualtColor2,
      //
      //   width: 250.h,
      //   child: ListView(
      //     children: [
      //       InkWell(
      //         onTap: (){
      //           Get.back();
      //         },
      //         child: Padding(
      //           padding:  EdgeInsets.only( left:20.h,top: 15.h ,right: 20.h),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               CircleAvatar(
      //                   radius: 15.r,
      //                   backgroundColor: Styles.defualtColor4,
      //                   child: Image(
      //                     height: 12.h,
      //                     width: 12.h,
      //
      //                     image: AssetImage('assets/wrong-14.png',)
      //
      //                     ,color: Styles.defualtColor3,
      //
      //
      //                   )
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding:   EdgeInsets.symmetric(horizontal:20.h,vertical: 20.h),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text( "All".tr(),style: TextStyle(
      //               fontFamily: 'Tajawal2',
      //               fontSize: 15.h,
      //               color: Styles.defualtColor,
      //
      //             ),),
      //             Divider(
      //               height: 25.h,
      //               color: Styles.defualtColor3,
      //               thickness: .3,
      //             ),
      //             Padding(
      //               padding:   EdgeInsets.only(right: 20.h),
      //               child: Row(
      //                 children: [
      //                   Image(image: AssetImage('assets/11.png'),
      //                     height: 20.h,
      //                     width: 20.h,
      //                   ),
      //                   Gap(20.h),
      //                   Text('ملابس',
      //                     style: TextStyle(
      //                       color: Styles.defualtColor3,
      //                       fontSize: 12.5.sp,
      //                       fontFamily: 'Tajawal2',
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //             Divider(
      //               height: 25.h,
      //               color: Styles.defualtColor3,
      //               thickness: .3,
      //             ),
      //             Padding(
      //               padding:   EdgeInsets.only(right: 20.h),
      //               child: Row(
      //                 children: [
      //                   Image(image: AssetImage('assets/22.png'),
      //                     height: 25.h,
      //                     width: 25.h,
      //                   ),
      //                   Gap(20.h),
      //                   Text('أحذية',
      //                     style: TextStyle(
      //                       color: Styles.defualtColor3,
      //                       fontSize: 12.5.sp,
      //                       fontFamily: 'Tajawal2',
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //             Divider(
      //               height: 25.h,
      //               color: Styles.defualtColor3,
      //               thickness: .3,
      //             ),
      //             Padding(
      //               padding:   EdgeInsets.only(right: 20.h),
      //               child: Row(
      //                 children: [
      //                   Image(image: AssetImage('assets/33.png'),
      //                     height: 20.h,
      //                     width: 20.h,
      //                   ),
      //                   Gap(20.h),
      //                   Text('عطور',
      //                     style: TextStyle(
      //                       color: Styles.defualtColor3,
      //                       fontSize: 12.5.sp,
      //                       fontFamily: 'Tajawal2',
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //             Divider(
      //               height: 25.h,
      //               color: Styles.defualtColor3,
      //               thickness: .3,
      //             ),
      //             Padding(
      //               padding:   EdgeInsets.only(right: 20.h),
      //               child: Row(
      //                 children: [
      //                   Image(image: AssetImage('assets/11.png'),
      //                     height: 20.h,
      //                     width: 20.h,
      //                   ),
      //                   Gap(20.h),
      //                   Text('ملابس',
      //                     style: TextStyle(
      //                       color: Styles.defualtColor3,
      //                       fontSize: 12.5.sp,
      //                       fontFamily: 'Tajawal2',
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //             Divider(
      //               height: 25.h,
      //               color: Styles.defualtColor3,
      //               thickness: .3,
      //             ),
      //             Padding(
      //               padding:   EdgeInsets.only(right: 20.h),
      //               child: Row(
      //                 children: [
      //                   Image(image: AssetImage('assets/11.png'),
      //                     height: 20.h,
      //                     width: 20.h,
      //                   ),
      //                   Gap(20.h),
      //                   Text('ملابس',
      //                     style: TextStyle(
      //                       color: Styles.defualtColor3,
      //                       fontSize: 12.5.sp,
      //                       fontFamily: 'Tajawal2',
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //             Divider(
      //               height: 25.h,
      //               color: Styles.defualtColor3,
      //               thickness: .3,
      //             ),
      //             Padding(
      //               padding:   EdgeInsets.only(right: 20.h),
      //               child: Row(
      //                 children: [
      //                   Image(image: AssetImage('assets/11.png'),
      //                     height: 20.h,
      //                     width: 20.h,
      //                   ),
      //                   Gap(20.h),
      //                   Text('ملابس',
      //                     style: TextStyle(
      //                       color: Styles.defualtColor3,
      //                       fontSize: 12.5.sp,
      //                       fontFamily: 'Tajawal2',
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //             Divider(
      //               height: 25.h,
      //               color: Styles.defualtColor3,
      //               thickness: .3,
      //             ),
      //
      //           ],
      //         ),
      //       )
      //
      //     ],
      //   ),
      // ),
      body:_wigetOptions[currentIndex] ,
      bottomNavigationBar: Container(
        //margin: EdgeInsets.all(20),
        padding:  EdgeInsets.only( right: 15.h,left: 12.h),
        alignment: Alignment.center,
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color:Styles.defualtColor2,

          borderRadius: BorderRadius.only(topLeft: Radius.circular(28.r),topRight: Radius.circular(28.r) ),
        ),
        child: ListView.builder(
          itemCount: 5,
          itemExtent: 60.h,
          scrollDirection: Axis.horizontal,



          padding: EdgeInsets.only(left:  0.h),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();

              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
               alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  alignment: Alignment.center,



                   duration: Duration(milliseconds: 900),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: index==currentIndex?32.h:0.h,
                  //index == currentIndex ? screenWidth * .12 : 0,
                  width:index==currentIndex?32.h:0.h,
                  //index == currentIndex ? screenWidth * .2125 : 0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    gradient: LinearGradient(
                      begin: Alignment(.9.h, -.7.h),
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

                    color: index == currentIndex
                        ? Styles.defualtColor
                        : Colors.transparent,
                   ),
                ),
                index==currentIndex?
                SizedBox(


                  child: Center(
                    child: Icon(
                      //fit: BoxFit.cover,
                        listOfIcons[index],
                      size: 24.sp,

                    ),
                  ),
                ):
                SizedBox(

                  child: Center(
                    child: Icon(
                      //fit: BoxFit.cover,
                      listOfIcons[index],
                      color: Colors.white,
                      size: 24.sp,

                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [

    FluentSystemIcons.ic_fluent_home_filled,
    FluentSystemIcons.ic_fluent_heart_filled,

    FluentSystemIcons.ic_fluent_add_circle_filled,
    FluentSystemIcons.ic_fluent_person_filled,
    FluentSystemIcons.ic_fluent_ticket_filled,
  ];
  static final List<Widget> _wigetOptions=<Widget>[




    HomeScreen(),
    FavoriteScreen(),
  CenterScreen(),
    ProfileScreen(),
    TicketScreen(),

  ];
  static final List<PreferredSizeWidget> appBar=<PreferredSizeWidget>[











  ];


}

//FluentSystemIcons.ic_fluent_person_regular