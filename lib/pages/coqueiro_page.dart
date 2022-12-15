import 'package:flutter/material.dart';
import '../database/Database.dart';

class CoqueiroList extends StatefulWidget {
  const CoqueiroList({Key? key}) : super(key: key);

  @override
  State<CoqueiroList> createState() => _CoqueiroListState();
}

class _CoqueiroListState extends State<CoqueiroList> {
  List<Map<String, dynamic>> _journals= [];

  bool _isLoading = true;

  void _refreshJournals() async{
    final data = await DatabaseHelper.getCoqueiros();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  // late DataBase handler;
  // Future<int> addCoqueiros() async {
  //   Coqueiros firstPlanet =
  //   Coqueiros(id: 1,firstName: "Elisio", lastName: "Sa");
  //   Coqueiros secondPlanet =
  //   Coqueiros(id: 2,firstName: "Ju", lastName: "Sanca");
  //   Coqueiros thirdPlanet =
  //   Coqueiros(id: 3, firstName: "Urien", lastName: "Santos");
  //   Coqueiros fourthPlanet =
  //   Coqueiros(id: 4, firstName: "Kevin", lastName: "Sovetas");
  //
  //   List<Coqueiros> coqueiros = [firstPlanet, secondPlanet,thirdPlanet,fourthPlanet];
  //   return await handler.insertCoqueiro(coqueiros);
  // }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
    print('...number of coqueiros: ${_journals.length}');
  }

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();


  Future<void> _addCoqueiro() async{
    await DatabaseHelper.createCoqueiro(
        _firstNameController.text, _lastNameController.text);
    _refreshJournals();
    print('...number of coqueiros: ${_journals.length}');
  }

  Future<void> _updateCoqueiro(int id) async{
    await DatabaseHelper.updateCoqueiro(id,
        _firstNameController.text, _lastNameController.text);
    _refreshJournals();
  }


  // delete coqueiro
  void _deleteCoqueiro(int id ) async{
    await DatabaseHelper.deleteCoqueiro(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Item deleted successfully'),
    ));
    _refreshJournals();
  }

  void _showForm(int? id) async {
    if(id != null){
      final existingJournal =
          _journals.firstWhere((element) => element['id']==id);
      _firstNameController.text = existingJournal['firstName'];
      _lastNameController.text = existingJournal['lastName'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_)=> Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            // this prevent the soft keybord from covering text field
            bottom: MediaQuery.of(context).viewInsets.bottom +400,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(hintText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(hintText: 'Last name'),
              ),
              const SizedBox(
            height: 10,
        ),
              ElevatedButton(
                  onPressed: () async{
                    if(id == null){
                      await _addCoqueiro();
                    }

                    if(id != null){
                      await _updateCoqueiro(id);
                    }
                    // clear the text fields
                    _firstNameController.text = '';
                    _lastNameController.text = '';
                    // close the bottom sheet
                    Navigator.of(context).pop();
                  },
                  child: Text(id == null? 'Create New' : 'Update'),
              )
              
            ],
          ),
        ));
  }


  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: ()=>_showForm(null),
      ),
      body: ListView.builder(
          itemCount: _journals.length,
          itemBuilder: (context, index)=> Card(
            color: Colors.grey,
            margin: const EdgeInsets.all(5),
            child: ListTile(
              leading: Text(_journals[index]['dateAdded']),
              title: Text(_journals[index]['firstName']),
              subtitle: Text(_journals[index]['lastName']),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: ()=>_showForm(_journals[index]['id']),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: ()=>_deleteCoqueiro(_journals[index]['id']),
                    )
                  ],
                ),
              ),
            ),
          ),
      )
    );
  }
}
