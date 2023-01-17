import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_days/mypage/mypage_page.dart';

import '../bottom_navigation/cubit/navigation_cubit.dart';
import '../habit/habit_page.dart';
import '../history/history_page.dart';
import '../mate/mate_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            if (state.item == ThreeDaysNavigationBarItem.habit) {
              return HabitPage();
            }
            if (state.item == ThreeDaysNavigationBarItem.history) {
              return HistoryPage();
            }
            if (state.item == ThreeDaysNavigationBarItem.mate) {
              return MatePage();
            }
            if (state.item == ThreeDaysNavigationBarItem.mypage) {
              return MyPagePage();
            }
            return Container();
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state.index,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history,
                  ),
                  label: 'history',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.abc,
                  ),
                  label: 'mate',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_box,
                  ),
                  label: 'mypage',
                ),
              ],
              onTap: (index) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(ThreeDaysNavigationBarItem.values[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
