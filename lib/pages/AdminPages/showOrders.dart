import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';
class Showorders extends StatelessWidget {

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
                    "orders",
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
                        'Orders',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 247, 112, 71),
                        ),
                      ),
                    ),
                    (usersapplogic.allOrders.length > 0)
                        ? Column(
                      children: [
                        for (int i = 0; i < usersapplogic.allOrders.length; i++)
                          ListTile(
                            leading: CircleAvatar(
                            child: Text(usersapplogic.allOrders[i]['id'].toString()),)  ,
                            title: Text("order ${usersapplogic.allOrders[i]['id']} for user ${usersapplogic.allOrders[i]['user_id']} "),
                            trailing: Text("total price:${usersapplogic.allOrders[i]["total_price"]}USD",style: TextStyle( fontSize: 13),)
                          ),


                      ],
                    )
                        : Center(
                      child: ElevatedButton(onPressed:(){
                        print(usersapplogic.getAllOrders());

                      },  child: Text("Show users"),
                      ),
                    ),
                  ],
                ),
              );
            } ));}
}
