import 'dart:math';

import 'package:lotto_dart/data/base_lottery_number.dart';
import 'package:lotto_dart/data/bonus_number.dart';
import 'package:lotto_dart/data/lottery_number.dart';

class LottoService {
  final _random = Random();
  final List<BaseLotteryNumber> _lastDraft =
      List.filled(6, null, growable: false);

  List<BaseLotteryNumber> get draft => _lastDraft;

  void draftLotteryNumbers() {
    for (var i = 0; i < 6; i++) {
      _lastDraft[i] = LotteryNumber(_generateLotteryNumber());
    }
    _lastDraft[6] = BonusNumber(_generateBonusNumber());
  }

  int _generateLotteryNumber() {
    return _random.nextInt(48) + 1;
  }

  int _generateBonusNumber() {
    return _random.nextInt(9);
  }
}
