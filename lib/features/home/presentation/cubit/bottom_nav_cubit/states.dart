abstract class BottomNavState {
  final int currentIndex;

  const BottomNavState(this.currentIndex);
}

class BottomNavInitial extends BottomNavState {
  const BottomNavInitial() : super(0);
}

class BottomNavChanged extends BottomNavState {
  const BottomNavChanged(int index) : super(index);
}