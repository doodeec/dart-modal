import 'modal.dart';

void main() {
  prepareModals();

  Modal msg = new Modal('test', 'modal test message');
  msg.open();
}