class NewsArticleModel {
  final String author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
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
      urlToImage: map['urlToImage'],
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
}
