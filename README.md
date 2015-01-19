# DLog

A useful library for output structured information of debugging into console

## Usage

A simple usage example:

    import "dart:math" as Math;
    import 'package:dlog/dlog.dart' as DLog;
    
    double rad(num deg) =>
      deg * (Math.PI / 180);
    
    main() {
    
      // create new table and specify number of columns
      var debug = new DLog.Table.fromHeader(
                  ["DEG°", "RADIAN", "NORMAL"]);
    
      // add more header
      debug.columns.addAll(["VECTOR (X, Y)"]);
    
      for (int angle = 0; angle < 360; angle++) {
        double x = 1 * Math.cos(rad(angle)),
               y = 1 * Math.sin(rad(angle)),
               normal = 1.0 * x + 0.0 * y;
    
        // add row (count of cell eq debug.columns.length)
        debug.data.addAll([angle, rad(angle), normal, [x,y]]);
      }
    
      var pi = debug.clone().crop(0, 180),
          pi2 = debug.clone().crop(180, 180);
    
      // output to console
      print(debug);
    
      // output range 0-179
      print(pi);
    
      // output range 180-359
      print(pi2);
    
    }

Result:

    ┌───────┬─────────┬─────────┬─────────┬──────────────────┐
    │ DEG°  │ RADIAN  │ NORMAL  │ NRAD    │ VECTOR (X, Y)    │
    ├───────┼─────────┼─────────┼─────────┼──────────────────┤
    │   0   │  0.0000 │  1.0000 │  0.0000 │  1.0000,  0.0000 │
    ├───────┼─────────┼─────────┼─────────┼──────────────────┤
    │   1   │  0.0175 │  0.9998 │  0.0175 │  0.9998,  0.0175 │
    ├───────┼─────────┼─────────┼─────────┼──────────────────┤
    │   2   │  0.0349 │  0.9994 │  0.0349 │  0.9994,  0.0349 │
    ├───────┼─────────┼─────────┼─────────┼──────────────────┤
    │   3   │  0.0524 │  0.9986 │  0.0524 │  0.9986,  0.0523 │
    ├───────┼─────────┼─────────┼─────────┼──────────────────┤
    │   4   │  0.0698 │  0.9976 │  0.0698 │  0.9976,  0.0698 │
    ├───────┼─────────┼─────────┼─────────┼──────────────────┤
    │   5   │  0.0873 │  0.9962 │  0.0873 │  0.9962,  0.0872 │
    ├───────┼─────────┼─────────┼─────────┼──────────────────┤
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    │ 357   │  0.0524 │  0.9986 │  0.0524 │  0.9986, -0.0523 │
    ├───────┼─────────┼─────────┼─────────┼──────────────────┤
    │ 358   │  0.0349 │  0.9994 │  0.0349 │  0.9994, -0.0349 │
    ├───────┼─────────┼─────────┼─────────┼──────────────────┤
    │ 359   │  0.0175 │  0.9998 │  0.0175 │  0.9998, -0.0175 │
    └───────┴─────────┴─────────┴─────────┴──────────────────┘

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/vdakalov/DLog
