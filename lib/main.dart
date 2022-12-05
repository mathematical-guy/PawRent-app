import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PetList(),
    ));

class PetList extends StatelessWidget {
  PetList({Key? key}) : super(key: key);

  Future getPets() async {
    List<Pet> pets = [];
    // http.get(Uri.https(authority, unencodedPath))
    var response =
        await http.get(Uri.parse("http://10.0.2.2:8000/app/pet-list/"));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      for (var p in jsonData) {
        Pet pet = Pet(p["id"], p["name"], p["category"].toString(), p["image"],
            p["verbose_category"], p["age"], p["is_rented"]);
        pets.add(pet);
      }
      return pets;
    }
  }

  getPetDetails(id) async {
    String url = "http://10.0.2.2:8000/app/pet/$id/";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(jsonData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset('assets/paw.jpg', scale: 8),
              SizedBox(
                width: 8,
              ),
              Text(
                "Paw Rent",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontStyle: FontStyle.italic),
              ),
              IconButton(
                onPressed: (() {
                  getPets();
                }),
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              )
            ],
          ),
          backgroundColor: Color.fromARGB(255, 144, 119, 43),
        ),
        body: Container(
            child: FutureBuilder(
          future: getPets(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: Image.network(snapshot.data[index].imageUrl),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].verboseCategory),
                    onTap: (() {
                      print(snapshot.data[index].name);
                      getPetDetails(snapshot.data[index].id);
                      // getPetDetail(index);
                    }),
                  );
                }),
              );
            }
          },
        )));
  }
}

class Pet {
  String name, category, imageUrl, verboseCategory;
  int id, age;
  bool isRented;
  Pet(this.id, this.name, this.category, this.imageUrl, this.verboseCategory,
      this.age, this.isRented);
}
