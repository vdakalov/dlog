# log

A library for Dart developers. It is awesome.

## Usage

A simple usage example:

    import 'package:DLog/log.dart' as DLog;

    main() {
      
      // create new table and specify number of columns
      var debug = new DLog.Table(4);
      
      // add header
      debug.data.addAll(["deg", "rad", "normal", "vector"]);
      
      for (int angle = 0; angle < 360; angle++) {
        double x = 1 * Math.sin(angle),
               y = 1 * Math.cos(angle),
               normal = getNormal(1.0, 0.0, x, y);
      
        // add row
        debug.data.addAll([angle, angle*(Math.PI/180), normal, [x,y]]);
      }
      
      var pi = debug.clone().crop(0, 179),
          pi2 = debug.clone().crop(180, 359);
      
      // output to console
      print(debug);
      print(pi);
      print(pi2);
      
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
