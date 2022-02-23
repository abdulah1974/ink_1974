class Joke2 {

  late String username2;
  late String profile_photo2;
  Joke2({required this.username2,required this.profile_photo2 });

  Joke2.toObject(Map<String, dynamic> json){

    username2 = json['username'];
    profile_photo2=json["profile_photo"];
  }
}
