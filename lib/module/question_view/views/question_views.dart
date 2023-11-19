import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:question_app/core/strings.dart';
import 'package:question_app/module/question_view/controllers/question_controllers.dart';



class QuestionView extends GetView<QuestionViewController> {
  const QuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionViewController>(
        builder: (galleryController) => SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.grey.shade700,
              title: const Text(AppStrings.HOME_APPBAR_TITLE),
              centerTitle: true,
            ),
            body: const Stack(
              alignment: Alignment.bottomLeft,
              children: [
              ],
            ),
          ),
        ));
  }
}