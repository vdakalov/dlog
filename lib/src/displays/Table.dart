part of Log;

const _BUFFER_OUTPUT = 0;
const _BUFFER_COLUMNS_WIDTH = 1;
const _BUFFER_TABLE_WIDTH = 2;
const _BUFFER_CURRENT_ROW = 3;
const _BUFFER_CURRENT_CELL = 4;

class Table<K, V> {

  final List<K> columns = [];
  final List<List<V>> rows = new List<List<V>>();

  final Map<int, dynamic> _buffer = {
    _BUFFER_OUTPUT: "",
    _BUFFER_COLUMNS_WIDTH: 0,
    _BUFFER_TABLE_WIDTH: 0,
    _BUFFER_CURRENT_ROW: 0,
    _BUFFER_CURRENT_CELL: 0
  };

  Table();

  Table.fromData(List<List<V>> rows) {
    this.rows.addAll(rows);
  }

  void _updateColumnsWidthBuffer() {

    List<int> sizes = new List<int>();
    int index = 0, totalWidth = 0;

    rows.forEach((cells){
      index = 0;
      cells.forEach((cell){
        if (index >= sizes.length) {
          sizes.add(0);
        }
        if (cell.toString().length > sizes[index]) {
          sizes[index] = cell.toString().length;
          totalWidth += sizes[index];
        }
        index++;
      });
    });

    _buffer[_BUFFER_COLUMNS_WIDTH] = sizes;
    _buffer[_BUFFER_TABLE_WIDTH] = totalWidth;
  }

  void _bufferAdd(String char, {int num: 1}) {
    for (; num > 0; num--) {
      _buffer[_BUFFER_OUTPUT] += char;
    }
  }

  void _bufferEOL() {
    _bufferAdd(Symbols.CL);
  }

  void _tableCell(String cell) {
    int width = _buffer[_BUFFER_COLUMNS_WIDTH][_buffer[_BUFFER_CURRENT_CELL]];

    _bufferAdd(cell);
    _bufferAdd(Symbols.space, num: width - cell.length);

  }

  void _tableBegin() {

    _updateColumnsWidthBuffer();
    _bufferAdd(Symbols.doubleLineAngleTopLeft);

    for (int i = 0; i < _buffer[_BUFFER_COLUMNS_WIDTH].length; i++) {
      if (i > 0) {
        _bufferAdd(Symbols.doubleLineFromTop);
      }
      _bufferAdd(
          Symbols.doubleLineHorizontal,
          num: _buffer[_BUFFER_COLUMNS_WIDTH][i] + 2);
    }
    _bufferAdd(Symbols.doubleLineAngleTopRight);
    _bufferEOL();
  }

  void _tableEnd() {

    _bufferAdd(Symbols.doubleLineAngleBottomLeft);

    for (int i = 0; i < _buffer[_BUFFER_COLUMNS_WIDTH].length; i++) {
      if (i > 0) {
        _bufferAdd(Symbols.doubleLineFromBottom);
      }
      _bufferAdd(
          Symbols.doubleLineHorizontal,
          num: _buffer[_BUFFER_COLUMNS_WIDTH][i] + 2);
    }
    _bufferAdd(Symbols.doubleLineAngleBottomRight);
  }

  void _tableCellSeparator() {
    _bufferAdd(Symbols.space);
    _bufferAdd(Symbols.doubleLineVertical);
    _bufferAdd(Symbols.space);
  }

  void _tableRow(List<dynamic> row) {
    _bufferAdd(Symbols.doubleLineVertical);
    _bufferAdd(Symbols.space);

    for (int i = 0; i < row.length; i++) {
      _buffer[_BUFFER_CURRENT_CELL] = i;
      _tableCell(row[i].toString());
      if (row.last != row[i]) {
        _tableCellSeparator();
      }
    }

    _bufferAdd(Symbols.space);
    _bufferAdd(Symbols.doubleLineVertical);
    _bufferEOL();
  }

  void _tableRowSeparator() {

    _bufferAdd(Symbols.doubleLineFromLeft);

    for (int i = 0; i < _buffer[_BUFFER_COLUMNS_WIDTH].length; i++) {
      if (i > 0) {
        _bufferAdd(Symbols.doubleLineCross);
      }
      _bufferAdd(
          Symbols.doubleLineHorizontal,
          num: _buffer[_BUFFER_COLUMNS_WIDTH][i] + 2);
    }

    _bufferAdd(Symbols.doubleLineFromRight);
    _bufferEOL();
  }

  void subTable(int startRow, int numRow, {int startCell, int numCell}) {

    List sublist = rows.sublist(startRow, startRow + numRow);

    if (startCell > 0 && numCell > 0) {
      sublist = sublist.map((row){
        return row.sublist(startCell, startCell + numCell);
      });
    }

    rows.clear();
    rows.addAll(sublist);
  }

  Table clone() {
    return new Table.fromData(rows);
  }

  String toString() {

    _tableBegin();

    for (int i = 0; i < rows.length; i++) {
      _buffer[_BUFFER_CURRENT_ROW] = i;
      _tableRow(rows[i]);
      if (rows.last != rows[i]) {
        _tableRowSeparator();
      }
    }

    _tableEnd();

    return _buffer[_BUFFER_OUTPUT];
  }

}