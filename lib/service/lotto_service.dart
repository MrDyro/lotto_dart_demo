import 'dart:math';

import 'package:lotto_dart/data/base_lottery_number.dart';
import 'package:lotto_dart/data/bonus_number.dart';
import 'package:lotto_dart/data/lottery_number.dart';

class LottoService {
  final _random = Random();
  final _lastDraft = List<BaseLotteryNumber>(7);

  List<BaseLotteryNumber> get draft => _lastDraft;

  void draftLotteryNumbers() {
    for (var i = 0; i < 6; i++) {
      var number;
      var sameNumber = false;
      do {
        number = _generateLotteryNumber();
        sameNumber = _numberAlreadyExists(number);
      } while (sameNumber);

      _lastDraft[i] = LotteryNumber(number);
    }
    _lastDraft[6] = BonusNumber(_generateBonusNumber());
  }

  int _generateLotteryNumber() {
    return _random.nextInt(48) + 1;
  }

  int _generateBonusNumber() {
    return _random.nextInt(9);
  }

  bool _numberAlreadyExists(int generatedNumber) {
    var sameNumber = false;
    for (var j = 0; j < _lastDraft.length; j++) {
      if (generatedNumber == _lastDraft[j]?.value ?? -1) {
        sameNumber = true;
        break;
      }
    }
    return sameNumber;
  }
}
