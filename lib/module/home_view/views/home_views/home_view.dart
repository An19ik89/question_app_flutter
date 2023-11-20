import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:question_app/core/size_config.dart';
import 'package:question_app/core/strings.dart';
import 'package:question_app/module/home_view/controllers/home_controllers.dart';


class HomeView extends GetView<HomeViewController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewController>(
        builder: (homeViewController) => SafeArea(
              child: WillPopScope(
                onWillPop: () async {
                  return false;
                },
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
                        Text("${AppStrings.HOME_APPBAR_SUB_TITLE} : ${homeViewController.highestScoreInHome.value}"),
                        const Gap(10.0),
                        SizedBox(
                          width: getProportionateScreenWidth(context,200),
                          height: getProportionateScreenWidth(context,40),
                          child: ElevatedButton(
                              onPressed: () =>
                                  homeViewController.gotoQuestionPage(context),
                              child: const Text(AppStrings.HOME_BUTTON_TITLE)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
