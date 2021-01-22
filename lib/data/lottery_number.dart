import 'package:lotto_dart/data/base_lottery_number.dart';

class LotteryNumber extends BaseLotteryNumber {
  LotteryNumber(int value) : super(value);

  @override
  bool isValueInRange() {
    return value > 0 && value < 50;
  }
}
