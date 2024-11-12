
import 'package:get/get.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => SignUpController());
    // Get.lazyPut(() => OtpController());
    // Get.lazyPut(() => WorkOutPlanController(), fenix: true); // Ensure the controller stays in memory if needed
  }
}
