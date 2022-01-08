class Photo {
  final String title;
  final String thumbnailUrl;
  Photo._({required this.title, required this.thumbnailUrl});
  factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo._(
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}