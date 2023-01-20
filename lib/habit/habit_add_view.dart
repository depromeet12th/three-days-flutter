import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_days/domain/habit_repository.dart';

import '../design/sub_title_text.dart';
import '../design/three_days_colors.dart';
import '../design/three_days_text_form_field.dart';
import '../design/time_selector_widget.dart';
import '../domain/day_of_week.dart';
import '../domain/habit.dart';
import '../domain/habit_color.dart';

class HabitAddView extends StatefulWidget {
  const HabitAddView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HabitAddViewState();
  }
}

class _HabitAddViewState extends State<HabitAddView> {
  static const maxLengthOfTitle = 15;
  static const maxLengthOfNotificationContent = 20;

  bool dateRangeEnabled = true;
  bool timeRangeEnabled = true;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TimeOfDay? remindTime;
  TimeOfDay? notificationTime;
  bool canSubmit = false;

  final goalTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final habitRepository = RepositoryProvider.of<HabitRepository>(context);
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
                        final goal = await habitRepository.save(
                          Habit(
                            title: goalTextEditingController.value.text,
                          ),
                        );
                        if (kDebugMode) {
                          print('createdGoal: $goal');
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
                  '습관 만들기',
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
              '습관을 만들어 볼까요?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 35,
            ),

            /// 습관 이름
            const ThreeDaysSubTitleText(data: '습관명'),
            ThreeDaysTextFormField(
              controller: goalTextEditingController,
              hintText: '어떤 습관을 원하시나요?',
              maxLength: maxLengthOfTitle,
              onChanged: (value) {
                setState(() {
                  canSubmit = value.isNotEmpty;
                });
              },
            ),
            const SizedBox(height: 25),

            /// 실천 요일
            ThreeDaysSubTitleText(data: '실천 요일(최소 3일 이상)'),
            Wrap(
              spacing: 7.0,
              children: DayOfWeek.values
                  .map(
                    (e) => Container(
                      color: ThreeDaysColors.grey100,
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Center(
                            child: Text(e.getDisplayName()),
                          )),
                    ),
                  )
                  .toList(),
            ),

            /// 푸시 알림
            Row(
              children: [
                const ThreeDaysSubTitleText(data: '푸시 알림'),
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
              maxLength: maxLengthOfNotificationContent,
            ),

            /// 색상
            ThreeDaysSubTitleText(data: '색상'),
            Container(
              height: 40,
              child: GridView.count(
                childAspectRatio: 2.5,
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                children: HabitColor.values
                    .map(
                      (e) => Container(
                        color: e.getColor(),
                        child: Icon(
                          Icons.check,
                          color: ThreeDaysColors.white,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
