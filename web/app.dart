import 'modal.dart';
import 'dart:html';
import 'dart:async';

void main() {
  prepareModals();

  ButtonElement oneMod = querySelector('#one_modal');
  ButtonElement twoMod = querySelector('#two_modals');

  oneMod.onClick.listen((Event e) {
    createModal('Test', 'Modal test message').open();

    e.stopPropagation();
    e.preventDefault();
  });

  twoMod.onClick.listen((Event e) {
    createModal('First', 'First modal message').open();

    new Timer(new Duration(seconds: 2), () {
      createModal('Second', 'Second modal message')
        ..addBtn('Close', (Modal modal) => modal.close())
        ..addBtn('Change text', (Modal modal) => modal.setMessage('New message in second modal'))
        ..addBtn('Create Inception', (Modal modal) => createModal('Inception','Modal from modal').open())
        ..open();
    });

    e.stopPropagation();
    e.preventDefault();
  });
}