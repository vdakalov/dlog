part of dlog;

class Json extends _Display {

  final Map<String, Function> parsers = new Map<String, Function>();

  String title;
  dynamic data;

  int _depth = 0;

  int indent = 2;
  int maxStringLen = 45;

  Json({this.data, this.title});

  _depthDown() =>
      _depth += indent;

  _depthUp() =>
      _depth -= indent;

  _typeof(dynamic some) =>
    reflect(some).type.reflectedType.toString();

  _outputDepth() {
    _outputBufferWrite(Symbols.space, _depth);
  }

  _outputItem(dynamic item) {

    if (item is List) {
      _outputBufferWriteLn(Symbols.bracketSquareLeft);
      _depthDown();
      _outputList(item);
      _depthUp();
      _outputDepth();
      _outputBufferWrite(Symbols.bracketSquareRight);

    } else if (item is Map) {
      _outputBufferWriteLn(Symbols.bracketCurlyLeft);
      _depthDown();
      _outputMap(item);
      _depthUp();
      _outputDepth();
      _outputBufferWrite(Symbols.bracketCurlyRight);

    } else if (item is String) {
      _outputString(item);

    } else {

      var type = _typeof(item),
          parser = parsers.containsKey(type) ? parsers[type] : (dynamic some) => some.toString();

      _outputBufferWrite(parser(item));
    }
  }

  _outputString(String text) {

    if (maxStringLen is int) {
      text = text.length > maxStringLen ? text.substring(0, maxStringLen) + "..." : text;
    }

    _outputBufferWrite(Symbols.quotationMark);
    _outputBufferWrite(text);
    _outputBufferWrite(Symbols.quotationMark);
  }

  _outputList(List list) {

    for (int i = 0; i < list.length; i++) {

      _outputDepth();
      _outputBufferWrite(i.toString());
      _outputBufferWrite(Symbols.colon);
      _outputBufferWrite(Symbols.space);

      _outputItem(list[i]);

      if (i < list.length - 1) {
        _outputBufferWrite(Symbols.comma);
      }

      _outputBufferWriteLn("");
    }

  }

  _outputMap(Map map) {

    List keys = map.keys.toList();

    for (int i = 0; i < keys.length; i++) {

      _outputDepth();
      _outputBufferWrite(keys[i].toString());
      _outputBufferWrite(Symbols.colon);
      _outputBufferWrite(Symbols.space);

      _outputItem(map[keys[i]]);

      if (i < keys.length - 1) {
        _outputBufferWrite(Symbols.comma);
      }

      _outputBufferWriteLn("");
    }
  }


  @override
  _initBuffer() {

    _outputBufferWriteLn(title);
    _outputItem(data);
    _outputBufferWriteLn("");

  }
}

