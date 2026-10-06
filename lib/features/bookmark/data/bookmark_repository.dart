import 'package:hive_ce_flutter/adapters.dart';
import 'package:news_app/core/constants/storage_key.dart';
import 'package:news_app/features/bookmark/models/bookmark_model.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class BookmarkRepository {
  static final _instance = BookmarkRepository._internal();

  BookmarkRepository._internal();

  factory BookmarkRepository() {
    return _instance;
  }

  Box<BookmarkModel>? _bookmarkBox;

  Box<BookmarkModel> get bookmarkBox {
    if (_bookmarkBox == null) {
      throw Exception('BookmarkRepository not initialized');
    }

    return _bookmarkBox!;
  }

  // Initialization

  Future<void> init() async {
    _bookmarkBox = await Hive.openBox(StorageKey.bookmark);
  }

  // Create / Delete

  Future<void> addBookmark(NewsArticleModel article) async {
    final bookmark = articleToBookmark(article);

    await bookmarkBox.put(bookmark.url, bookmark);
  }

  Future<void> removeBookmark(String url) async {
    await bookmarkBox.delete(url);
  }

  /// Clear all bookmarks
  Future<void> clearAllBookmarks() async {
    await bookmarkBox.clear();
  }

  // Read / Query

  BookmarkModel? getBookmark(String articleUrl) {
    return bookmarkBox.get(articleUrl);
  }

  List<BookmarkModel> getBookmarks() {
    return bookmarkBox.values.toList();
  }

  /// Get total count of bookmarks
  int getBookmarkCount() {
    return bookmarkBox.length;
  }

  bool isBookmarked(String? articleUrl) {
    if (articleUrl == null || articleUrl.isEmpty) return false;

    return bookmarkBox.containsKey(articleUrl);
  }

  /// Toggle bookmark status (add if not exists, remove if exists)
  /// Returns true if bookmark was added, false if removed
  Future<bool> toggleBookmark(NewsArticleModel article) async {
    if (isBookmarked(article.url)) {
      await removeBookmark(article.url);
      return false;
    } else {
      await addBookmark(article);
      return true;
    }
  }

  /// Search bookmarks by title or description
  List<BookmarkModel> searchBookmarks(String query) {
    if (query.isEmpty) return getBookmarks();

    final lowercaseQuery = query.toLowerCase();

    return bookmarkBox.values.where((bookmark) {
      final titleMatch = bookmark.title.toLowerCase().contains(lowercaseQuery);
      final descriptionMatch =
          bookmark.description?.toLowerCase().contains(lowercaseQuery) ?? false;
      final authorMatch = bookmark.author?.toLowerCase().contains(lowercaseQuery) ?? false;

      return titleMatch || descriptionMatch || authorMatch;
    }).toList()..sort((a, b) => b.bookmarkedAt.compareTo(a.bookmarkedAt));
  }

  // Converters

  /// Convert NewsArticleModel to BookmarkModel
  BookmarkModel articleToBookmark(NewsArticleModel article) {
    return BookmarkModel(
      author: article.author,
      title: article.title,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
      bookmarkedAt: DateTime.now(),
    );
  }

  /// Convert BookmarkModel to NewsArticleModel
  NewsArticleModel bookmarkToArticle(BookmarkModel bookmark) {
    return NewsArticleModel(
      author: bookmark.author ?? '',
      title: bookmark.title,
      description: bookmark.description ?? '',
      url: bookmark.url,
      urlToImage: bookmark.urlToImage,
      publishedAt: bookmark.publishedAt,
      content: bookmark.content ?? '',
    );
  }
}
