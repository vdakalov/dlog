// Copyright (c) 2015, Viktor Dakalov. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:unittest/unittest.dart';
import 'package:dlog/dlog.dart';

gen(int rows, int cols, List target) {
  cols = rows * cols;
  while (rows-- > 0) {
    while (cols-- > 0) {
      target.add("$rows-$cols");
    }
  }
}

main() {

  test("Table 3x10", (){

    List<String> output = [
      '┌──────┬──────┬──────┐',
      '│ 9-29 │ 9-28 │ 9-27 │',
      '├──────┼──────┼──────┤',
      '│ 9-26 │ 9-25 │ 9-24 │',
      '├──────┼──────┼──────┤',
      '│ 9-23 │ 9-22 │ 9-21 │',
      '├──────┼──────┼──────┤',
      '│ 9-20 │ 9-19 │ 9-18 │',
      '├──────┼──────┼──────┤',
      '│ 9-17 │ 9-16 │ 9-15 │',
      '├──────┼──────┼──────┤',
      '│ 9-14 │ 9-13 │ 9-12 │',
      '├──────┼──────┼──────┤',
      '│ 9-11 │ 9-10 │ 9-9  │',
      '├──────┼──────┼──────┤',
      '│ 9-8  │ 9-7  │ 9-6  │',
      '├──────┼──────┼──────┤',
      '│ 9-5  │ 9-4  │ 9-3  │',
      '├──────┼──────┼──────┤',
      '│ 9-2  │ 9-1  │ 9-0  │',
      '└──────┴──────┴──────┘',
      ''
    ];

    Table table = new Table(3);
    gen(10, table.size, table.data);
    expect(table.toString(), output.join(table.endOfLineUnicode));

  });

  test("types", (){

    Table table = new Table<String, int>(3);

    // wrong type for columns

    table.columns.add("Number");
    expect(table.columns[0], "Number");

    bool wrongColumnType = false;
    try { table.columns.add(10); } catch (e) { wrongColumnType = true; }
    expect(wrongColumnType, isTrue);

    // wrong type for data

    table.data.add(10);
    expect(table.data[0], 10);

    bool wrongDataType = false;
    try { table.data.add(true); } catch (e) { wrongDataType = true; }
    expect(wrongDataType, isTrue);

  });

  test("crop method", (){

    List<String> output = [
      '┌──────┬──────┬──────┐',
      '│ 9-23 │ 9-22 │ 9-21 │',
      '├──────┼──────┼──────┤',
      '│ 9-20 │ 9-19 │ 9-18 │',
      '└──────┴──────┴──────┘',
      ''
    ];

    Table table = new Table(3);
    gen(10, table.size, table.data);
    expect(table.crop(2, 2).toString(), output.join(table.endOfLineUnicode));

  });

  test("clone method", (){

    Table table = new Table(1);
    table.data.add(1);
    table.data.add(2);

    Table clone = table.clone();

    expect(clone, isNot(table));
    expect(clone, new isInstanceOf<Table>());
    expect(clone.size, table.size);
    expect(clone.columns, equals(table.columns));
    expect(clone.data, equals(table.data));

  });

}
