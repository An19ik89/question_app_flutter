import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:question_app/api/client/api_client.dart';
import 'package:question_app/core/api_endpoints.dart';
import 'package:question_app/data/model/question_response_model.dart';

class QuestionProvider extends GetxService {

  final ApiClient _apiClient = Get.find();

  List<QuestionResponseModel> photoListForStoringFromHive = <QuestionResponseModel>[];


  Future getAllQuestionListProvider () async
  {
    try {
      DIO.Response response = await _apiClient.request(Api.GET_ALL_QUESTION_LIST_URL, Method.GET);
      if(response.statusCode == 200)
      {
        List<QuestionResponseModel> questionList = <QuestionResponseModel>[];
        QuestionResponseModel questionResponseModel = QuestionResponseModel.fromJson(response.data);
        questionList.add(questionResponseModel);
        return questionList;
      }
      else{
        Get.snackbar(response.statusCode.toString(), response.statusMessage.toString(),snackPosition: SnackPosition.BOTTOM);
      }
    } catch (SocketException) {
      debugPrint(SocketException.toString());
    }
  }


}