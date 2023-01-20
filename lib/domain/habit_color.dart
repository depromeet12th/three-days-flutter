import 'dart:ui';

import 'package:three_days/design/three_days_colors.dart';

enum HabitColor {
  green,
  blue,
  pink,
  ;

  Color getColor() {
    switch(this) {
      case HabitColor.green:
        return ThreeDaysColors.green50;
      case HabitColor.blue:
        return ThreeDaysColors.blue50;
      case HabitColor.pink:
        return ThreeDaysColors.pink50;
    }
  }
}
