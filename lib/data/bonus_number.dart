import 'package:lotto_dart/data/base_lottery_number.dart';

class BonusNumber extends BaseLotteryNumber {
  BonusNumber(int value) : super(value);

  @override
  bool isValueInRange() {
    return value > -1 && value < 10;
  }
}
