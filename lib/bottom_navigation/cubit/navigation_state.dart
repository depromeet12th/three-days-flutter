part of 'navigation_cubit.dart';

class NavigationState implements Equatable {
  final ThreeDaysNavigationBarItem item;
  final int index;

  const NavigationState(this.item, this.index);

  static NavigationState from(ThreeDaysNavigationBarItem item) {
    return NavigationState(item, item.index);
  }

  static NavigationState initial() {
    final item = ThreeDaysNavigationBarItem.values.first;
    return NavigationState(item, item.index);
  }

  @override
  List<Object?> get props => [item, index];

  @override
  bool? get stringify => true;
}
