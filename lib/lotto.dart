import 'package:lotto_dart/data/base_lottery_number.dart';
import 'package:lotto_dart/data/bonus_number.dart';
import 'package:lotto_dart/data/lottery_number.dart';
import 'package:lotto_dart/service/lotto_service.dart';

import 'console_helper.dart';

class Lotto {
  final _inputs = <BaseLotteryNumber>[];
  final LottoService _lottoService;

  Lotto(this._lottoService);

  void startLotto() {
    _requestLotteryNumbers();
    _requestBonusNumber();

    _lottoService.draftLotteryNumbers();

    _calcMatchingNumbers();

    print('Möchten Sie die Ziehung sehen? [ja/nein]');
    final willSeeDraft = ConsoleHelper.readYesOrNo();
    if (willSeeDraft) {
      _printDraft();
    }
  }

  void _requestLotteryNumbers() {
    print('Geben Sie nun Ihre 6 Zahlen ein');
    for (var index = 0; index < 6; index++) {
      final input = ConsoleHelper.readInput();
      final clearInput = input.trim();
      final lotteryNumber = LotteryNumber(int.parse(clearInput));
      _inputs.add(lotteryNumber);
    }

    var numbersInRange = true;
    final iterator = _inputs.iterator;
    while (iterator.moveNext()) {
      final item = iterator.current;
      numbersInRange = item.isValueInRange();
      if (!numbersInRange) break;
    }

    if (!numbersInRange) {
      print(
          'Es sind nur Werte zwischen 1 und 49 erlaubt. Wiederholen Sie Ihre Eingabe.');
      _inputs.clear();
      _requestLotteryNumbers();
    }
  }

  void _requestBonusNumber() {
    print('Gaben Sie nun Ihre Zusatzzahl ein.');
    final input = ConsoleHelper.readInput();
    final clearInput = input.trim();
    final bonusNumber = BonusNumber(int.parse(clearInput));

    if (!bonusNumber.isValueInRange()) {
      print(
          'Es ist nur eine Wert zwischen 0 und 9 erlaubt. Wiederholen Sie Ihre Eingabe.');
      return _requestBonusNumber();
    }

    _inputs.add(bonusNumber);
  }

  void _calcMatchingNumbers() {
    var matchingNumbers = 0;
    var matchingBonusNumber = 0;

    _inputs.take(6).forEach((input) {
      _lottoService.draft.take(6).forEach((draft) {
        if (input.value == draft.value) {
          matchingNumbers++;
        }
      });
    });

    if (_inputs.last.value == _lottoService.draft.last.value) {
      matchingBonusNumber++;
    }

    print(
        'Sie haben $matchingNumbers/6 Zahlen richtig und $matchingBonusNumber/1 Zusatzzahlen richtig.');
  }

  void _printDraft() {
    print('Folgende Zahlen wurden gezogen:');
    final buffer = StringBuffer();
    _lottoService.draft.take(6).forEach((element) {
      buffer.write(element.value.toString() + ', ');
    });
    print(buffer.toString());
    print('Zusatzzahl:');
    print(_lottoService.draft.last.value);
  }
}
