# task1_for_pyshop

Задание 1. Разработать функцию определения счета в игре 
Задача 
В примере кода ниже генерируется список фиксаций состояния счета игры в течение матча.
Разработайте функцию getScore(gameStamps, offset), которая вернет счет на момент offset в списке gameStamps.
Нужно суметь понять суть написанного кода, заметить нюансы, разработать функцию вписывающуюся стилем в существующий код, желательно адекватной алгоритмической сложности.

// lib/game.dart
import 'dart:math';

const TIMESTAMPS_COUNT = 50000;
const PROBABILITY_SCORE_CHANGED = 0.0001;
const PROBABILITY_HOME_SCORE = 0.45;
const OFFSET_MAX_STEP = 3;

class Score {
  final int home;
  final int away;

  Score({
    required this.home,
    required this.away
  });
}

class Stamp {
  final int offset;
  final Score score;

  Stamp({
    required this.offset,
    required this.score
  });
}

final Stamp emptyScoreStamp = Stamp(
  offset: 0,
  score: Score(
    home: 0,
    away: 0,
  ),
);

List<Stamp> generateGame() {
  final stamps = List<Stamp>
      .generate(TIMESTAMPS_COUNT, (score) => emptyScoreStamp);

  var currentStamp = stamps[0];

  for (var i = 0; i < TIMESTAMPS_COUNT; i++) {
    currentStamp = generateStamp(currentStamp);
    stamps[i] = currentStamp;
  }

  return stamps;
}

Stamp generateStamp(Stamp prev) {
  final scoreChanged = Random().nextDouble() > 1 - PROBABILITY_SCORE_CHANGED;
  final homeScoreChange =
  scoreChanged && Random().nextDouble() < PROBABILITY_HOME_SCORE
      ? 1
      : 0;

  final awayScoreChange = scoreChanged && !(homeScoreChange > 0) ? 1 : 0;
  final offsetChange = (Random().nextDouble() * OFFSET_MAX_STEP).floor() + 1;

  return Stamp(
    offset: prev.offset + offsetChange,
    score: Score(
        home: prev.score.home + homeScoreChange,
        away: prev.score.away + awayScoreChange
    ),
  );
}

Score getScore(List<Stamp> gameStamps, int offset) {
  // continue the function's implementation
}


// bin/main.dart
import 'package:scope_game/game.dart';

void main() {
  final game = generateGame();

  game.forEach((e) {
    print("offset - ${e.offset}; away - ${e.score.away}; home - ${e.score.home};");
  });
}

Задание 2. Разработать тесты для функции определения счета в игре 
Задача 
Для разработанной в предыдущем задании функции getScore(gameStamps, offset) разработайте unit-тесты на базе библиотеки test.
Тесты должны учитывать все возможные случаи использования функции, концентрироваться на проверке одного случая, не повторяться, название тестов должно отражать суть выполняемой проверки.

Задание 3. Разработать мобильное приложение для захвата фото с камеры 
Задача 
Мобильное приложение состоит из одного экрана, с элементами UI:

Preview изображения с камеры
Поле ввода текста для пользовательского комментария
Кнопка, при нажатии на котороую отправляется запрос на сервер.
При нажатии на кнопку, приложение должно определять координаты места в котором находится камера, захватывать изображение с камеры, забирать комментарий из текстового поля и отправлять это запросом на сервер. Пример запроса:

curl  -H "Content-Type: application/javascript" -X POST https://flutter-sandbox.free.beeceptor.com/upload_photo/ -F comment="A photo from the phone camera." -F latitude=38.897675 -F longitude=-77.036547 -F photo=@test.png
