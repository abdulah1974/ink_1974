
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'models/JokeRepository.dart';
import 'models/joke.dart';
import 'models/joke2.dart';

class JokeController extends GetxController {
  var allJokes = <Joke>[].obs;
  var allJokes2 = <Joke2>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;

  var repo = JokeRepository();


  @override
  void onInit() {
    getJokes();
    getJokes2();

    ever(isError, (value) {
      if(value == isError(true)) {
        Get.snackbar("problem", "issues in your internet connection",
            backgroundColor: Colors.black, colorText: Colors.white );
      }
    });
    super.onInit();


  }



  getJokes() async {
    try {
      isLoading(true);
      var jokes = await repo.getJokes();

      if(jokes != null) {
        allJokes.value = jokes;
      }

    }catch(e) {
      isError(true);
    }finally {
      isLoading(false);
    }
  }
  getJokes2() async {
    try {
      isLoading(true);

      var joke= await repo.getJokes2();
      if(joke != null) {
        allJokes2.value = joke;
      }
    }catch(e) {
      isError(true);
    }finally {
      isLoading(false);
    }
  }
}



