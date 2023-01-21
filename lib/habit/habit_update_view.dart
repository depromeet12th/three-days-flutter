import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../design/sub_title_text.dart';
import '../design/three_days_colors.dart';
import '../design/three_days_text_form_field.dart';
import '../design/time_selector_widget.dart';
import '../domain/day_of_week.dart';
import '../domain/habit.dart';
import '../domain/habit/habit_update_cubit.dart';
import '../domain/habit/habit_update_state.dart';
import '../domain/habit_color.dart';
import '../domain/habit_update_request_vo.dart';

class HabitUpdateView extends StatefulWidget {
  final Habit habit;

  const HabitUpdateView({
    super.key,
    required this.habit,
  });

  @override
  State<StatefulWidget> createState() {
    return _HabitUpdateViewState();
  }
}

class _HabitUpdateViewState extends State<HabitUpdateView> {
  /// 습관명 최대 글자수
  static const maxLengthOfTitle = 15;

  /// 알림 메시지 최대 글자수
  static const maxLengthOfNotificationContent = 20;

  bool pushAlarmEnabled = true;
  TimeOfDay? notificationTime;
  Set<DayOfWeek> dayOfWeeks = {
    DayOfWeek.monday,
    DayOfWeek.tuesday,
    DayOfWeek.wednesday,
  };
  late HabitUpdateRequestVo habitUpdateRequestVo;

  final habitTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    habitUpdateRequestVo = HabitUpdateRequestVo(
      emoji: '💙',
      title: widget.habit.title,
      dayOfWeeks: dayOfWeeks,
      notificationRequestVo: null,
      color: HabitColor.green,
    );
    habitTextEditingController.text = widget.habit.title;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return await _onWillPop();
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(73),
            child: AppBar(
              title: const Text('습관을 만들어 볼까요?'),
              centerTitle: true,
            ),
          ),
          body: BlocBuilder<HabitUpdateCubit, HabitUpdateState>(
            builder: (context, state) {
              if (state is HabitUpdateSuccessState) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop(state.habitId);
                });
              }
              if (state is HabitUpdateFailureState) {
                print(state);
              }
              return Column(
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

                  /// 습관 수정하기 버튼
                  _getUpdateHabitButton(
                    habitUpdateCubit:
                        BlocProvider.of<HabitUpdateCubit>(context),
                    habitUpdateState: state,
                  ),
                ],
              );
            },
          ),
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
              controller: habitTextEditingController,
              hintText: '어떤 습관을 원하시나요?',
              maxLength: maxLengthOfTitle,
              onChanged: (value) {
                setState(() {
                  habitUpdateRequestVo = habitUpdateRequestVo.copyOf(
                    title: habitTextEditingController.value.text,
                  );
                });
                BlocProvider.of<HabitUpdateCubit>(context)
                    .validate(habitUpdateRequestVo: habitUpdateRequestVo);
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
                      height: 40,
                      width: 40,
                      child: SizedBox(
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
                  value: pushAlarmEnabled,
                  onChanged: (value) {
                    setState(() {
                      pushAlarmEnabled = value;
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

  /// 습관 수정하기
  Widget _getUpdateHabitButton({
    required HabitUpdateCubit habitUpdateCubit,
    required HabitUpdateState habitUpdateState,
  }) {
    bool canSubmit = habitUpdateState is HabitUpdateReadyState;
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      child: ElevatedButton(
        onPressed: !canSubmit
            ? null
            : () {
                habitUpdateCubit.submit(
                  habitId: widget.habit.habitId,
                  habitUpdateRequestVo: habitUpdateRequestVo,
                );
                if (kDebugMode) {
                  print('updatedHabit: $habitUpdateRequestVo');
                }
                if (!mounted) {
                  return;
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: ThreeDaysColors.primary,
          minimumSize: const Size.fromHeight(50),
        ),
        child: const Text(
          '습관 수정하기',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Back'),
                content: const Text('Are you sure you want to go back?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            }) ??
        false);
  }
}
