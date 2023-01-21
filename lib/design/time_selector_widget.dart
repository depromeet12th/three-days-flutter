import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:three_days/util/extensions.dart';

class TimeSelectorWidget extends StatelessWidget {
  const TimeSelectorWidget({
    super.key,
    required this.visible,
    this.onTabInside,
    this.timeOfDay,
  });

  final bool visible;
  final TapRegionCallback? onTabInside;
  final TimeOfDay? timeOfDay;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: TapRegion(
        onTapInside: onTabInside,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color.fromRGBO(0xF9, 0xFA, 0xFB, 1.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text(
              timeOfDay?.let((it) => _getFormattedTime(it)) ?? '시간을 선택해주세요',
              style: TextStyle(
                color: timeOfDay != null
                    ? const Color.fromRGBO(0x75, 0x75, 0x75, 1.0)
                    : const Color.fromRGBO(0xC5, 0xC5, 0xC5, 1.0),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getFormattedTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('aa H시 mm분').format(dateTime);
  }
}
