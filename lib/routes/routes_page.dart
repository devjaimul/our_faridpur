
import 'package:get/get.dart';
import 'package:our_faridpur/routes/routes_name.dart';
import 'package:our_faridpur/views/home/home_screen.dart';
import 'package:our_faridpur/views/splash%20screen/splash_screen.dart';



class RoutePages {
  static List<GetPage<dynamic>>? routes = [

    GetPage(name: RouteNames.splashScreen, page: () =>const SplashScreen()),
    //GetPage(name: RouteNames.onboardingScreen, page: () =>const OnboardingScreen()),
  //   GetPage(name: RouteNames.signInScreen, page: () =>const SignInScreen()),
  //   GetPage(name: RouteNames.singUpScreen, page: () =>const SignUpScreen()),
  //   GetPage(name: RouteNames.informationOfClient, page: () =>const InformationOfClient()),
  //   GetPage(name: RouteNames.forgetPassScreen, page: () =>const ForgetPassScreen()),
  // //GetPage(name: RouteNames.otpVerificationScreen, page: () =>const OtpVerificationScreen()),
  //  // GetPage(name: RouteNames.resetPassScreen, page: () =>const ResetPassScreen()),
  //   GetPage(name: RouteNames.navBar, page: () =>const CustomNavbar()),
  //   GetPage(name: RouteNames.workOutScreen, page: () =>const WorkoutScreen()),
     GetPage(name: RouteNames.homeScreen, page: () => HomeScreen()),

  ];
}