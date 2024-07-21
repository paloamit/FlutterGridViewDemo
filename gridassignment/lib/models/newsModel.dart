class NewsModel {
    final String uuid;
    final String title;
    final String description;
    final String imageURL;

    const NewsModel({
    required this.uuid,
    required this.title,
    required this.description,
    required this.imageURL,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      uuid: json['uuid'],
      title: json['title'],
      description: json['description'],
      imageURL: json['image_url'],
    );
  }
}