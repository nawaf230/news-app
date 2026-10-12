import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/bookmark/data/bookmark_repository.dart';
import 'package:news_app/features/bookmark/models/bookmark_model.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkState()) {
    loadBookmarks();
  }

  final BookmarkRepository _repository = BookmarkRepository();

  /// Load all bookmarks from repository
  void loadBookmarks() {
    try {
      emit(state.copyWith(bookmarksStatus: RequestStatusEnum.loading));
      emit(
        state.copyWith(
          bookmarks: _repository.getBookmarks(),
          bookmarksStatus: RequestStatusEnum.loaded,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(bookmarksStatus: RequestStatusEnum.error, errorMessage: e.toString()));
    }
  }

  /// Toggle bookmark status for an article
  /// Returns true if article was added to bookmarks, false if removed
  Future<bool> toggleBookmark(NewsArticleModel article) async {
    try {
      final wasAdded = await _repository.toggleBookmark(article);

      // Reload bookmarks to update UI
      loadBookmarks();

      return wasAdded;
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
      return false;
    }
  }

  /// Add a bookmark
  Future<void> addBookmark(NewsArticleModel article) async {
    try {
      await _repository.addBookmark(article);
      loadBookmarks();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  /// Remove a bookmark by URL
  Future<void> removeBookmark(String articleUrl) async {
    try {
      await _repository.removeBookmark(articleUrl);
      loadBookmarks();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  /// Check if an article is bookmarked
  bool isArticleBookmarked(String? articleUrl) {
    return _repository.isBookmarked(articleUrl);
  }

  /// Get total bookmark count
  int get bookmarkCount => _repository.getBookmarkCount();

  /// Clear all bookmarks with confirmation
  Future<void> clearAllBookmarks() async {
    try {
      await _repository.clearAllBookmarks();
      loadBookmarks();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  /// Convert bookmark to article for navigation
  NewsArticleModel getArticleFromBookmark(BookmarkModel bookmark) {
    return _repository.bookmarkToArticle(bookmark);
  }

  /// Refresh bookmarks (for pull-to-refresh)
  Future<void> refresh() async {
    loadBookmarks();
  }

  /// Get bookmarks as articles for easier UI rendering
  List<NewsArticleModel> get bookmarksAsArticles {
    return state.bookmarks.map((bookmark) => _repository.bookmarkToArticle(bookmark)).toList();
  }
}
