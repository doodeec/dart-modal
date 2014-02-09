library modal;

import 'dart:html';
import 'dom.dart';

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

  Modal(String name, String message) {
    this.name = name;
    this.message = message;
    this.id = m;

    this.populateElement();
    m++;
  }

  void populateElement() {
    this._header = new DivElement();
    this._body = new DivElement();
    this._footer = new DivElement();

    this._header.text = this.name;
    addClass(this.elem, 'modal');
    this.reloadMessage();
  }

  void renderModal() {
    this._footer.children.clear();

    int i = 0, len = this.buttons.length;
    for(; i<len; i++) {
      this._footer.children.add(this.buttons[i]);
    }

    //if no button is defined, create default one
    if(this.buttons.length == 0) {
      ButtonElement defaultButton = new ButtonElement();
      defaultButton.text = 'OK';
      defaultButton.onClick.listen((Event e) {
        this.close();
        e.preventDefault();
        e.stopPropagation();
      });
      this._footer.children.add(defaultButton);
    }

    // append elements
    this.elem.children.add(this._header);
    this.elem.children.add(this._body);
    this.elem.children.add(this._footer);

    wrapper.children.add(this.elem);
  }

  void addBtn(String label, [Function clickHandler]) {
    Element newButton = new ButtonElement();
    newButton.text = label;
    //TODO handle click globally per modal - differentiate by event.target
    if (clickHandler != null) newButton.onClick.listen(clickHandler);

    buttons.add(newButton);
  }

  void open() {
    this.renderModal();
    openedModals.add(this.id);
    checkBackdrop();
  }

  void close() {
    openedModals.removeAt(openedModals.indexOf(this.id));
    elem.remove();
    checkBackdrop();
  }

  String reloadMessage() {
    this._body.text = this.message;
    return this.message;
  }

  void set setMessage(String msg) {
    this.message = msg;
    this.reloadMessage();
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
  if (openedModals.length > 0) {
    addClass(backdrop, 'shown');
  } else {
    removeClass(backdrop, 'shown');
  }

}