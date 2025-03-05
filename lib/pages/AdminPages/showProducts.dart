import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';
class Showproducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Appdatabaselogic()..createDatabaseAndTable(),
      child: BlocConsumer<Appdatabaselogic, Appdatabasestate>(
        listener: (context, state) {},
        builder: (context, state) {
          Appdatabaselogic usersapplogic = BlocProvider.of(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Products",
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
                    'Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 247, 112, 71),
                    ),
                  ),
                ),
                usersapplogic.products.isNotEmpty
                    ? Column(
                        children: [
                          for (int i = 0; i < usersapplogic.products.length; i++)
                            Card(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.file(
                                      File(usersapplogic.products[i]['product_url']),
                                      width: 350,
                                      height: 350,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text("Product code: ${usersapplogic.products[i]['id'].toString()}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("Product name: ${usersapplogic.products[i]['name']}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Price: ${usersapplogic.products[i]['price']}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
