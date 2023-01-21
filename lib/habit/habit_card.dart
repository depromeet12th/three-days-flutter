import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_days/domain/habit_repository.dart';

import '../domain/habit.dart';

class HabitCard extends StatefulWidget {
  final Habit habit;
  final void Function(BuildContext context, Habit habit) onKebabMenuPressed;

  HabitCard({
    super.key,
    required this.habit,
    required this.onKebabMenuPressed,
  });

  @override
  State<StatefulWidget> createState() {
    return _HabitCardState();
  }
}

class _HabitCardState extends State<HabitCard> {
  late int countOfHistories;
  late int focusedIndex;
  late bool hasCheckedAtToday;


  @override
  void initState() {
    super.initState();
    countOfHistories = 0;
    focusedIndex = 0;
    hasCheckedAtToday = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: IconButton(
              onPressed: () {
                widget.onKebabMenuPressed.call(context, widget.habit);
              },
              icon: const Icon(
                Icons.more_vert,
                color: Color.fromRGBO(0xA6, 0xA6, 0xA6, 1.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🎯'),
                    SizedBox(width: 6),
                    Text(
                      widget.habit.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_alarm_outlined),
                    SizedBox(
                      width: 7,
                    ),
                    Text('5개'),
                    SizedBox(
                      width: 10,
                    ),
                    Text('|'),
                    SizedBox(
                      width: 10,
                    ),
                    Text('월,수,금'),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _clapWidget(
                      context: context,
                      checked: widget.habit
                          .isChecked(0, focusedIndex, hasCheckedAtToday),
                      focused: 0 == focusedIndex,
                      sequence: 1,
                    ),
                    SizedBox(width: 16),
                    _clapWidget(
                      context: context,
                      checked: widget.habit
                          .isChecked(1, focusedIndex, hasCheckedAtToday),
                      focused: 1 == focusedIndex,
                      sequence: 2,
                    ),
                    SizedBox(width: 16),
                    _clapWidget(
                      context: context,
                      checked: widget.habit
                          .isChecked(2, focusedIndex, hasCheckedAtToday),
                      focused: 2 == focusedIndex,
                      sequence: 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// checked: 오늘꺼 체크 했는지
  /// focused: 오늘껀지
  Widget _clapWidget({
    required BuildContext context,
    required bool checked,
    required int sequence,
    bool focused = false,
  }) {
    final habitRepository = RepositoryProvider.of<HabitRepository>(context);
    final primary = Color(0xFF34C185);
    final backgroundColor = checked ? primary : Color(0xFFDFF5EC);
    return GestureDetector(
      onTapUp: (details) async {
        if (!focused) {
          return;
        }
        // final isChecked = await widget.habitService.isCheckedDateAt(
        //   widget.habit.habitId,
        //   DateTime.now(),
        // );
        final isChecked = false;
        if (isChecked) {
          // await widget.habitService.uncheck(widget.habit);
        } else {
          // final clap = await widget.habitService.check(widget.habit);
          final clap = null;
          if (clap != null) {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                titlePadding: const EdgeInsets.only(top: 40),
                title: const Text(
                  '짝심삼일 완료!',
                  textAlign: TextAlign.center,
                ),
                content: const Text(
                  '3일동안 목표를 달성한 나를 위해\n박수를 쳐주세요. 짝짝짝!',
                  textAlign: TextAlign.center,
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 56,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('잘했어요'),
                  ),
                ],
              ),
            );
          }
        }
        // final count = await widget.habitService.countHistories(habit.habitId);
        final count = 1;
        setState(() {
          countOfHistories = count;
          hasCheckedAtToday = !hasCheckedAtToday;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: !hasCheckedAtToday && focused
              ? SizedBox(
                  width: 34,
                  height: 34,
                  child: Center(
                    child: Text(
                      sequence.toString(),
                      style: TextStyle(
                        color: primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              : Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 34.0,
                ),
        ),
      ),
    );
  }
}
