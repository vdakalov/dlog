part of Log;

const _BUFFER_OUTPUT = 0;
const _BUFFER_COLUMNS_WIDTH = 1;
const _BUFFER_TABLE_WIDTH = 2;
const _BUFFER_CURRENT_ROW = 3;
const _BUFFER_CURRENT_COLUMN = 4;
const _BUFFER_TIME_INIT = 5;
const _BUFFER_TIME_TABLE = 6;
const _BUFFER_TIME_ROWS = 7;
const _BUFFER_TIME_ALL = 8;

class Table<C, R> {

  final List<C> columns = new List<C>();
  final List<R> data = new List<R>();
  final Map<int, dynamic> _buffers = new Map<int, dynamic>();

  int size;
  bool verbose = false;

  Table.fromCollumns(List<C> columns_) {
    if (columns_ is List<C>) {
      columns.addAll(columns_);
    }
  }

  Table.fromData(this.size, List<R> rows_) {
    if (rows_ is List<R>) {
      data.addAll(rows_);
    }
  }

  void _initBuffers() {

    List<int> sizes = new List<int>();
    int totalWidth = 0;

    for (int i = 0; i < columns.length; i++) {
      String value = columns[i].toString();

      if (i >= sizes.length) {
        sizes.add(0);
      }

      if (value.length > sizes[i]) {
        sizes[i] = value.length;
      }
    }

    for (int i = 0; i < data.length; i++) {
      int _i = i % size;
      String value = data[i].toString();

      if (_i >= sizes.length) {
        sizes.add(0);
      }

      if (value.length > sizes[_i]) {
        sizes[_i] = value.length;
      }
    }

    sizes.forEach((size){ totalWidth += size; });

    _buffers[_BUFFER_OUTPUT] = new List<String>();
    _buffers[_BUFFER_COLUMNS_WIDTH] = sizes;
    _buffers[_BUFFER_TABLE_WIDTH] = totalWidth;
  }

  void _bufferOutputAdd(String char, {int num: 1}) {
    for (; num > 0; num--) {
      _buffers[_BUFFER_OUTPUT].add(char);
    }
  }

  void _bufferOutputAddLn(String char, {int num: 1}) {
    _bufferOutputAdd(char, num: num);
    _bufferOutputEOL();
  }

  void _bufferOutputEOL() {
    _bufferOutputAdd(Symbols.CL);
  }

  void _tableCell(String cell) {
    int width = _buffers[_BUFFER_COLUMNS_WIDTH][_buffers[_BUFFER_CURRENT_COLUMN]];

    _bufferOutputAdd(cell);
    _bufferOutputAdd(Symbols.space, num: width - cell.length);
  }

  void _tableBegin() {

    _bufferOutputAdd(Symbols.singleLineAngleTopLeft);

    for (int i = 0; i < _buffers[_BUFFER_COLUMNS_WIDTH].length; i++) {
      if (i > 0) {
        _bufferOutputAdd(Symbols.singleLineFromBottom);
      }
      _bufferOutputAdd(
          Symbols.singleLineHorizontal,
          num: _buffers[_BUFFER_COLUMNS_WIDTH][i] + 2);
    }
    _bufferOutputAddLn(Symbols.singleLineAngleTopRight);
  }

  void _tableEnd() {

    _bufferOutputAdd(Symbols.singleLineAngleBottomLeft);

    for (int i = 0; i < _buffers[_BUFFER_COLUMNS_WIDTH].length; i++) {
      if (i > 0) {
        _bufferOutputAdd(Symbols.singleLineFromTop);
      }
      _bufferOutputAdd(
          Symbols.singleLineHorizontal,
          num: _buffers[_BUFFER_COLUMNS_WIDTH][i] + 2);
    }
    _bufferOutputAddLn(Symbols.singleLineAngleBottomRight);
  }

  void _tableHeader() {
    _bufferOutputAdd(Symbols.singleLineVertical);
    _bufferOutputAdd(Symbols.space);

    for (int i = 0; i < columns.length; i++) {
      _buffers[_BUFFER_CURRENT_COLUMN] = i;
      _tableCell(columns[i].toString().toUpperCase());
      if (columns.last != columns[i]) {
        _tableHeaderCellSeparator();
      }
    }

    _bufferOutputAdd(Symbols.space);
    _bufferOutputAddLn(Symbols.singleLineVertical);

    _tableHeaderSeparator();
  }

