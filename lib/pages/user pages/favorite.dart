import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';

class Favorite extends StatelessWidget {
  final int userId;
  const Favorite({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => Appdatabaselogic()..createDatabaseAndTables(userId),
        child: BlocConsumer<Appdatabaselogic, Appdatabasestate>(
            listener: (context, state) {},
            builder: (context, state) {
              Appdatabaselogic usersapplogic = BlocProvider.of(context);
              return Scaffold(
                body: Container(
                  padding: EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: usersapplogic.favProducts.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5.0,
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Image.file(
                                        File(usersapplogic.favProducts[index]['product_url']),
                                        fit: BoxFit.cover,
                                        height: 200,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              usersapplogic.favProducts[index]['name'],
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Price: \$ ${usersapplogic.favProducts[index]['price']}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        int productId = (usersapplogic.favProducts[index]['id']);
                                        // Call the deleteProductFromFavorites function
                                        usersapplogic.deleteProductFromFavorites(userId,productId);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Remove",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                            );
                          }),
                    ],
                  ),
                ),
              );
            }));
  }
}
