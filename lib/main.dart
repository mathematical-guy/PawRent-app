import 'package:flutter/material.dart';
import './services/pet_services.dart';

void main() => runApp(MaterialApp(
      home: PetListWidget(),
    ));

class Home extends StatelessWidget {
  PetService petservice = PetService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paw Rent"),
      ),
    );
  }
}

class PetListWidget extends StatefulWidget {
  const PetListWidget({Key? key}) : super(key: key);

  @override
  State<PetListWidget> createState() => _PetListWidgetState();
}

class _PetListWidgetState extends State<PetListWidget> {
  PetService petservice = PetService();
  var pets = [];

  @override
  void initState() {
    super.initState();
    // pets = petservice.getPetListService();
    print("Called");
    print(pets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [Icon(Icons.home), Text("Paw Rent")],
          ),
        ),
        body: Center(
          child: Container(
              child: pets.length < 1
                  ? Loading()
                  : Container(
                      child: Text("Got the Data"),
                    )),
        ));
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
      child: Icon(Icons.home, size: 120),
      onPressed: (() {}),
    ));
  }
}
