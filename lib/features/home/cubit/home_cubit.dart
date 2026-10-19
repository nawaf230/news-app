import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.newsRepository) : super(HomeState()) {
    getEverything();
    getTopHeadLine();
  }

  final BaseNewsRepository newsRepository;

  Future<void> getTopHeadLine({String? categories}) async {
    emit(state.copyWith(topHeadLineStatus: RequestStatusEnum.loading));

    try {
      final articles = await newsRepository.getTopHeadLine(
        selectedCategory: state.selectedCategory,
      );
      emit(
        state.copyWith(newsTopHeadLineList: articles, topHeadLineStatus: RequestStatusEnum.loaded),
      );
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          topHeadLineErrorMessage: e.toString().substring(11),
          topHeadLineStatus: RequestStatusEnum.error,
        ),
      );
    }
  }

  Future<void> getEverything() async {
    try {
      final articles = await newsRepository.getEverything();
      emit(
        state.copyWith(newsEverythingList: articles, everythingStatus: RequestStatusEnum.loaded),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          everythingErrorMessage: e.toString().substring(11),
          everythingStatus: RequestStatusEnum.error,
        ),
      );
    }
  }

  void updateSelectedCategory(String category) {
    emit(state.copyWith(selectedCategory: category));

    getTopHeadLine(categories: state.selectedCategory);
  }
}
