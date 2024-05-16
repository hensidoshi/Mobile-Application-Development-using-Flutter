import 'package:flutter/material.dart';
import 'package:database_crud1/database.dart';
import 'package:database_crud1/database_ui.dart';

class add_edit extends StatefulWidget {
  add_edit({super.key, this.map});

  Map? map;

  @override
  State<add_edit> createState() => add_editState();
}

class add_editState extends State<add_edit> {

  MyDatabase db = MyDatabase();
  var idcontroller = TextEditingController();
  var namecontroller = TextEditingController();

  void initState() {
    super.initState();
    idcontroller.text = widget.map?['id'] == null ? "" : widget.map!['id'];
    namecontroller.text = widget.map?['name'] == null ? "" : widget.map!['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: idcontroller,
                decoration: InputDecoration(
                  labelText: "Enter Id",
                  labelStyle: TextStyle(fontSize: 17),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                  labelText: "Enter Name",
                  labelStyle: TextStyle(fontSize: 17),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            OutlinedButton(onPressed: () async{
              if(widget.map == null){
                await db.insertfaculty(id: idcontroller.text, name: namecontroller.text)
                    .then((value) => Navigator.pop(context));
              }
              else{
                await db.updatefaculty(id:widget.map!['id'], name: namecontroller.text)
                    .then((value) => Navigator.pop(context));
              }
            },
                child:Text("Submit",style:TextStyle(fontSize: 17)))
          ],
        ),
      ),
    );
  }
}
