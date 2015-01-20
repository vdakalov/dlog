// Copyright (c) 2015, Viktor Dakalov. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:unittest/unittest.dart';
import 'package:dlog/dlog.dart';

main() {

  var json = JSON.decode('{"name": "Nikolay", "age": 21, "roles": ["admin", "developer"]}');

  test("Output", (){

    var debug = new Json(data: json, title: "Json simple"),
        output = [
          'Json simple',
          '{',
          '  name: "Nikolay",',
          '  age: 21,',
          '  roles: [',
          '    0: "admin",',
          '    1: "developer"',
          '  ]',
          '}', ''];

    expect(debug.toString(), output.join(debug.endOfLineUnicode));

  });

  test("Max string length", (){

    var debug = new Json(data: json, title: "Json simple"),
        output = [
          'Json simple',
          '{',
          '  name: "Nikol...",',
          '  age: 21,',
          '  roles: [',
          '    0: "admin",',
          '    1: "devel..."',
          '  ]',
          '}', ''];

    debug.maxStringLen = 5;

    expect(debug.toString(), output.join(debug.endOfLineUnicode));

  });

  test("Custom parser", (){

    var debug = new Json(data: json, title: "Json simple"),
        output = [
          'Json simple',
          '{',
          '  name: "Nikolay",',
          '  age: <int> 21,',
          '  roles: [',
          '    0: "admin",',
          '    1: "developer"',
          '  ]',
          '}', ''];

    debug.parsers["int"] = (int num) => "<int> $num" ;

    expect(debug.toString(), output.join(debug.endOfLineUnicode));

  });

}