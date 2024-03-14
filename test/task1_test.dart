import 'package:flutter_test/flutter_test.dart';
import 'package:task_1_for_pyshop/tesk1.dart';

void main() {
  test('getScore returns correct score at given offset', () {
    final game = generateGame();
    final offset = game[10].offset;
    final expectedScore = game[10].score;

    final result = getScore(game, offset);

    expect(result.home, expectedScore.home);
    expect(result.away, expectedScore.away);
  });

  test('getScore returns last score before given offset if exact offset not found', () {
    final game = generateGame();
    final offset = game[10].offset + 1;
    final expectedScore = game[10].score;

    final result = getScore(game, offset);

    expect(result.home, expectedScore.home);
    expect(result.away, expectedScore.away);
  });
}
