import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final box = GetStorage();

  String highestScore = 'highest_score';

  setHighestScore(int score) {
    box.write(highestScore, score);
  }

  int? getHighestScore() {
    return box.read(highestScore);
  }

}