class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        source: Source.fromJson(json['source']),
        author: json['author'] ?? "null",
        title: json['title'] ?? "null",
        description: json['description'] ?? "null",
        url: json['url'] ?? "null",
        urlToImage: json['urlToImage'] ??
            "https://www.balitbangham.go.id/po-content/po-upload/news-default.jpg",
        publishedAt: json['publishedAt'] ?? "null",
        content: json['content'] ?? "null");
  }
}

class Source {
  String? id;
  String? name;
  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['id'], name: json['name']);
  }
}
