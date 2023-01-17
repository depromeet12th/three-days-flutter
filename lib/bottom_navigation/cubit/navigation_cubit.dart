import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_bar_item.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.initial());

  void getNavBarItem(ThreeDaysNavigationBarItem item) {
    emit(NavigationState.from(item));
  }
}
