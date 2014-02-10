library modal;

import 'dart:html';

DivElement backdrop = new DivElement(),
  wrapper = new DivElement();
List<Modal> allModals = new List();
List<int> openedModals = new List();
int m = 1;

class Modal {
  String name, message;
  int id;
  Element elem = new DivElement();
  List<ButtonElement> buttons = new List();
  Element _header, _body, _footer;

  Modal(this.name, this.message) {
    id = m;
    populateElement();
    m++;
  }

  void populateElement() {
    _header = new DivElement();
    _body = new DivElement();
    _footer = new DivElement();

    _header.text = name;
    elem.classes.add('modal');
    reloadMessage();
  }

  void renderModal() {
    _footer.children.clear();

    int i = 0, len = buttons.length;
    for(; i<len; i++) {
      _footer.children.add(buttons[i]);
    }

    //if no button is defined, create default one
    if(buttons.length == 0) {
      ButtonElement defaultButton = new ButtonElement();
      defaultButton.text = 'OK';
      defaultButton.onClick.listen((Event e) {
        close();
        e.preventDefault();
        e.stopPropagation();
      });
      _footer.children.add(defaultButton);
    }

    // append elements
    elem.children.add(_header);
    elem.children.add(_body);
    elem.children.add(_footer);

    wrapper.children.add(elem);
  }

  void addBtn(String label, [Function clickHandler]) {
    Element newButton = new ButtonElement();
    newButton.text = label;
    //TODO handle click globally per modal - differentiate by event.target
    if (clickHandler != null) newButton.onClick.listen(clickHandler);

    buttons.add(newButton);
  }

  void open() {
    renderModal();
    openedModals.add(id);
    checkBackdrop();
  }

  void close() {
    openedModals.removeAt(openedModals.indexOf(id));
    elem.remove();
    checkBackdrop();
  }

  String reloadMessage() {
    _body.text = message;
    return message;
  }

  void set setMessage(String msg) {
    message = msg;
    reloadMessage();
  }
}


Modal createModal(String name, String message) {
  Modal newModal = new Modal(name, message);
  allModals.add(newModal);
  return newModal;
}


Modal getModal(int id) {
  int i = 0, len = allModals.length;
  Modal modal;
  for(; i<len; i++) {
    modal = allModals[i];
    if(modal.id == id) return modal;
  }
  return null;
}

void prepareModals() {
  Element body = querySelector('body');
  backdrop.className = 'modal-backdrop';
  wrapper.className = 'modal-wrapper';
  body.children.add(wrapper);
  body.children.add(backdrop);
}

void checkBackdrop() {
  //TODO check top modal when multiple opened -> z-index value changing
  if (openedModals.length > 0) {
    backdrop.classes.add('shown');
  } else {
    backdrop.classes.remove('shown');
  }

}