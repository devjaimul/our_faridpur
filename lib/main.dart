import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:our_faridpur/controller/controller_bindings.dart';
import 'package:our_faridpur/themes/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'routes/routes_name.dart';
import 'routes/routes_page.dart';
import 'views/home/upload_data.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await uploadCategoriesData();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          theme: lightTheme(context),
          debugShowCheckedModeBanner: false,
          getPages: RoutePages.routes,
          initialRoute: RouteNames.homeScreen,
          initialBinding: ControllerBindings(),
        );
      },
    );
  }
}
