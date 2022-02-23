import 'dart:convert';
import 'package:http/http.dart' as http;
import 'joke.dart';
import 'joke2.dart';
class JokeRepository {
  String url="http://192.168.100.42:3080/getfollowing?account_id=2";
  Future<List<Joke>> getJokes() async {

    var res = await http.get(Uri.parse("http://192.168.100.42:3000/getlike2?user_id=2"));
    var json = jsonDecode(res.body) as List;
    var jokes  = json.map((joke) => Joke.toObject(joke)).toList();


    return jokes;
  }
  Future<List<Joke2>> getJokes2() async {

    var res = await http.get(Uri.parse("http://192.168.100.42:3000/getfollowing?account_id=2"));
    var json = jsonDecode(res.body) as List;
    var jokes  = json.map((joke2) => Joke2.toObject(joke2)).toList();
    return jokes;
  }
}
