class Article {
  final String title;
  final String description;
  final String imageUrl;
  final String content;
  final String sourceName;
  final String url;

  Article({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
    required this.sourceName,
    required this.url,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      imageUrl: json['urlToImage'] ?? 'https://via.placeholder.com/150',
      content: json['content'] ?? 'No Content',
      sourceName: json['source']['name'] ?? 'Unknown Source',
      url: json['url'] ?? '',
    );
  }

  // Renamed the getters to avoid conflict
  String get imageUrlOrDefault => imageUrl.isNotEmpty ? imageUrl : 'https://via.placeholder.com/150';

  String get sourceNameOrDefault => sourceName.isNotEmpty ? sourceName : 'Unknown Source';

  String get urlOrDefault => url.isNotEmpty ? url : '#';

  // Modified the getter to provide a valid URL or a fallback
  String get urlToImage => imageUrl.isNotEmpty ? imageUrl : 'https://via.placeholder.com/150';  // Ensure this returns a valid URL
}