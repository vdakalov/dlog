part of dlog;

class Table<C, R> extends _Display {

  List<int> _columnsWidth = new List<int>();
  int _tableWidth = 2;
  int _currentRow = 3;
  int _currentColumn = 4;
  int _size = 0;

  final List<C> columns = new List<C>();
  final List<R> data = new List<R>();

  int get size => columns.length > 0 ? columns.length : _size;
  void set size(int num) {
    _size = num;
    if (columns.length > num) {
      columns.length = num;
    }
  }

  Table(this._size);

  Table.fromHeader(List<C> columns_) {
    if (columns_ is List<C>) {
      columns.addAll(columns_);
      size = columns.length;
    }
  }

  Table.fromData(this._size, List<R> rows_) {
    if (rows_ is List<R>) {
      data.addAll(rows_);
    }
  }

  _initBuffer() {

    List<int> sizes = new List<int>();
    int totalWidth = 0;

    if (columns.length > 0) {
      size = columns.length;
    }

    if (size == null) {
      return "Log (Table): Specify the number of columns (property size)";
    }

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

    _columnsWidth = sizes;
    _tableWidth = totalWidth;

    _tableBegin();
    _tableHeader();

    int len = data.length;
    data.length = data.length - (data.length % size);

    for (int i = 0; i < data.length; i += size) {
      if (data.length >= i + size) {
        _currentRow = i;
        _tableRow(data.sublist(i, i + size));
        if (i + size < data.length) {
          _tableRowSeparator();
        }
      }
    }

    _tableEnd();

  }

  void _tableCell(String cell) {
    int width = _columnsWidth[_currentColumn];

    _outputBufferWrite(cell);
    _outputBufferWrite(Symbols.space, width - cell.length);
  }

  void _tableBegin() {

    _outputBufferWrite(Symbols.singleLineAngleTopLeft);

    for (int i = 0; i < _columnsWidth.length; i++) {
      if (i > 0) {
        _outputBufferWrite(Symbols.singleLineFromBottom);
      }
      _outputBufferWrite(
          Symbols.singleLineHorizontal,
          _columnsWidth[i] + 2);
    }
    _outputBufferWriteLn(Symbols.singleLineAngleTopRight);
  }

  void _tableEnd() {

    _outputBufferWrite(Symbols.singleLineAngleBottomLeft);

    for (int i = 0; i < _columnsWidth.length; i++) {
      if (i > 0) {
        _outputBufferWrite(Symbols.singleLineFromTop);
      }
      _outputBufferWrite(
          Symbols.singleLineHorizontal,
          _columnsWidth[i] + 2);
    }
    _outputBufferWriteLn(Symbols.singleLineAngleBottomRight);
  }

  void _tableHeader() {

    if (columns.length == 0) {
      return ;
    }

    _outputBufferWrite(Symbols.singleLineVertical);
    _outputBufferWrite(Symbols.space);

    for (int i = 0; i < columns.length; i++) {
      _currentColumn = i;
      _tableCell(columns[i].toString().toUpperCase());
      if (columns.last != columns[i]) {
        _tableHeaderCellSeparator();
      }
    }

    _outputBufferWrite(Symbols.space);
    _outputBufferWriteLn(Symbols.singleLineVertical);

    _tableHeaderSeparator();
  }

  void _tableHeaderSeparator() {

    _outputBufferWrite(Symbols.singleLineFromRight);

    for (int i = 0; i < _columnsWidth.length; i++) {
      if (i > 0) {
        _outputBufferWrite(Symbols.singleLineCross);
      }
      _outputBufferWrite(
          Symbols.singleLineHorizontal,
          _columnsWidth[i] + 2);
    }

    _outputBufferWriteLn(Symbols.singleLineFromLeft);
  }

  void _tableHeaderCellSeparator() {
    _outputBufferWrite(Symbols.space);
    _outputBufferWrite(Symbols.singleLineVertical);
    _outputBufferWrite(Symbols.space);
  }

  void _tableCellSeparator() {
    _outputBufferWrite(Symbols.space);
    _outputBufferWrite(Symbols.singleLineVertical);
    _outputBufferWrite(Symbols.space);
  }

  void _tableRow(List<R> row) {
    _outputBufferWrite(Symbols.singleLineVertical);
    _outputBufferWrite(Symbols.space);

    for (int i = 0; i < row.length; i++) {
      _currentColumn = i;
      _tableCell(row[i].toString());
      if (i < row.length - 1) {
        _tableCellSeparator();
      }
    }

    _outputBufferWrite(Symbols.space);
    _outputBufferWriteLn(Symbols.singleLineVertical);
  }

  void _tableRowSeparator() {

    _outputBufferWrite(Symbols.singleLineFromRight);

    for (int i = 0; i < _columnsWidth.length; i++) {
      if (i > 0) {
        _outputBufferWrite(Symbols.singleLineCross);
      }
      _outputBufferWrite(
          Symbols.singleLineHorizontal,
          _columnsWidth[i] + 2);
    }

    _outputBufferWriteLn(Symbols.singleLineFromLeft);
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
    var clone = new Table(size);
    clone.columns.addAll(columns);
    clone.data.addAll(data);
    return clone;
  }

}