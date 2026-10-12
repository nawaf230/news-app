// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  const OnboardingState({this.currentIndex = 0, this.isLastPage = false});

  final int currentIndex;
  final bool isLastPage;

  OnboardingState copyWith({int? currentIndex, bool? isLastPage}) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  List<Object> get props => [currentIndex, isLastPage];
}
