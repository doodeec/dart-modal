import 'modal.dart';
import 'dart:html';
import 'dart:async';

void main() {
  prepareModals();

  ButtonElement oneMod = querySelector('#one_modal');
  ButtonElement twoMod = querySelector('#two_modals');

  oneMod.onClick.listen((Event e) {
    e.stopPropagation();
    e.preventDefault();

    Modal msg = createModal('test', 'modal test message');
    msg.open();
  });

  twoMod.onClick.listen((Event e) {
    e.stopPropagation();
    e.preventDefault();

    Modal msg1 = createModal('first', 'first modal message');
    msg1.open();

    new Timer(new Duration(seconds: 2), () {
      Modal msg2 = createModal('second', 'second modal message');
      msg2.open();
    });
  });
}