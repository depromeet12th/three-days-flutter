import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:three_days/design/three_days_colors.dart';
import 'package:three_days/domain/habit/habit.dart';
import 'package:three_days/domain/habit/habit_repository.dart';
import 'package:three_days/ui/form/sub_title_text.dart';
import 'package:three_days/ui/form/three_days_date_range_field.dart';
import 'package:three_days/ui/form/three_days_text_form_field.dart';
import 'package:three_days/ui/form/time_selector_widget.dart';

class HabitEditPage extends StatefulWidget {
  HabitEditPage({
    super.key,
    required this.habit,
  });

  final Habit habit;
  final HabitRepository habitRepository = HabitRepository();

  @override
  State<StatefulWidget> createState() => _HabitEditPageState();
}

class _HabitEditPageState extends State<HabitEditPage> {
  final habitTextEditingController = TextEditingController();
  late bool dateRangeEnabled;
  late bool timeRangeEnabled;
  late DateTime startDate;
  late DateTime endDate;
  TimeOfDay? notificationTime;
  TimeOfDay? remindTime;
  late bool canSubmit;

  @override
  void initState() {
    super.initState();
    dateRangeEnabled = true;
    timeRangeEnabled = true;
    startDate = DateTime.now();
    endDate = DateTime.now();
    habitTextEditingController.text = widget.habit.title;
    canSubmit = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [

            /// 닫기 버튼
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Expanded(
              child: _getFormWidgets(context),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              child: ElevatedButton(
                onPressed: !canSubmit
                    ? null
                    : () async {
                  widget.habit.update(
                      title: habitTextEditingController.value.text);
                  final habit =
                  await widget.habitRepository.save(widget.habit);
                  if (kDebugMode) {
                    print('updatedHabit: $habit');
                  }
                  if (!mounted) {
                    return;
                  }
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/habit/list',
                        (route) => route.settings.name == '/habit/list',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThreeDaysColors.primary,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  '저장',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getFormWidgets(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '짝심목표 수정하기',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 35,
            ),

            /// 목표
            const ThreeDaysSubTitleText(data: '목표'),
            ThreeDaysTextFormField(
              controller: habitTextEditingController,
              hintText: '짝심목표를 알려주세요',
              maxLength: 15,
              onChanged: (value) {
                setState(() {
                  canSubmit = value.isNotEmpty;
                });
              },
            ),
            const SizedBox(height: 25),

            /// 목표 기간
            Row(
              children: [
                const ThreeDaysSubTitleText(data: '목표 기간'),
                const Spacer(),
                Switch(
                  value: dateRangeEnabled,
                  onChanged: (value) {
                    setState(() {
                      dateRangeEnabled = value;
                    });
                  },
                )
              ],
            ),
            ThreeDaysDateRangeField(
              visible: dateRangeEnabled,
              startDate: startDate,
              endDate: endDate,
              onTapUp: (_) async {
                final dateTimeRange = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now().subtract(const Duration(days: 36500)),
                  lastDate: DateTime.now().add(const Duration(days: 36500)),
                  currentDate: DateTime.now(),
                  builder: (context, Widget? child) => Theme(
                    data: Theme.of(context).copyWith(
                      appBarTheme: Theme.of(context).appBarTheme.copyWith(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    child: child!,
                  ),
                );
                if (kDebugMode) {
                  print('dateTimeRange: $dateTimeRange');
                }
                if (dateTimeRange != null) {
                  setState(() {
                    startDate = dateTimeRange.start;
                    endDate = dateTimeRange.end;
                  });
                }
              },
            ),

            /// 수행 시간
            Row(
              children: [
                const ThreeDaysSubTitleText(data: '수행 시간'),
                const Spacer(),
                Switch(
                  value: timeRangeEnabled,
                  onChanged: (value) {
                    setState(() {
                      timeRangeEnabled = value;
                    });
                  },
                ),
              ],
            ),
            TimeSelectorWidget(
              visible: timeRangeEnabled,
              onTabInside: (event) async {
                var pickedTime = await showTimePicker(
                  context: context,
                  initialTime: const TimeOfDay(hour: 8, minute: 0),
                );
                setState(() {
                  remindTime = pickedTime;
                  if (kDebugMode) {
                    print(remindTime);
                  }
                });
              },
              timeOfDay: remindTime,
            ),
            const SizedBox(height: 25),

            /// Push 알림 설정
            const ThreeDaysSubTitleText(data: 'Push 알림 설정'),
            const SizedBox(
              height: 5,
            ),
            TimeSelectorWidget(
              visible: true,
              onTabInside: (event) async {
                var pickedTime = await showTimePicker(
                  context: context,
                  initialTime: const TimeOfDay(hour: 8, minute: 0),
                );
                setState(() {
                  notificationTime = pickedTime;
                  if (kDebugMode) {
                    print(notificationTime);
                  }
                });
              },
              timeOfDay: notificationTime,
            ),
            const ThreeDaysTextFormField(
              hintText: 'Push 알림 내용을 입력해주세요',
              maxLength: 20,
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedDate(DateTime dateTime) {
    return DateFormat('yyyy. MM. dd.').format(dateTime);
  }
}
