class NewsModel {
  String status;
  int totalResults;
  List<Article> articles;
  NewsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsModel.fromJson(Map<String, dynamic> map) {
    return NewsModel(
      status: map['status'] ?? "",
      totalResults: map['totalResults'] ?? -1,
      articles: map["articles"] == null
          ? []
          : List<Article>.from(
              map["articles"]!.map((x) => Article.fromJson(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'totalResults': totalResults,
      'articles': articles.map((x) => x.toMap()).toList(),
    };
  }
}

class Article {
  Source source;
  String? author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;
  Article({
    required this.source,
    this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> map) {
    return Article(
      source: Source.fromJson(map['source']),
      author: map['author'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      url: map['url'] ?? "",
      urlToImage: map['urlToImage'] ?? "",
      publishedAt: DateTime.parse(map['publishedAt']),
      content: map['content'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'source': source.toMap(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.millisecondsSinceEpoch,
      'content': content,
    };
  }
}

class Source {
  String? id;
  String? name;
  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> map) {
    return Source(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }
}
