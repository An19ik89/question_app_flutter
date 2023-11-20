import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:developer';

import 'package:question_app/api/repository/question_repository.dart';
import 'package:question_app/data/model/question_response_model.dart';
import 'package:question_app/routes/app_pages/app_pages.dart';

class HomeViewController extends GetxController with GetSingleTickerProviderStateMixin{

  final QuestionRepository questionRepository = Get.find();

  late RxList<Question> rxQuestionList;
  late RxList<RxList<bool>> answeredQuestionList;
  late RxList<RxList<Color>> coloredQuestionList;
  late RxList<bool> pressedQuestionList;


  late RxList<Question> rxQuestionListPaginated;
  late RxList<RxList<bool>> answeredQuestionListPaginated;
  late RxList<RxList<Color>> coloredQuestionListPaginated;
  late RxList<bool> pressedQuestionListPaginated;


  PageController pageController = PageController(initialPage: 0);
  RxInt currentPage = 0.obs;
  int totalPages = 1;

  RxInt individualScore = 0.obs;
  RxInt totalQuestion = 0.obs;
  RxInt totalQuestionInPerPageForAppbar = 2.obs;


  @override
  void onInit() {

    pageController = PageController(initialPage: 0);
    individualScore = 0.obs;
    totalQuestion = 0.obs;

    rxQuestionList = <Question>[].obs;
    answeredQuestionList = <RxList<bool>>[].obs;
    coloredQuestionList = <RxList<Color>>[].obs;
    pressedQuestionList = <bool>[].obs;

    rxQuestionListPaginated = <Question>[].obs;
    answeredQuestionListPaginated = <RxList<bool>>[].obs;
    coloredQuestionListPaginated = <RxList<Color>>[].obs;
    pressedQuestionListPaginated = <bool>[].obs;

    getAllQuestionList();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose(); // Dispose the controller when it's no longer needed
    super.onClose();
  }

  updateAppBar(){
    totalQuestionInPerPageForAppbar.value += 2;
    update();
  }

  getAllQuestionList() async {
    rxQuestionList.value = await questionRepository.getAllQuestionListRepository();
    totalQuestion.value = rxQuestionList.length;

    for(int i = 0; i< rxQuestionList.length; i++){
      List<dynamic> values = rxQuestionList[i].answerList!.map((entry) => entry.value).toList();
      values.shuffle();
      for (int j = 0; j < rxQuestionList[i].answerList!.length; j++) {
        rxQuestionList[i].answerList![j] = MapEntry(rxQuestionList[i].answerList![j].key, values[j]);
      }
    }

    pressedQuestionList = RxList.generate(rxQuestionList.length, (index) => false);
    answeredQuestionList.value = List.generate(rxQuestionList.length, (index) => RxList<bool>.of(List.filled(rxQuestionList[index].answerList!.length, false))).obs;
    coloredQuestionList.value = List.generate(rxQuestionList.length, (index) => RxList<Color>.of(List.filled(rxQuestionList[index].answerList!.length, Colors.black45))).obs;
    totalPages = (rxQuestionList.length /2).ceil();
    update();
  }
  gotoQuestionPage(){
    Get.toNamed(Routes.QUESTIONVIEW);
    //autoPageSwiping();
  }


  autoPageSwiping() async{
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (currentPage < totalPages - 1) {
        currentPage++;
      }
      // else {
      //   Get.toNamed(Routes.HOME);
      // }
      //print("curr : $currentPage");
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  pressMultipleOption(int mainIndex,int subIndex,String answer){
    if(pressedQuestionListPaginated[mainIndex] == false){
      pressedQuestionListPaginated[mainIndex] = true;
      if(rxQuestionListPaginated[mainIndex].correctAnswersWithValue == answer){
        answeredQuestionListPaginated[mainIndex][subIndex]= true;
        coloredQuestionListPaginated[mainIndex][subIndex]= Colors.green;
        individualScore.value += rxQuestionListPaginated[mainIndex].score!;
      }
      else{
        answeredQuestionListPaginated[mainIndex][subIndex]= false;
        coloredQuestionListPaginated[mainIndex][subIndex]= Colors.red;
        for(int i=0;i<rxQuestionListPaginated[mainIndex].answerList!.length;i++){
         if(rxQuestionListPaginated[mainIndex].correctAnswersWithValue == rxQuestionListPaginated[mainIndex].answerList?[i].value){
           coloredQuestionListPaginated[mainIndex][i] = Colors.green;
         }
        }
      }
      update();
    }
  }

}