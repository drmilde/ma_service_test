import 'package:flutter/material.dart';

import '../../services/ma_service.dart';
import '../../services/mabackend_service_provider.dart';
import '../../services/model/migraeneanfall.dart';
import 'migraenanfall_edit_screen.dart';

class MigraeneanfallListScreen extends StatefulWidget {
  const MigraeneanfallListScreen({Key? key}) : super(key: key);

  @override
  _MigraeneanfallListScreenState createState() =>
      _MigraeneanfallListScreenState();
}

class _MigraeneanfallListScreenState extends State<MigraeneanfallListScreen> {
  MAService service = MAService();
  List<Migraeneanfall> anfaelle = [];

  // Load to-do list from the server
  Future<bool> _loadUsers() async {
    anfaelle = await service.getMigraeneanfallList();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Anfallsliste"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Migraeneanfall anfall = Migraeneanfall(
              id: 0,
              datum: DateTime.now(),
              hasSymptome: [],
              lokalisation: "lokalisation",
              medikamente: "medikamente",
              schmerzen: "schmerzen",
              trigger: "trigger",
            );

            bool result =
                await MABackendServiceProvider.createObject<Migraeneanfall>(
              data: anfall,
              toJson: migraeneanfallToJson,
              resourcePath: "migraeneanfall.json",
            );

            setState(() {
              // update der Liste
            });
          },
          child: Text("add"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //_buildHeader(),
              SizedBox(
                height: 16,
              ),
              FutureBuilder<bool>(
                future: _loadUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _buildListView(snapshot);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildClearButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          anfaelle = [];
        });
      },
      child: Text("clear"),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
    );
  }

  Widget _buildListView(AsyncSnapshot<bool> snapshot) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: ListView.builder(
          itemCount: anfaelle.length,
          itemBuilder: (context, index) {
            final user = anfaelle[index];
            return _buildCard(user);
          },
        ),
      ),
    );
  }

  Widget _buildCard(Migraeneanfall anfall) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16),
      child: Stack(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 162, 219, 156),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text("${anfall.schmerzen} ${anfall.lokalisation}"),
              ),
            ),
          ),
          Container(
            height: 70,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () async {
                        bool result = await service.deleteMigraeneanfallById(
                            id: anfall.id);
                        setState(() {});
                      },
                      icon: Icon(Icons.delete_outline_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                MigraeneanfallEditScreen(id: anfall.id),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
