import 'package:get/get.dart';
import 'package:question_app/api/provider/question_provider.dart';


class QuestionRepository extends GetxService {
  final QuestionProvider _profileProvider = Get.find();

  Future getAllQuestionListRepository(){
    return _profileProvider.getAllQuestionListProvider();
  }

}