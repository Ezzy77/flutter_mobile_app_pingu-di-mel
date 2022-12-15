import 'package:flutter/material.dart';
import 'package:pingu_di_mel/database/coqueiro_model.dart';

import '../database/Database.dart';

class CoqueiroList extends StatefulWidget {
  const CoqueiroList({Key? key}) : super(key: key);

  @override
  State<CoqueiroList> createState() => _CoqueiroListState();
}

class _CoqueiroListState extends State<CoqueiroList> {

  late DataBase handler;
  Future<int> addCoqueiros() async {
    Coqueiros firstPlanet =
    Coqueiros(id: 1,firstName: "Elisio", lastName: "Sa");
    Coqueiros secondPlanet =
    Coqueiros(id: 2,firstName: "Ju", lastName: "Sanca");
    Coqueiros thirdPlanet =
    Coqueiros(id: 3, firstName: "Urien", lastName: "Santos");
    Coqueiros fourthPlanet =
    Coqueiros(id: 4, firstName: "Kevin", lastName: "Sovetas");

    List<Coqueiros> coqueiros = [firstPlanet, secondPlanet,thirdPlanet,fourthPlanet];
    return await handler.insertCoqueiro(coqueiros);
  }

  @override
  void initState() {
    super.initState();
    handler = DataBase();
    handler.initializedDB().whenComplete(() async {
      await addCoqueiros();
      setState(() {});
    });
  }


  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FutureBuilder(
        future: handler.retrieveCoqueiros(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Coqueiros>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Text(snapshot.data![index].firstName),
                    subtitle: Text(snapshot.data![index].id.toString()),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
