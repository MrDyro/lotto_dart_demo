import 'package:lotto_dart/console_helper.dart';
import 'package:lotto_dart/lotto.dart';
import 'package:lotto_dart/service/lotto_service.dart';

void main(List<String> arguments) {
  final _lotto = Lotto(LottoService());

  print('Willkommen bei Lotto, 6 aus 49 plus Zusatzzahl!');

  var nextGame = true;
  do {
    _lotto.startLotto();

    print('Möchten Sie nochmal spielen?');
    nextGame = ConsoleHelper.readYesOrNo();
  } while (nextGame);

  print('Danke das Sie an Lotto teilgenommen haben.');
}