  void _tableHeaderSeparator() {

    _bufferOutputAdd(Symbols.singleLineFromRight);

    for (int i = 0; i < _buffers[_BUFFER_COLUMNS_WIDTH].length; i++) {
      if (i > 0) {
        _bufferOutputAdd(Symbols.singleLineCross);
      }
      _bufferOutputAdd(
          Symbols.singleLineHorizontal,
          num: _buffers[_BUFFER_COLUMNS_WIDTH][i] + 2);
    }

    _bufferOutputAddLn(Symbols.singleLineFromLeft);
  }

  void _tableHeaderCellSeparator() {
    _bufferOutputAdd(Symbols.space);
    _bufferOutputAdd(Symbols.singleLineVertical);
    _bufferOutputAdd(Symbols.space);
  }

  void _tableCellSeparator() {
    _bufferOutputAdd(Symbols.space);
    _bufferOutputAdd(Symbols.singleLineVertical);
    _bufferOutputAdd(Symbols.space);
  }

  void _tableRow(List<R> row) {
    _bufferOutputAdd(Symbols.singleLineVertical);
    _bufferOutputAdd(Symbols.space);

    for (int i = 0; i < row.length; i++) {
      _buffers[_BUFFER_CURRENT_COLUMN] = i;
      _tableCell(row[i].toString());
      if (row.last != row[i]) {
        _tableCellSeparator();
      }
    }

    _bufferOutputAdd(Symbols.space);
    _bufferOutputAddLn(Symbols.singleLineVertical);
  }

  void _tableRowSeparator() {

    _bufferOutputAdd(Symbols.singleLineFromRight);

    for (int i = 0; i < _buffers[_BUFFER_COLUMNS_WIDTH].length; i++) {
      if (i > 0) {
        _bufferOutputAdd(Symbols.singleLineCross);
      }
      _bufferOutputAdd(
          Symbols.singleLineHorizontal,
          num: _buffers[_BUFFER_COLUMNS_WIDTH][i] + 2);
    }

    _bufferOutputAddLn(Symbols.singleLineFromLeft);
  }

  void _timeStart(int index) {
    _buffers[index] = new DateTime.now();
  }

  void _timeEnd(int index) {
    _buffers[index] = new DateTime.now().difference(_buffers[index]);
  }

  void _additionalInfo() {
    _bufferOutputAddLn("render time:");
    _bufferOutputAddLn(" - all: ${_buffers[_BUFFER_TIME_ALL].inMilliseconds}ms");
    _bufferOutputAddLn(" - init: ${_buffers[_BUFFER_TIME_INIT].inMilliseconds}ms");
    _bufferOutputAddLn(" - table: ${(_buffers[_BUFFER_TIME_TABLE] - _buffers[_BUFFER_TIME_ROWS]).inMilliseconds}ms");
    _bufferOutputAddLn(" - rows: ${_buffers[_BUFFER_TIME_ROWS].inMilliseconds}ms");
    _bufferOutputAddLn(" - row: ${_buffers[_BUFFER_TIME_ROWS].inMilliseconds/(data.length/size)}ms");
  }

  Table crop(int startRow, int numRow) {

    startRow *= size;
    numRow *= size;

    List sublist = data.sublist(startRow, startRow + numRow);

    data.clear();
    data.addAll(sublist);

    return this;
  }

  Table clone() {
    return new Table.fromData(size, data);
  }

  String toString() {

    if (verbose) {
      _timeStart(_BUFFER_TIME_ALL);
      _timeStart(_BUFFER_TIME_INIT);
    }

    if (size == null) {
      if (columns.length > 0) {
        size = columns.length;
      } else {
        return "Log (Table): Укажите количество колонок (свойство size)";
      }
    }

    _initBuffers();

    if (verbose) {
      _timeEnd(_BUFFER_TIME_INIT);
      _timeStart(_BUFFER_TIME_TABLE);
    }

    _tableBegin();
    _tableHeader();

    int len = data.length;
    data.length = data.length - (data.length % size);

    if (verbose) {
      _timeStart(_BUFFER_TIME_ROWS);
    }

    for (int i = 0; i < data.length; i += size) {
      if (data.length >= i + size) {
        _buffers[_BUFFER_CURRENT_ROW] = i;
        _tableRow(data.sublist(i, i + size));
        if (i + size < data.length) {
          _tableRowSeparator();
        }
      }
    }

    if (verbose) {
      _timeEnd(_BUFFER_TIME_ROWS);
    }

    _tableEnd();

    if (verbose) {
      _timeEnd(_BUFFER_TIME_TABLE);
      _timeEnd(_BUFFER_TIME_ALL);
    }

    if (verbose) {
      _bufferOutputAddLn("redundant cells: ${len - data.length}");
      _additionalInfo();
    }

    return _buffers[_BUFFER_OUTPUT].join();
  }

}