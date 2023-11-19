import 'package:get/get.dart';
import 'package:question_app/module/question_view/controllers/question_controllers.dart';

class QuestionViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionViewController>(
          () => QuestionViewController(),
    );
  }
}