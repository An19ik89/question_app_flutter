import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:question_app/api/client/api_client.dart';
import 'package:question_app/api/provider/question_provider.dart';
import 'package:question_app/api/repository/question_repository.dart';
import 'package:question_app/data/local/local_storage.dart';
import 'package:question_app/routes/app_pages/app_pages.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  Get.put<LocalStorage>(LocalStorage());
  await Get.putAsync<ApiClient>(() => ApiClient().init());
  await Get.putAsync<QuestionProvider>(() async => QuestionProvider());
  await Get.putAsync<QuestionRepository>(() async => QuestionRepository());

  runApp(
    GetMaterialApp(
      title: "Question App",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
