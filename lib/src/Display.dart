part of dlog;

abstract class _Display {

  final List<String> _outputBuffer = new List<String>();

  bool flush = true;

  String endOfLineUnicode = Symbols.LF;

  _outputBufferWrite(String char, [num]) {
    num = num is int ? num : 1;
    for (; num > 0; num--) {
      _outputBuffer.add(char);
    }
  }

  _outputBufferWriteLn([String char, num]) {
    char = char is String ? char : "";
    _outputBufferWrite(char, num);
    _outputBufferWrite(endOfLineUnicode);
  }

  _initBuffer();

  toString() {

    if (flush) {
      _outputBuffer.clear();
    }

    _initBuffer();
    return _outputBuffer.join();
  }
}