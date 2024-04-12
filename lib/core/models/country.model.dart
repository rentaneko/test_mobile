class Country {
  String? title;
  String? imgUrl;
  String? createdDate;
  String? description;
  String? name;

  Country({
    this.title,
    this.imgUrl,
    this.createdDate,
    this.description,
    this.name,
  });

  Country.fromJson(Map<String, dynamic> json) {
    title = json['title'] == null ? '' : json['title'] as String;
    imgUrl = json['urlToImage'] == null ? '' : json['urlToImage'] as String;
    createdDate =
        json['publishedAt'] == null ? '' : json['publishedAt'] as String;
    description =
        json['description'] == null ? '' : json['description'] as String;
    name =
        json['source']['name'] == null ? '' : json['source']['name'] as String;
  }
}
