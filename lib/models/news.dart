class NewsModel {
  String? id;
  String? title;
  String? about;
  String? category;
  String? link;

  NewsModel({
    this.id,
    this.title,
    this.about,
    this.category,
    this.link,
  });

  factory NewsModel.fromMap(Map<String, dynamic> data) => NewsModel(
        id: data['id'],
        title: data['title'],
        about: data['about'],
        category: data['category'],
        link: data['link'],
      );
}
