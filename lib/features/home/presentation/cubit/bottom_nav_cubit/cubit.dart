import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ntg_task/features/home/presentation/cubit/bottom_nav_cubit/states.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavInitial());

  void updateIndex(int newIndex) {
    if (newIndex != state.currentIndex) {
      emit(BottomNavChanged(newIndex));
    }
  }
}