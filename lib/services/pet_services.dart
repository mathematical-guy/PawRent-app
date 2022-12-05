import 'package:http/http.dart';
import 'package:pawrent_app/services/api_constants.dart';
import '../models/pet.dart';
import 'dart:convert';
import '../models/pet.dart';

class PetService {
  APIConstants api = APIConstants();
  HttpConstants httpConstants = HttpConstants();

  Future<List<Pet>> getPetListService() async {
    List<Pet> pets = [];
    var url = api.baseUrl + api.petListUrl;
    url = "http://10.0.2.2:8000/app/pet-list/";
    Response response = await get(Uri.parse(url));
    if (response.statusCode == httpConstants.successStatusCode) {
      List pet_list = jsonDecode(response.body);
      for (var i = 0; i < pet_list.length; i++) {
        Pet p = Pet.fromJson(pet_list[i]);
        pets.add(p);
      }
      return pets;
    } else {
      return [];
    }
  }

  // Future<List<Pet>> getPosts() async {
  //   Response res = await get(Uri.parse("uri"));

  //   if (res.statusCode == 200) {
  //     List<dynamic> body = jsonDecode(res.body);

  //     List<Pet> posts = body
  //       .map(
  //         (dynamic item) => Pet.fromJson(item),
  //       )
  //       .toList();

  //     return posts;
  //   } else {
  //     throw "Unable to retrieve posts.";
  //   }
  // }

}
