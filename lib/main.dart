import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PetList(),
    ));

class PetList extends StatelessWidget {
  PetList({Key? key}) : super(key: key);

  var petDetails;

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
      var p = jsonDecode(response.body);
      petDetails = Pet(p["id"], p["name"], p["category"].toString(), p["image"],
          p["verbose_category"], p["age"], p["is_rented"]);
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
              return Column(
                children: [
                  Center(child: CircularProgressIndicator()),
                  ElevatedButton(
                      onPressed: (() {
                        showDialog(
                            context: context,
                            builder: (context) {
                              print(context);
                              return AlertDialog(
                                title: Text("DIALOG BOX"),
                                content: Text("This is content"),
                                actions: [
                                  TextButton(
                                    child: Text('Close'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      }),
                      child: Text("CLICK ME"))
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    color: Color.fromARGB(255, 241, 241, 97),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(snapshot.data[index].imageUrl),
                        title: Text(
                          snapshot.data[index].name.toString().toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(snapshot.data[index].verboseCategory),
                        onTap: (() {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Text(
                                        petDetails.name
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                      SizedBox(
                                        width: 165,
                                      ),
                                      IconButton(
                                          onPressed: (() {
                                            Navigator.of(context).pop();
                                          }),
                                          icon: Icon(Icons.cancel)),
                                    ],
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.network(petDetails.imageUrl),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Name"),
                                              SizedBox(
                                                width: 120,
                                              ),
                                              Text(petDetails.name
                                                  .toString()
                                                  .toUpperCase())
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(children: [
                                        Text("Category"),
                                        SizedBox(
                                          width: 100,
                                        ),
                                        Text(petDetails.verboseCategory
                                            .toString())
                                      ]),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text("Is Rented ?"),
                                          SizedBox(
                                            width: 90,
                                          ),
                                          petDetails.isRented
                                              ? Tab(
                                                  icon: Icon(
                                                  Icons.visibility_off_rounded,
                                                  color: Colors.red,
                                                ))
                                              : Tab(
                                                  icon: Icon(
                                                  Icons.visibility_rounded,
                                                  color: Colors.green,
                                                ))
                                        ],
                                      )
                                    ],
                                  ),
                                  // actions: [
                                  //   TextButton(
                                  //     child: Text('Close'),
                                  //     onPressed: () {
                                  //       Navigator.of(context).pop();
                                  //     },
                                  //   ),
                                  // ],
                                );
                              });
                          getPetDetails(snapshot.data[index].id);
                          // getPetDetail(index);
                        }),
                      ),
                    ),
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
