import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:three_days/auth/unauthorized_exception.dart';
import 'package:three_days/domain/habit/habit_repository.dart';

import '../domain/habit/habit.dart';
import '../domain/habit/habit_status.dart';
import 'habit_card.dart';

class HabitListView extends StatefulWidget {
  const HabitListView({super.key});

  @override
  State<StatefulWidget> createState() => _HabitListViewState();
}

class _HabitListViewState extends State<HabitListView> {
  late int? createdHabitId;
  late int? updatedHabitId;
  late int? deletedHabitId;

  @override
  void initState() {
    super.initState();
    createdHabitId = null;
    updatedHabitId = null;
    deletedHabitId = null;
  }

  @override
  Widget build(BuildContext context) {
    final habitRepository = RepositoryProvider.of<HabitRepository>(context);
    return FutureBuilder<List<Habit>>(
      future: habitRepository.findByStatus(habitStatus: HabitStatus.active),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return _getLoading();
        }
        if (snapshot.hasError) {
          if (snapshot.error is UnauthorizedException) {
            if (kDebugMode) {
              print(snapshot.error.toString());
            }
            return _getLoading();
          }
          return Center(child: Text(snapshot.error.toString()));
        }
        final habits = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              _getHeader(),
              SizedBox(
                height: 4,
              ),
              _getBody(context, habits),
            ],
          ),
        );
      },
    );
  }

  Widget _getLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _getHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        children: [
          Text('1월 2일 월요일'),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }

  Widget _getBody(BuildContext context, List<Habit> habits) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              runSpacing: 16.0,
              children: habits.map((e) => _getHabitCard(context, e)).toList(),
            ),
            _getAddHabitCard(context),
          ],
        ),
      ),
    );
  }

  Widget _getHabitCard(BuildContext context, Habit habit) {
    return HabitCard(
      habit: habit,
      onKebabMenuPressed: _showModalBottomSheet,
    );
  }

  Widget _getAddHabitCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTapUp: (_) async {
          final habitId =
              await Navigator.of(context).pushNamed('/habit/add') as int?;
          if (habitId != null) {
            setState(() {
              createdHabitId = habitId;
            });
          }
        },
        child: SizedBox(
          height: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              Text('습관 만들기'),
            ],
          ),
        ),
      ),
    );
  }

  /// habit_widget 에서 호출하는 콜백 메서드.
  /// 업데이트 / 삭제하고나서 목록을 갱신하기 위해 사용함
  void _showModalBottomSheet(BuildContext context, Habit habit) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        final habitRepository = RepositoryProvider.of<HabitRepository>(context);
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: SvgPicture.asset(
                    'images/icon_pencil.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
                title: const Text(
                  '수정하기',
                  style: TextStyle(
                    color: Color.fromRGBO(0x73, 0x73, 0x73, 1.0),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () async {
                  await Navigator.of(context).pushNamed('/habit/${habit.habitId}/edit');
                  if (!mounted) {
                    return;
                  }
                  Navigator.of(context).pop(HabitActionType.edit);
                },
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: SvgPicture.asset(
                    'images/icon_bin.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
                title: const Text(
                  '삭제하기',
                  style: TextStyle(
                    color: Color.fromRGBO(0x73, 0x73, 0x73, 1.0),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  showDialog<DeleteActionType>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      titlePadding: const EdgeInsets.only(top: 40),
                      title: const Text(
                        '정말 삭제하시겠어요?',
                        textAlign: TextAlign.center,
                      ),
                      content: const Text(
                        '목표를 삭제하게되면\n히스토리까지 모두 삭제되며 복구되지 않아요',
                        textAlign: TextAlign.center,
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color.fromRGBO(0xEF, 0xEF, 0xEF, 1.0),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => Navigator.of(context)
                              .pop(DeleteActionType.cancel),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            child: Text(
                              '그냥 둘게요',
                              style: TextStyle(
                                color: Color.fromRGBO(0x77, 0x77, 0x77, 1.0),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pop(DeleteActionType.delete),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            child: Text('삭제할게요'),
                          ),
                        ),
                      ],
                      insetPadding: const EdgeInsets.symmetric(vertical: 28),
                    ),
                  ).then((value) async {
                    if (value != null && value == DeleteActionType.delete) {
                      await habitRepository.delete(habitId: habit.habitId);
                      if (!mounted) {
                        return;
                      }
                      Navigator.of(context).pop(HabitActionType.delete);
                    } else {
                      Navigator.of(context).pop();
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    ).then((value) {
      HabitActionType? result = value as HabitActionType?;
      if (result == null) {
        return;
      }
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(
                  Icons.check,
                  color: Color(0xff00ae5A),
                ),
                Text(
                    '짝심목표가 ${result == HabitActionType.edit ? '수정' : '삭제'}되었어요'),
              ],
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      if (result == HabitActionType.delete) {
        setState(() {
        });
      }
    });
  }
}

enum HabitActionType {
  edit,
  delete,
}

enum DeleteActionType {
  delete,
  cancel,
}
