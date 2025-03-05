import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';
class Showusers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create:(context)=> Appdatabaselogic()..createDatabaseAndTable(),
        child: BlocConsumer<Appdatabaselogic,Appdatabasestate>(
        listener:(context,state){} ,
    builder:(context,state){
      Appdatabaselogic usersapplogic=BlocProvider.of(context);
  return Scaffold(
    appBar: AppBar(
      title: Text(
        "Users",
        style: TextStyle(color: Colors.white),
      ),
        backgroundColor: Color.fromARGB(255, 247, 112, 71),
    ),
    backgroundColor: Colors.white,
    body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Users',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 247, 112, 71),
            ),
          ),
        ),
        (usersapplogic.users.length > 0)
            ? Column(
          children: [
            for (int i = 0; i < usersapplogic.users.length; i++)
              ListTile(
leading: CircleAvatar(
  backgroundImage: FileImage(File(usersapplogic.users[i]["url"].toString())),
)  ,              title: Text(usersapplogic.users[i]["name"]),
                subtitle: Text(usersapplogic.users[i]["email"]),
              ),


          ],
        )
            : Center(
          child: ElevatedButton(onPressed:(){
            usersapplogic.createDatabaseAndTable();

          },  child: Text("Show users"),
          ),
        ),
      ],
    ),
  );
       } ));}
}
