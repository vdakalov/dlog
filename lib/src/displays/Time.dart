part of dlog;

class Time extends _Display {

  String description;

  List<String> _actionNames = new List<String>();
  List<DateTime> _actionStamps = new List<DateTime>();

  Time([this.description = "undescribed"]);

  _registerAction(String description) {
    _actionNames.add(description);
    _actionStamps.add(new DateTime.now());
  }

  init() {
    _registerAction("init");
  }

  check(String description, [Function doit]) {
    _registerAction(description);
  }

  checkFunc(String description, Function doit) {
    doit();
    _registerAction(description);
  }

  checkLoopFunc(String description, num count, Function doit) {
    while (count-- > 0) { doit(); }
    _registerAction(description);
  }

  @override
  _initBuffer() {

    _outputBufferWriteLn(this.description);

    for (int i = 1; i < _actionNames.length; i++) {
      Duration diff = _actionStamps[i].difference(_actionStamps[i-1]);
      _outputBufferWriteLn("$i. ${diff} - ${_actionNames[i]}");
    }

  }
}