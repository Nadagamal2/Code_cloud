 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'package:gap/gap.dart';
 import 'package:easy_localization/easy_localization.dart';
 import 'package:get/get_core/src/get_main.dart';
 import 'package:get/get_navigation/get_navigation.dart';
import '../components/app_style.dart';
import '../components/component.dart';
import '../models/question_model.dart';
import '../translations/locale_keys.g.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen ({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  Future<QuestionModel> getData() async {
    final response = await http.get(
        Uri.parse('http://saudi07-001-site2.itempurl.com/api/GetAll_Questions'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode==200) {

      print(response.body);
      return QuestionModel.fromJson(jsonDecode(response.body));
    } else {

      throw Exception('Failed to load album');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.h,
        elevation: 0,
        backgroundColor: Styles.defualtColor,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 30,
            )),
        centerTitle: true,
        title: Text(
          LocaleKeys.Common_questions.tr(),
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

           

            // Padding(
            //   padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 8.h),
            //   child: Column(
            //
            //     children: [
            //
            //
            //
            //
            //
            //       Container(
            //           height: 50.h,
            //           width: double.infinity,
            //
            //           decoration: BoxDecoration(
            //             color: Styles.defualtColor3,
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey.shade400,
            //                 spreadRadius: 1,
            //                 blurRadius: 3,
            //                 offset: Offset(0, 1), // changes position of shadow
            //               ),
            //             ],
            //             borderRadius: BorderRadius.circular(15.r),
            //
            //           ),
            //           child:  Padding(
            //             padding:    EdgeInsets.symmetric(horizontal:20.h,vertical: 15.h),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //
            //               children: [
            //               Text('كيف اقدر اغير نفاصيل كودي ؟',
            //               style: TextStyle(
            //                 fontSize: 12.sp,
            //                 fontFamily: 'Tajawal2',
            //
            //               ),
            //
            //
            //                ),
            //                 Icon(Icons.keyboard_arrow_down_rounded,color: Styles.defualtColor,)
            //
            //               ],
            //             ),
            //           )
            //       ),
            //
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 8.h),
            //   child: Column(
            //
            //     children: [
            //
            //
            //
            //
            //
            //       Container(
            //           height: 50.h,
            //           width: double.infinity,
            //
            //           decoration: BoxDecoration(
            //             color: Styles.defualtColor3,
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey.shade400,
            //                 spreadRadius: 1,
            //                 blurRadius: 3,
            //                 offset: Offset(0, 1), // changes position of shadow
            //               ),
            //             ],
            //             borderRadius: BorderRadius.circular(15.r),
            //
            //           ),
            //           child:  Padding(
            //             padding:    EdgeInsets.symmetric(horizontal:20.h,vertical: 15.h),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //
            //               children: [
            //               Text('كيف اعرف اذا الكود فعال او لا ؟',
            //               style: TextStyle(
            //                 fontSize: 12.sp,
            //                 fontFamily: 'Tajawal2',
            //
            //               ),
            //
            //
            //                ),
            //                 Icon(Icons.keyboard_arrow_down_rounded,color: Styles.defualtColor,)
            //
            //               ],
            //             ),
            //           )
            //       ),
            //
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 8.h),
            //   child: Column(
            //
            //     children: [
            //
            //
            //
            //
            //
            //       Container(
            //           height: 50.h,
            //           width: double.infinity,
            //
            //           decoration: BoxDecoration(
            //             color: Styles.defualtColor3,
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey.shade400,
            //                 spreadRadius: 1,
            //                 blurRadius: 3,
            //                 offset: Offset(0, 1), // changes position of shadow
            //               ),
            //             ],
            //             borderRadius: BorderRadius.circular(15.r),
            //
            //           ),
            //           child:  Padding(
            //             padding:    EdgeInsets.symmetric(horizontal:20.h,vertical: 15.h),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //
            //               children: [
            //               Text('كيف اقدراضيف كود خصم ؟',
            //               style: TextStyle(
            //                 fontSize: 12.sp,
            //                 fontFamily: 'Tajawal2',
            //
            //               ),
            //
            //
            //                ),
            //                 Icon(Icons.keyboard_arrow_down_rounded,color: Styles.defualtColor,)
            //
            //               ],
            //             ),
            //           )
            //       ),
            //
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding:   EdgeInsets.symmetric(horizontal: 20.h,vertical: 8.h),
            //   child: Column(
            //
            //     children: [
            //
            //
            //
            //
            //
            //       Container(
            //           height: 50.h,
            //           width: double.infinity,
            //
            //           decoration: BoxDecoration(
            //             color: Styles.defualtColor3,
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey.shade400,
            //                 spreadRadius: 1,
            //                 blurRadius: 3,
            //                 offset: Offset(0, 1), // changes position of shadow
            //               ),
            //             ],
            //             borderRadius: BorderRadius.circular(15.r),
            //
            //           ),
            //           child:  Padding(
            //             padding:    EdgeInsets.symmetric(horizontal:20.h,vertical: 15.h),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //
            //               children: [
            //               Text('متي ينزل كود كتجري ؟',
            //               style: TextStyle(
            //                 fontSize: 12.sp,
            //                 fontFamily: 'Tajawal2',
            //
            //               ),
            //
            //
            //                ),
            //                 Icon(Icons.keyboard_arrow_down_rounded,color: Styles.defualtColor,)
            //
            //               ],
            //             ),
            //           )
            //       ),
            //
            //     ],
            //   ),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [



                Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: FutureBuilder(
                    future: getData(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return SizedBox(
                          height: 500.h,
                          child: ListView.separated(
                            itemBuilder: (context,index)=> Column(
                              children: [
                                BuildQuestionScreen(text1:   '${snapshot.data!.records![index].question}', text2:  '${snapshot.data!.records![index].answer}',),







                              ],
                            ),
                            separatorBuilder: (context,index)=>Gap(5.h),
                            itemCount: snapshot.data!.records!.length,
                          ),
                        );
                      }else {
                        return Center(
                          child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(Styles.defualtColor),),
                        );
                      }
                    },

                  ),
                )
              ],),

          ],
        ),
      ),
    );
  }
}
