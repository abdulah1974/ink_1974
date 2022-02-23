
class Joke {

 late String username;
 late String profile_photo;
  Joke({ required this.username,required this.profile_photo});

  Joke.toObject(Map<String, dynamic> json){

    username = json['username'];
    profile_photo = json['profile_photo'];
  }
}