part of dlog;

class Time extends _Display {

  final int _DESCRIPTION = 0;
  final int _INIT = 1;
  final int _FINAL = 2;

  String description;

  List<String> _indexes = new List<String>();
  List<List> _checks = new List<List>();

  Time([this.description]);

  checkBegin(String description) {

    if (_indexes.contains(description)) {
      throw new Exception("dlog.Time: check with description \"$description\" has been initialized");
    }

    _indexes.add(description);
    _checks.add([description, new DateTime.now(), null]);

  }

  checkEnd(String description) {

    int index = _indexes.indexOf(description);

    if (index == -1) {
      throw new Exception("dlog.Time: begin check with description \"$description\" is not found");
    }

    if (_checks[index][_FINAL] is DateTime) {
      throw new Exception("dlog.Time: check with description \"$description\" has been completed");
    }

    _checks[index][_FINAL] = new DateTime.now();
  }

  checkFunc(String description, Function checkit) {
    checkBegin(description);
    checkit();
    checkEnd(description);
  }

  @override
  _initBuffer() {

    if (description is String) {
      _outputBufferWriteLn(Symbols.singleLineHorizontal, 48);
      _outputBufferWrite(Symbols.space);
      _outputBufferWriteLn(this.description);
    }

    _outputBufferWrite(Symbols.singleLineHorizontal, 5);
    _outputBufferWrite(Symbols.singleLineFromBottom);
    _outputBufferWrite(Symbols.singleLineHorizontal, 16);
    _outputBufferWrite(Symbols.singleLineFromBottom);
    _outputBufferWriteLn(Symbols.singleLineHorizontal, 25);

    for (int i = 0; i < _indexes.length; i++) {
      Duration diff = _checks[i][_FINAL].difference(_checks[i][_INIT]);
      String num = (i + 1).toString();
      _outputBufferWrite(Symbols.space);
      _outputBufferWrite(num);
      _outputBufferWrite(Symbols.space, 4 - num.length);
      _outputBufferWrite(Symbols.singleLineVertical);
      _outputBufferWrite(Symbols.space);
      _outputBufferWrite(diff.toString());
      _outputBufferWrite(Symbols.space);
      _outputBufferWrite(Symbols.singleLineVertical);
      _outputBufferWrite(Symbols.space);
      _outputBufferWriteLn(_checks[i][_DESCRIPTION]);
    }

    _outputBufferWrite(Symbols.singleLineHorizontal, 5);
    _outputBufferWrite(Symbols.singleLineFromTop);
    _outputBufferWrite(Symbols.singleLineHorizontal, 16);
    _outputBufferWrite(Symbols.singleLineFromTop);
    _outputBufferWriteLn(Symbols.singleLineHorizontal, 25);
  }
}