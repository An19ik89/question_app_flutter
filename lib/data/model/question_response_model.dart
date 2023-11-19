import 'dart:convert';

QuestionResponseModel questionResponseModelFromJson(String str) => QuestionResponseModel.fromJson(json.decode(str));

String questionResponseModelToJson(QuestionResponseModel data) => json.encode(data.toJson());

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

  factory QuestionResponseModel.fromJson(Map<String, dynamic> json) => QuestionResponseModel(
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

class Question {
  String? question;
  Answers? answers;
  String? questionImageUrl;
  String? correctAnswer;
  int? score;

  Question({
    this.question,
    this.answers,
    this.questionImageUrl,
    this.correctAnswer,
    this.score,
  });

  Question copyWith({
    String? question,
    Answers? answers,
    String? questionImageUrl,
    String? correctAnswer,
    int? score,
  }) =>
      Question(
        question: question ?? this.question,
        answers: answers ?? this.answers,
        questionImageUrl: questionImageUrl ?? this.questionImageUrl,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        score: score ?? this.score,
      );

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    question: json["question"],
    answers: json["answers"] == null ? null : Answers.fromJson(json["answers"]),
    questionImageUrl: json["questionImageUrl"],
    correctAnswer: json["correctAnswer"],
    score: json["score"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answers": answers?.toJson(),
    "questionImageUrl": questionImageUrl,
    "correctAnswer": correctAnswer,
    "score": score,
  };
}

class Answers {
  String? a;
  String? b;
  String? c;
  String? d;

  Answers({
    this.a,
    this.b,
    this.c,
    this.d,
  });

  Answers copyWith({
    String? a,
    String? b,
    String? c,
    String? d,
  }) =>
      Answers(
        a: a ?? this.a,
        b: b ?? this.b,
        c: c ?? this.c,
        d: d ?? this.d,
      );

  factory Answers.fromJson(Map<String, dynamic> json) => Answers(
    a: json["A"],
    b: json["B"],
    c: json["C"],
    d: json["D"],
  );

  Map<String, dynamic> toJson() => {
    "A": a,
    "B": b,
    "C": c,
    "D": d,
  };
}
