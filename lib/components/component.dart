import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

Widget buildBottum({
  required double height,
  required double width,
  required Text text,
  required Function() onTap,
  EdgeInsetsGeometry? margin,
  required BoxDecoration? decoration,
}) =>
    Container(
      height: height,
      margin: margin,
      width: width,
      decoration: decoration,
      child: InkWell(
        child: Center(
          child: text,
        ),
        onTap: onTap,
      ),
    );
Widget BuildQuestionScreen({
  required String text1,
  required String text2,
}) => Column(
        children: [
          Row(
            children: [

              Container(

                width: 210,
                padding: EdgeInsets.symmetric(horizontal: 30.h,vertical: 5.h),
                decoration: BoxDecoration(
                  color:Color(0xffB5924F),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(23),
                      topLeft: Radius.circular(23),
                      bottomRight: Radius.circular(23)),
                ),
                child: Center(
                  child: Text(
                    text1,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
          Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(

                width: 220,
                padding: EdgeInsets.symmetric(horizontal: 30.h,vertical: 5.h),
                decoration: BoxDecoration(
                  color: Color(0xffe7bf74),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(23),
                      topLeft: Radius.circular(23),
                      bottomLeft: Radius.circular(23)),
                ),
                child: Center(
                  child: Text(
                    text2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      );
