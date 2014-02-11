library modal;

import 'dart:html';

DivElement backdrop = new DivElement(),
  wrapper = new DivElement();
List<Modal> allModals = new List();
List<int> openedModals = new List();
String topModalClass = 'top-modal',
  mHeaderClass = 'modal-header',
  mBodyClass = 'modal-body',
  mFooterClass = 'modal-footer';
int m = 1;

class Modal {
  String name, message;
  int id;
  Element elem = new DivElement();
  List<Map> buttons = new List();
  Element _header, _body, _footer;
  Map eventHandlers = new Map();

  Modal(this.name, this.message) {
    id = m;
    populateElement();
    m++;
  }

  void populateElement() {
    _header = new DivElement()
                    ..classes.add(mHeaderClass);
    _body = new DivElement()
                    ..classes.add(mBodyClass);
    _footer = new DivElement()
                    ..classes.add(mFooterClass);

    _header.text = name;
    elem.classes.add('modal');
    reloadMessage();
  }

  void clickHandler(Event e) {
    String id = e.target.id;

    if (eventHandlers.containsKey(id)) {
      eventHandlers[id](this);
    }

    e.preventDefault();
    e.stopPropagation();
  }

  void renderModal() {
    _footer.children.clear();

    int i = 0, len = buttons.length;
    Map button;
    for(; i<len; i++) {
      button = buttons[i];
      eventHandlers['button-${i}'] = button['handler'];
      _footer.children.add(new ButtonElement()
          ..text = button['text']
          ..id = 'button-${i}'
      );
    }

    //if no button is defined, create default one
    if(buttons.length == 0) {
      eventHandlers['empty-button'] = this.close;
      _footer.children.add(new ButtonElement()
          ..text = 'OK'
          ..id = 'empty-button'
      );
    }

    // append elements
    elem.children.add(_header);
    elem.children.add(_body);
    elem.children.add(_footer);

    wrapper.children.add(elem);

    elem.onClick.listen(clickHandler);
  }

  Modal addBtn(String label, [Function clickHandler]) {
    Map newButton = new Map();
    newButton['text'] = label;
    newButton['handler'] = clickHandler;
    buttons.add(newButton);
    return this;
  }

  Modal open() {
    renderModal();
    openedModals.insert(0,id);
    markActiveModal();
    checkBackdrop();
    return this;
  }

  void close([_]) {
    openedModals.removeAt(openedModals.indexOf(id));
    elem.remove();
    markActiveModal();
    checkBackdrop();
  }

  String reloadMessage() {
    _body.text = message;
    return message;
  }

  void setMessage(String msg) {
    message = msg;
    reloadMessage();
  }
}

void markActiveModal() {
  if (openedModals.length > 1) {
    getModal(openedModals[1]).elem.classes.remove(topModalClass);
  }
  if (openedModals.length > 0) {
    getModal(openedModals[0]).elem.classes.add(topModalClass);
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

Modal getModalByName(String name) {
  int i = 0, len = allModals.length;
  Modal modal;
  for(; i<len; i++) {
    modal = allModals[i];
    if(modal.name == name) return modal;
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
  if (openedModals.length > 0) {
    backdrop.classes.add('shown');
  } else {
    backdrop.classes.remove('shown');
  }
}