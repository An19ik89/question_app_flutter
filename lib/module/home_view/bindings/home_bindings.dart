import 'package:get/get.dart';
import 'package:question_app/module/home_view/controllers/home_controllers.dart';

class HomeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewController>(
          () => HomeViewController(),
    );
  }
}