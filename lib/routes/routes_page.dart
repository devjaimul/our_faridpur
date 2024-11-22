
import 'package:get/get.dart';
import 'package:our_faridpur/routes/routes_name.dart';
import 'package:our_faridpur/views/bottom%20navigationBar/custom_navbar.dart';
import 'package:our_faridpur/views/home/home_screen.dart';
import 'package:our_faridpur/views/splash%20screen/splash_screen.dart';



class RoutePages {
  static List<GetPage<dynamic>>? routes = [

    GetPage(name: RouteNames.splashScreen, page: () =>const SplashScreen()),

  GetPage(name: RouteNames.customNavBar, page: () =>const CustomNavbar()),
     GetPage(name: RouteNames.homeScreen, page: () => const HomeScreen()),

  ];
}