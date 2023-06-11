// import 'package:copons/screens/profile_screen.dart';
// import 'package:copons/screens/ticket_screen.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import '../components/app_style.dart';
// import 'center_screen.dart';
// import 'favorite_screen.dart';
// import 'home_screen.dart';
//
// class BottomNavScreen extends StatefulWidget {
//   const BottomNavScreen({Key? key}) : super(key: key);
//
//   @override
//   State<BottomNavScreen> createState() => _BottomNavScreenState();
// }
//
// class _BottomNavScreenState extends State<BottomNavScreen> {
//   var currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//
//       body:_wigetOptions[currentIndex] ,
//       bottomNavigationBar: Container(
//         //margin: EdgeInsets.all(20),
//         //padding:  EdgeInsets.only(left: 40.h,right: 40.h),
//         height: 50.h,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color:Styles.defualtColor2,
//
//           borderRadius: BorderRadius.only(topLeft: Radius.circular(28.r),topRight: Radius.circular(28.r) ),
//         ),
//         child: ListView.builder(
//           itemCount: 5,
//           itemExtent: 60.h,
//           scrollDirection: Axis.horizontal,
//
//           padding: EdgeInsets.symmetric(horizontal:  13.5.h),
//           itemBuilder: (context, index) => InkWell(
//             onTap: () {
//               setState(() {
//                 currentIndex = index;
//                 HapticFeedback.lightImpact();
//
//               });
//             },
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   width: 50.h,
//                   child: Center(
//                     child: AnimatedContainer(
//                       alignment: Alignment.center,
//                       duration: Duration(milliseconds: 900),
//                       curve: Curves.fastLinearToSlowEaseIn,
//                       height: index==currentIndex?32.h:0.h,
//                       //index == currentIndex ? screenWidth * .12 : 0,
//                       width:index==currentIndex?32.h:0.h,
//                       //index == currentIndex ? screenWidth * .2125 : 0,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//
//                         gradient: LinearGradient(
//                           begin: Alignment(.9.h, -.7.h),
//                           end: Alignment(0.8.h, 1.h),
//                           colors: [
//                             Color(0xffC3A358),
//                             Color(0xffE2CD6D),
//                             Color(0xffC39528),
//
//                             //C3A358
//                             //E2CD6D
//                             //C39528
//
//
//                           ],
//
//                         ),
//
//                         color: index == currentIndex
//                             ? Styles.defualtColor
//                             : Colors.transparent,
//                       ),
//                     ),
//                   ),
//                 ),
//                 index==currentIndex?
//                 SizedBox(
//
//
//                   child: Center(
//                     child: Icon(
//                       //fit: BoxFit.cover,
//                       listOfIcons[index],
//                       size: 24.sp,
//
//                     ),
//                   ),
//                 ):
//                 SizedBox(
//
//                   child: Center(
//                     child: Icon(
//                       //fit: BoxFit.cover,
//                       listOfIcons[index],
//                       color: Colors.white,
//                       size: 24.sp,
//
//                     ),
//                   ),
//                 )
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<IconData> listOfIcons = [
//
//     FluentSystemIcons.ic_fluent_home_filled,
//     FluentSystemIcons.ic_fluent_heart_filled,
//
//     FluentSystemIcons.ic_fluent_add_circle_filled,
//     FluentSystemIcons.ic_fluent_person_filled,
//     FluentSystemIcons.ic_fluent_ticket_filled,
//   ];
//   static final List<Widget> _wigetOptions=<Widget>[
//
//
//
//
//     HomeScreen(),
//     FavoriteScreen(),
//     CenterScreen(),
//     ProfileScreen(),
//     TicketScreen(),
//
//   ];
//
//
// }
//
// //FluentSystemIcons.ic_fluent_person_regular