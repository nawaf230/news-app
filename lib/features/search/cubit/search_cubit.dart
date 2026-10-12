import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.newsRepository) : super(SearchState());

  final BaseNewsRepository newsRepository;
  final TextEditingController searchController = TextEditingController();

  Future<void> getEverything() async {
    try {
      final newsEverythingList = await newsRepository.getEverything(query: searchController.text);

      emit(
        state.copyWith(
          newsEverythingList: newsEverythingList,
          everythingStatus: RequestStatusEnum.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          everythingErrorMessage: e.toString(),
          everythingStatus: RequestStatusEnum.error,
        ),
      );
    }
  }
}
