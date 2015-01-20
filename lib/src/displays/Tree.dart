part of dlog;

class Tree<E> extends _Display {

  List<E> _items = new List<E>();
  List _stack = new List();

  int _depth = -1;

  String title;

  Tree([this.title]);

  add(E text) {
    _stack.last.add(_items.length);
    _items.add(text);
  }

  openGroup() {

    if (_stack.length == 0) {
      _stack.add(_stack);
    }

    List group = new List();
    _stack.last.add(group);
    _stack.add(group);
  }

  closeGroup() {
    _stack.removeLast();
  }

  _group(List group) {

    _depth++;

    group.forEach((item){

      bool first = group.first == item,
           last = group.last == item,
           isGroup = item is List;

      if (isGroup) {
        _group(item);

      } else {

        _outputBufferWrite(Symbols.singleLineVertical + Symbols.space, _depth);

        if (last) {
          _outputBufferWrite(Symbols.singleLineAngleBottomLeft);
        } else {
          _outputBufferWrite(Symbols.singleLineFromRight);
        }

        _outputBufferWrite(Symbols.space);
        _outputBufferWriteLn(_items[item].toString());
      }
    });

    _depth--;
  }

  _item(E item) {

  }

  @override
  _initBuffer() {

    if (title is String) {
      _outputBufferWriteLn(title);
    }
    _group(_stack.sublist(1));

  }
}