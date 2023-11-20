import 'dart:convert';

QuestionResponseModel questionResponseModelFromJson(String str) =>
    QuestionResponseModel.fromJson(json.decode(str));

String questionResponseModelToJson(QuestionResponseModel data) =>
    json.encode(data.toJson());

class QuestionResponseModel {
  List<Question>? questions;

  QuestionResponseModel({
    this.questions,
  });

  QuestionResponseModel copyWith({
    List<Question>? questions,
  }) =>
      QuestionResponseModel(
        questions: questions ?? this.questions,
      );

  factory QuestionResponseModel.fromJson(Map<String, dynamic> json) =>
      QuestionResponseModel(
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
      };
}

class Question {
  String? question;
  //Answers? answers;
  List<MapEntry<String, dynamic>>? answerList;
  String? questionImageUrl;
  String? correctAnswer;
  int? score;
  String? correctAnswersWithValue;

  Question({
    this.question,
    //this.answers,
    this.answerList,
    this.questionImageUrl,
    this.correctAnswer,
    this.score,
    this.correctAnswersWithValue,
  });

  Question copyWith({
    String? question,
    //Answers? answers,
    List<MapEntry<String, dynamic>>? answerList,
    String? questionImageUrl,
    String? correctAnswer,
    int? score,
    String? correctAnswersWithValue,
  }) =>
      Question(
        question: question ?? this.question,
        //answers: answers ?? this.answers,
        answerList: (answerList ?? this.answerList),
        questionImageUrl: questionImageUrl ?? this.questionImageUrl,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        score: score ?? this.score,
        correctAnswersWithValue: correctAnswersWithValue ?? this.correctAnswersWithValue,
      );

  factory Question.fromJson(Map<String, dynamic> json) {
    final dynamic questionImageUrlChecking = json['questionImageUrl'];
    final String result = questionImageUrlChecking ?? '';
    final String? tempCorrectAnswer = json['correctAnswer'];
    List<MapEntry<String, dynamic>>? answerListT = json["answers"].entries.toList();
    String tempCorrectAnswerWithValue = '';
    for (var entry in answerListT!) {
      if (entry.key == tempCorrectAnswer) {
        tempCorrectAnswerWithValue = entry.value;
      }
    }
    return Question(
      question: json["question"],
      //answers: json["answers"] == null ? null : Answers.fromJson(json["answers"]),
      answerList: answerListT,
      questionImageUrl: result ?? "",
      correctAnswer: tempCorrectAnswer,
      score: json["score"],
      correctAnswersWithValue: tempCorrectAnswerWithValue
    );
  }

  Map<String, dynamic> toJson() => {
        "question": question,
        //"answerss": answers?.toJson(),
        "answers": answerList,
        "questionImageUrl": questionImageUrl,
        "correctAnswer": correctAnswer,
        "score": score,
        "correctAnswersWithValue": correctAnswersWithValue,
      };
  // @override
  // String toString() => 'questionImageUrl: $questionImageUrl, ';
}

