import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:question_app/core/size_config.dart';
import 'package:question_app/core/strings.dart';
import 'package:question_app/module/question_view/controllers/question_controllers.dart';

class QuestionView extends GetView<QuestionViewController> {
  const QuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionViewController>(
        builder: (questionController) => SafeArea(
              child: WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      backgroundColor: Colors.grey.shade700,
                      centerTitle: false,
                      automaticallyImplyLeading: false,
                      title: Text(
                        "${AppStrings.CURRENT_SCORE_TITLE} : ${questionController.individualScore.value}",
                        style: const TextStyle(fontSize: 16),
                      ),

                      actions: [
                        Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0,right: 8.0),
                                child: Text(
                                  "${questionController.totalQuestionInPerPageForAppbar.value.toString()} Of ${questionController.totalQuestion.toString()}",
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                            Container(
                              height: 2,
                              width: getProportionateScreenWidth(context, 120),
                              margin: const EdgeInsets.all(10.0),
                              child: LinearProgressIndicator(
                                value: questionController.progressValue.value,
                                minHeight: getProportionateScreenHeight(context, 5.0),
                                backgroundColor: Colors.grey,
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            )
                          ],
                        )


                      ],
                    ),
                    body: Obx(() => questionController.loader.value
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  AppStrings.LOADING,
                                  style: TextStyle(color: Colors.black),
                                ),
                                const Gap(10),
                                Center(
                                  child: SizedBox(
                                    width: getProportionateScreenWidth(context, 20),
                                    height: getProportionateScreenHeight(context, 20),
                                    child: const CircularProgressIndicator(),
                                  ),
                                )
                              ],
                            ),
                          )
                        : PageView.builder(
                            itemCount:
                                (questionController.rxQuestionList.length / 2)
                                    .ceil(),
                            controller: questionController.pageController,
                            onPageChanged: (ind) {
                              questionController.currentPage.value = ind;
                              questionController.updateAppBar();
                            },
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, pageIndex) {
                              questionController.start.value = pageIndex *
                                  2; // if 0 start = 0 if 1 start = 2

                              questionController.end.value =
                                  (pageIndex + 1) * 2; //if 0 end 2 if 1 end = 4

                              questionController.rxQuestionListPaginated.value =
                                  questionController.rxQuestionList.sublist(
                                      questionController.start.value,
                                      questionController.end.value >
                                              questionController
                                                  .rxQuestionList.length
                                          ? questionController
                                              .rxQuestionList.length
                                          : questionController.end.value);

                              questionController
                                      .answeredQuestionListPaginated.value =
                                  questionController.answeredQuestionList
                                      .sublist(
                                          questionController.start.value,
                                          questionController.end.value >
                                                  questionController
                                                      .answeredQuestionList
                                                      .length
                                              ? questionController
                                                  .answeredQuestionList.length
                                              : questionController.end.value);

                              questionController
                                      .coloredQuestionListPaginated.value =
                                  questionController.coloredQuestionList
                                      .sublist(
                                          questionController.start.value,
                                          questionController
                                                      .end.value >
                                                  questionController
                                                      .coloredQuestionList
                                                      .length
                                              ? questionController
                                                  .coloredQuestionList.length
                                              : questionController.end.value);

                              questionController
                                      .pressedQuestionListPaginated.value =
                                  questionController.pressedQuestionList
                                      .sublist(
                                          questionController.start.value,
                                          questionController
                                                      .end.value >
                                                  questionController
                                                      .pressedQuestionList
                                                      .length
                                              ? questionController
                                                  .pressedQuestionList.length
                                              : questionController.end.value);

                              return ConstrainedBox(
                                constraints: const BoxConstraints(
                                    minWidth: 0.0,
                                    maxWidth: double.infinity,
                                    minHeight: 0.0,
                                    maxHeight: double.infinity),
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height: getProportionateScreenHeight(context, 350),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            elevation: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      questionController
                                                                  .rxQuestionListPaginated[
                                                                      index]
                                                                  .questionImageUrl!
                                                                  .toString()
                                                                  .isNotEmpty ||
                                                              questionController
                                                                      .rxQuestionListPaginated[
                                                                          index]
                                                                      .questionImageUrl !=
                                                                  null
                                                          ? SizedBox(
                                                              width: getProportionateScreenWidth(context, 100),
                                                              height: getProportionateScreenHeight(context, 100),
                                                              child:
                                                                  CachedNetworkImage(
                                                                progressIndicatorBuilder:
                                                                    (context,
                                                                            url,
                                                                            progress) =>
                                                                        Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    value: progress
                                                                        .progress,
                                                                  ),
                                                                ),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(
                                                                  Icons.error,
                                                                  size: 20.0,
                                                                  color: Colors
                                                                      .redAccent,
                                                                ),
                                                                fadeInCurve: Curves
                                                                    .bounceOut,
                                                                fadeInDuration:
                                                                    const Duration(
                                                                        seconds:
                                                                            3),
                                                                imageUrl: questionController
                                                                    .rxQuestionListPaginated[
                                                                        index]
                                                                    .questionImageUrl!
                                                                    .toString(),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                      const Gap(10),
                                                      Flexible(
                                                        flex: 2,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(questionController
                                                                .rxQuestionListPaginated[
                                                                    index]
                                                                .question!
                                                                .toString()),
                                                            const Gap(10.0),
                                                            Text(
                                                              "${AppStrings.SCORE_TITLE} : ${questionController.rxQuestionListPaginated[index].score!.toString()}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const Gap(10),
                                                  const Text(
                                                    AppStrings.ANSWER_TITLE,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const Gap(10),
                                                  Expanded(
                                                    child: ListView.builder(
                                                        itemCount:
                                                            questionController
                                                                .rxQuestionListPaginated[
                                                                    index]
                                                                .answerList!
                                                                .length,
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemBuilder: (context,
                                                            insideIndex) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                pressMultipleOption(
                                                                    questionController,
                                                                    index,
                                                                    insideIndex,
                                                                    questionController
                                                                        .rxQuestionListPaginated[
                                                                            index]
                                                                        .question
                                                                        .toString(),
                                                                    questionController
                                                                        .rxQuestionListPaginated[
                                                                            index]
                                                                        .answerList![
                                                                            insideIndex]
                                                                        .value,
                                                                    questionController
                                                                        .start
                                                                        .value,
                                                                    questionController
                                                                        .end
                                                                        .value);
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        width: getProportionateScreenWidth(context, 2.0),
                                                                        color: questionController.coloredQuestionListPaginated[index]
                                                                            [
                                                                            insideIndex])),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                      "${questionController.rxQuestionListPaginated[index].answerList![insideIndex].key} : ${questionController.rxQuestionListPaginated[index].answerList![insideIndex].value}"),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.zero,
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                          color: Colors.black,
                                        ),
                                    itemCount: questionController
                                        .rxQuestionListPaginated.length),
                              );
                            }))),
              ),
            ));
  }

  pressMultipleOption(QuestionViewController controller, int mainIndex,
      int subIndex, String question, String answer, int start, int end) {
    for (int i = start; i < end; i++) {
      if (controller.rxQuestionList[i].question == question &&
          controller.pressedQuestionList[i] == false) {
        controller.pressedQuestionList[i] = true;
        controller.pressMultipleOption(mainIndex, subIndex, question, answer);
      }
    }
  }
}
