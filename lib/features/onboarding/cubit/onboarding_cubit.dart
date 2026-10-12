import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState());

  void setCurrentIndex(int index) {
    if (index == 2) {
      emit(state.copyWith(currentIndex: index, isLastPage: true));
    } else {
      emit(state.copyWith(currentIndex: index, isLastPage: false));
    }
  }
}
