import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:question_app/data/local/local_storage.dart';
import 'package:question_app/routes/app_pages/app_pages.dart';

class HomeViewController extends GetxController{

  LocalStorage localStorage = LocalStorage();
  RxInt highestScoreInHome = 0.obs;

  @override
  void onInit() {
    highestScoreInHome.value = localStorage.getHighestScore() ?? 0;
    super.onInit();
  }

   @override
   void dispose() {
     super.dispose();
   }

  gotoQuestionPage(BuildContext context){
    Get.toNamed(Routes.QUESTIONVIEW);
  }
}