import 'package:copons/screens/bottom_nav.dart';
import 'package:copons/screens/country_screen.dart';
import 'package:copons/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;

import 'components/ratingController.dart';
import 'screens/login_screen.dart';

void main() async{
  final controller = Get.put(RatingController());
  await controller.initSp();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness:  Brightness.dark,
  ));
  await  GetStorage.init();
  runApp(EasyLocalization(
      child:    MyApp(),
      supportedLocales: [
        Locale('ar'),
        Locale('en'),
      ],
      assetLoader: CodegenLoader(),
      saveLocale: true,
      path: "assets/translations"));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => Directionality(
        textDirection: ui.TextDirection.rtl,
        child: GetMaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Code Cloud',
          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            appBarTheme:   AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness:  Brightness.light,
                statusBarBrightness:  Brightness.light,
              ),
            ),

          ),
          home: child,
        ),
      ),
      child: const MapScreen(),
    );
  }
}


