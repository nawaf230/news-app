class NewsArticleModel {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  NewsArticleModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsArticleModel.formJson(Map<String, dynamic> map) {
    return NewsArticleModel(
      author: map['author'] ?? 'author Not Found',
      title: map['title'] ?? 'title Not Found',
      description: map['description'] ?? 'description Not Found',
      url: map['url'] ?? 'url Not Found',
      urlToImage: map['urlToImage'] ?? 'urlToImage Not Found',
      publishedAt: DateTime.tryParse(map['publishedAt']) ?? DateTime.now(),
      content: map['content'] ?? 'content Not Found',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  @override
  String toString() {
    return 'NewsArticleModel('
        'author: $author, '
        'title: $title, '
        'description: $description, '
        'url: $url, '
        'urlToImage: $urlToImage, '
        'publishedAt: $publishedAt, '
        'content: $content'
        ')';
  }

  /// TODO : Refactor
  String formatDateTime() {
    final diff = DateTime.now().difference(publishedAt);

    if (diff.inSeconds < 60) {
      return '${diff.inMinutes}s ago';
    }
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    }
    if (diff.inDays < 30) {
      return '${diff.inDays}d ago';
    }
    return '${diff.inDays ~/ 30}mo ago';
  }
}
