import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:question_app/core/strings.dart';
import 'package:question_app/module/home_view/controllers/home_controllers.dart';


class QuestionView extends GetView<HomeViewController> {
  const QuestionView({super.key});

  @override
  Widget build(BuildContext context)
  {

    return GetBuilder<HomeViewController>(
        builder: (questionController) => SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.grey.shade700,
                    centerTitle: false,
                    title: Text("${AppStrings.CURRENT_SCORE_TITLE} : ${questionController.individualScore.value}",style: const TextStyle(fontSize: 16),),
                    actions: [
                      Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${questionController.totalQuestionInPerPageForAppbar.value.toString()} Of ${questionController.totalQuestion.toString()}",style: const TextStyle(fontSize: 15),),
                      ))
                    ],
                  ),
                  body: PageView.builder(

                      itemCount: (questionController.rxQuestionList.length / 2).ceil(),
                      controller: questionController.pageController,
                      onPageChanged: (ind){
                        questionController.currentPage.value = ind;
                        questionController.updateAppBar();
                      },
                      physics: const NeverScrollableScrollPhysics(),

                      itemBuilder: (context, pageIndex) {


                        int start = pageIndex * 2;
                        int end = (pageIndex + 1) * 2;


                        questionController.rxQuestionListPaginated.value = questionController.rxQuestionList.sublist(start, end > questionController.rxQuestionList.length ? questionController.rxQuestionList.length : end);

                        questionController.answeredQuestionListPaginated.value = questionController.answeredQuestionList.sublist(start, end > questionController.answeredQuestionList.length ? questionController.answeredQuestionList.length : end);

                        questionController.coloredQuestionListPaginated.value = questionController.coloredQuestionList.sublist(start, end > questionController.coloredQuestionList.length ? questionController.coloredQuestionList.length : end);

                        questionController.pressedQuestionListPaginated.value = questionController.pressedQuestionList.sublist(start, end > questionController.pressedQuestionList.length ? questionController.pressedQuestionList.length : end);

                        return ConstrainedBox(
                          constraints: const BoxConstraints(
                              minWidth: 0.0,
                              maxWidth: double.infinity,
                              minHeight: 0.0,
                              maxHeight: double.infinity),
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 350,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      elevation: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                                  CrossAxisAlignment.start,
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
                                                        width: 100,
                                                        height: 100,
                                                        child:
                                                            CachedNetworkImage(
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      progress) =>
                                                                  Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              value: progress
                                                                  .progress,
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                            Icons.error,
                                                            size: 20.0,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          fadeInCurve:
                                                              Curves.bounceOut,
                                                          fadeInDuration:
                                                              const Duration(
                                                                  seconds: 3),
                                                          imageUrl: questionController
                                                              .rxQuestionListPaginated[
                                                                  index]
                                                              .questionImageUrl!
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : const SizedBox.shrink(),
                                                const Gap(10),
                                                Flexible(
                                                  flex: 2,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(questionController
                                                          .rxQuestionListPaginated[index]
                                                          .question!
                                                          .toString()),
                                                      const Gap(10.0),
                                                      Text(
                                                        "Score : ${questionController.rxQuestionListPaginated[index].score!.toString()}",
                                                        textAlign:
                                                            TextAlign.start,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            const Gap(10),
                                            const Text(
                                              "Answer [Please select any of this]",
                                              textAlign: TextAlign.center,
                                            ),
                                            const Gap(10),
                                            Expanded(
                                              child: ListView.builder(
                                                  itemCount: questionController
                                                      .rxQuestionListPaginated[index]
                                                      .answerList!
                                                      .length,
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, insideIndex) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: InkWell(
                                                        onTap: () => questionController
                                                                        .pressedQuestionListPaginated[
                                                                    index] ==
                                                                false
                                                            ? questionController.pressMultipleOption(
                                                                index,
                                                                insideIndex,
                                                                questionController
                                                                    .rxQuestionListPaginated[
                                                                        index]
                                                                    .answerList![
                                                                        insideIndex]
                                                                    .value)
                                                            : null,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color: questionController
                                                                              .coloredQuestionListPaginated[
                                                                          index]
                                                                      [
                                                                      insideIndex])),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
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
                              itemCount:
                                  questionController.rxQuestionListPaginated.length),
                        );
                      })),
            ));
  }
}
