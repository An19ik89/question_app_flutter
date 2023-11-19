import 'package:get/get.dart';
import 'package:question_app/module/home_view/bindings/home_bindings.dart';
import 'package:question_app/module/home_view/views/home_views/home_view.dart';
import 'package:question_app/module/question_view/bindings/question_bindings.dart';
import 'package:question_app/module/question_view/views/question_views.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeViewBinding(),
    ),
    GetPage(
      name: _Paths.QUESTIONVIEW,
      page: () => const QuestionView(),
      binding: QuestionViewBinding(),
    ),
  ];
}