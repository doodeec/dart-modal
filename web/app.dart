import 'modal.dart';
import 'dart:html';
import 'dart:async';

void main() {
  prepareModals();

  ButtonElement oneMod = querySelector('#one_modal');
  ButtonElement twoMod = querySelector('#two_modals');

  oneMod.onClick.listen((Event e) {
    Modal msg = createModal('Test', 'Modal test message');
    msg.open();

    e.stopPropagation();
    e.preventDefault();
  });

  twoMod.onClick.listen((Event e) {
    Modal msg1 = createModal('First', 'First modal message');
    msg1.open();

    new Timer(new Duration(seconds: 2), () {
      Modal msg2 = createModal('Second', 'Second modal message');
      msg2.addBtn('Close', (Modal modal) {
        modal.close();
      });
      msg2.addBtn('Change text', (Modal modal) {
        modal.setMessage('New message in second modal');
      });
      msg2.open();
    });

    e.stopPropagation();
    e.preventDefault();
  });
}