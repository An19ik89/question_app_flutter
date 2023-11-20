import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:question_app/core/strings.dart';
import 'package:question_app/module/home_view/controllers/home_controllers.dart';
import 'package:question_app/routes/app_pages/app_pages.dart';



class HomeView extends GetView<HomeViewController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewController>(
        builder: (galleryController) => SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.grey.shade700,
              title: const Text(AppStrings.HOME_APPBAR_TITLE),
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("${AppStrings.HOME_APPBAR_SUB_TITLE} : 0"),
                  const Gap(10.0),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                        onPressed:  ()=> galleryController.gotoQuestionPage(),
                        child: const Text(AppStrings.HOME_BUTTON_TITLE)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
