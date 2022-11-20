import 'package:http/http.dart';
import 'package:pawrent_app/services/api_constants.dart';
import '../models/pet.dart';
import 'dart:convert';
import '../models/pet.dart';

class PetService {
  APIConstants api = APIConstants();

  dynamic getPetListService() async {
    var url = api.baseUrl + api.petListUrl;
    url = "http://10.0.2.2:8000/app/pet-list/";
    var response = await get(Uri.parse(url));
    if (response.statusCode == HttpConstants().successStatusCode) {
      List<Pet> pets = [];
      for (var element in jsonDecode(response.body)) {
        var value = Pet.fromJson(element);
        pets.add(value);
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
