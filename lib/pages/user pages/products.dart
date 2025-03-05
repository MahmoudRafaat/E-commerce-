import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/user pages/product_details.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';
import 'package:untitled3/project2/pages/user pages/color.dart';

class Products extends StatelessWidget {
  late int userId;
  late List product ;
  Products({required this.userId,required this.product});
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (context) => Appdatabaselogic()..createDatabaseAndTable(),
        child: BlocConsumer<Appdatabaselogic, Appdatabasestate>(
            listener: (context, state) {},
            builder: (context, state){
              Appdatabaselogic usersapplogic = BlocProvider.of(context);
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Products",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: AppColor.SecondPrimaryColor,
                ),
                body: Container(
                  padding: EdgeInsets.all(10),
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
                          itemCount: product.length  ,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return ProductDetails(product[index]);
                                  },
                                ));
                              },
                              child: Card(
                                elevation: 5.0,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Image.file(
                                          File(product[index]['product_url']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          product[index]['name'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          'Price: \$ ${product[index]['price']}}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                              icon: Icon(Icons
                                                  .favorite_border_outlined),
                                              onPressed: () {
                                                // Add to cart logic
                                                // Example user ID 1
                                                usersapplogic.addToFavorites(
                                                  userId,
                                                  product[index]
                                                  ['id'],
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      duration:
                                                      Duration(seconds: 2),
                                                      content: Text(
                                                          'Added to Favorite')),
                                                );
                                              }),
                                          IconButton(
                                              icon: Icon(Icons.shopping_cart),
                                              onPressed: () {
                                                // Add to Favorite
                                                // Example user ID 1
                                                usersapplogic.addToCart(
                                                  userId,
                                                  product[index]
                                                  ['id'],
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      duration:
                                                      Duration(seconds: 2),
                                                      content: Text(
                                                          'Added to Cart')),
                                                );
                                              })
                                        ],
                                      ),
                                    ]),
                              ),
                            );
                          }),

                    ],
                  ),
                ),
              );
            }));
  }
}
