# DLog

A useful library for output structured information of debugging into console

## Usage

A simple usage example:

    import 'package:DLog/log.dart' as DLog;

    main() {
      
      // create new table and specify number of columns
      var debug = new DLog.Table.fromHeader(
                  ["DEG°", "RADIAN", "NORMAL"]);
      
      // add more header
      //debug.columns.addAll(["NRAD", "VECTOR (X, Y)"]);
      
      for (int angle = 0; angle < 360; angle++) {
        double x = 1 * Math.sin(angle),
               y = 1 * Math.cos(angle),
               normal = getNormal(1.0, 0.0, x, y);
      
        // add row (count of cell eq debug.columns.length)
        debug.data.addAll([angle, angle*(Math.PI/180), normal, [x,y]]);
      }
      
      var pi = debug.clone().crop(0, 179),
          pi2 = debug.clone().crop(180, 359);
      
      // output to console
      print(debug);
      print(pi);
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
