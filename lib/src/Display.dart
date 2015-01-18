part of DLog;

abstract class _Display {

  final List<String> _outputBuffer = new List<String>();

  String endOfLineUnicode = Symbols.LF;

  _outputBufferWrite(String char, {num: 1}) {
    for (; num > 0; num--) {
      _outputBuffer.add(char);
    }
  }

  _outputBufferWriteLn(String char, {num: 1}) {
    _outputBufferWrite(char, num: num);
    _outputBufferWrite(endOfLineUnicode);
  }

  _initBuffer();

  toString() {
    _initBuffer();
    return _outputBuffer.join();
  }
}