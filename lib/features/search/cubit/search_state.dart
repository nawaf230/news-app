// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState({
    this.newsEverythingList = const [],
    this.everythingStatus = RequestStatusEnum.loading,
    this.everythingErrorMessage,
  });

  final List<NewsArticleModel> newsEverythingList;
  final RequestStatusEnum everythingStatus;
  final String? everythingErrorMessage;

  SearchState copyWith({
    List<NewsArticleModel>? newsEverythingList,
    RequestStatusEnum? everythingStatus,
    String? everythingErrorMessage,
  }) {
    return SearchState(
      newsEverythingList: newsEverythingList ?? this.newsEverythingList,
      everythingStatus: everythingStatus ?? this.everythingStatus,
      everythingErrorMessage: everythingErrorMessage ?? this.everythingErrorMessage,
    );
  }

  @override
  List<Object?> get props => [newsEverythingList, everythingStatus, everythingErrorMessage];
}
