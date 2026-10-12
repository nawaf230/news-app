// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bookmark_cubit.dart';

class BookmarkState extends Equatable {
  const BookmarkState({
    this.bookmarksStatus = RequestStatusEnum.loading,
    this.bookmarks = const [],
    this.errorMessage,
  });

  final RequestStatusEnum bookmarksStatus;
  final List<BookmarkModel> bookmarks;
  final String? errorMessage;

  BookmarkState copyWith({
    RequestStatusEnum? bookmarksStatus,
    List<BookmarkModel>? bookmarks,
    String? errorMessage,
  }) {
    return BookmarkState(
      bookmarksStatus: bookmarksStatus ?? this.bookmarksStatus,
      bookmarks: bookmarks ?? this.bookmarks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [bookmarksStatus, bookmarks, errorMessage];
}
