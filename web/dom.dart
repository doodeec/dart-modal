/**
* DOM manipulation (CSS classes) made easier
*/
library dom;

import 'dart:html';

void addClass(Element element, String newClass) {
  if (element == null) return;

  List<String> oldClasses = getCSSClasses(element);
  String newClasses;

  if (oldClasses.indexOf(newClass) == -1) oldClasses.add(newClass);
  newClasses = oldClasses.join(" ");

  element.className = newClasses;
}

void removeClass(Element element, String oldClass) {
  if (element == null) return;

  List<String> oldClasses = getCSSClasses(element);
  String newClasses;

  if (oldClasses.indexOf(oldClass) != -1) oldClasses.remove(oldClass);
  newClasses = oldClasses.join(" ");

  element.className = newClasses;
}

List getCSSClasses(Element element) {
  if (element == null) return new List();

  List<String> hasClasses;
  String classAttribute = element.className;

  hasClasses = (classAttribute.length > 0) ? classAttribute.split(" ") : new List();

  return hasClasses;
}