import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:question_app/api/repository/question_repository.dart';
import 'package:question_app/data/local/local_storage.dart';
import 'package:question_app/data/model/question_response_model.dart';
import 'package:question_app/module/home_view/controllers/home_controllers.dart';


class QuestionViewController extends GetxController with GetSingleTickerProviderStateMixin{

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
  Timer? _timer;

  RxInt start = 0.obs;
  RxInt end = 0.obs;

  RxBool loader = false.obs;

  LocalStorage localStorage = LocalStorage();
  int highestScore = 0;

  RxDouble progressValue = 0.0.obs;

  @override
  void onInit() {
    initializeData();
    super.onInit();
  }

  initializeData()
  {
    pageController = PageController(initialPage: 0);
    individualScore = 0.obs;
    totalQuestion = 0.obs;
    start = 0.obs;
    end = 0.obs;
    loader = false.obs;

    rxQuestionList = <Question>[].obs;
    answeredQuestionList = <RxList<bool>>[].obs;
    coloredQuestionList = <RxList<Color>>[].obs;
    pressedQuestionList = <bool>[].obs;

    rxQuestionListPaginated = <Question>[].obs;
    answeredQuestionListPaginated = <RxList<bool>>[].obs;
    coloredQuestionListPaginated = <RxList<Color>>[].obs;
    pressedQuestionListPaginated = <bool>[].obs;

    highestScore = localStorage.getHighestScore() ?? 0;
    getAllQuestionList();
  }

  @override
  void dispose() {
    pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  updateAppBar(){
    totalQuestionInPerPageForAppbar.value += 2;
    update();
  }

  getAllQuestionList() async {
    loader(true);
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
    loader(false);
    update();
    autoPageSwiping();
  }



  autoPageSwiping() async
  {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      progressValue.value = timer.tick / 3;
      if (currentPage < totalPages - 1) {
        currentPage++;
        pageController.animateToPage(
          currentPage.value,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      else{
        _timer?.cancel();
        Get.find<HomeViewController>().highestScoreInHome.value = highestScore;
        Get.find<HomeViewController>().update();
        Get.back();
      }
    });
  }


  pressMultipleOption(int mainIndex,int subIndex,String question,String answer)
  {
      if(rxQuestionListPaginated[mainIndex].correctAnswersWithValue == answer){
        answeredQuestionListPaginated[mainIndex][subIndex]= true;
        coloredQuestionListPaginated[mainIndex][subIndex]= Colors.green;
        individualScore.value += rxQuestionListPaginated[mainIndex].score!;
        if(individualScore.value > highestScore){
          highestScore = individualScore.value;
          localStorage.setHighestScore(highestScore);
        }
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