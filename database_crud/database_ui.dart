import 'package:database_crud1/add_edit.dart';
import 'package:flutter/material.dart';
import 'package:database_crud1/database.dart';

class database_ui extends StatefulWidget {
  const database_ui({super.key});

  @override
  State<database_ui> createState() => _database_uiState();
}

class _database_uiState extends State<database_ui> {
  MyDatabase db = MyDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Database Demo")),
      body: FutureBuilder(
        future: db.copyPasteAssetFileToRoot(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.hasData);
            return FutureBuilder(
              future: db.getDataFromfaculty(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.hasData);
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            color: Colors.white,
                            elevation: 2.0,
                            child: Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "ID:-${snapshot.data![index]["id"].toString()}",
                                          style: TextStyle(fontSize: 22)),
                                      Text(
                                          "NAME:-${snapshot.data![index]["name"].toString()}",
                                          style: TextStyle(fontSize: 22)),
                                    ]),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return add_edit(
                                          map: snapshot.data![index],
                                        );
                                      },
                                    )).then((value) {
                                      setState(() {});
                                    });
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Delete Data",
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            content: Text(
                                                "Are You Sure You Want To Delete This Data?",
                                                style: TextStyle(fontSize: 17)),
                                            actions: [
                                              TextButton(
                                                onPressed: () async {
                                                  await db
                                                      .deletefaculty(snapshot
                                                      .data![index]['id'])
                                                      .then((value) {Navigator.pop(context);});
                                                  setState(() {});
                                                },
                                                child: Text("Yes"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("No"),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(Icons.delete))
                            ]),
                          ),
                        );
                      });
                } else {
                  return Text("NO Data Found");
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return add_edit();
            },
          )).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
