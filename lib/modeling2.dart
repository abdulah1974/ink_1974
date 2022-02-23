class modeiling2 {

  final String username;
  final String profile_photo;

  const modeiling2({
    required this.username,
    required this.profile_photo,
  });

  factory modeiling2.fromJson(Map<String, dynamic> json) {
    return modeiling2(
      username: json['username'],
      profile_photo: json['profile_photo'],
    );
  }


}