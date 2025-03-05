import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';
import 'favouraite_page.dart';
import 'cart_page.dart'; // Import your Cart Page

class ProductListPage extends StatelessWidget {
  late int userid;
  ProductListPage(this.userid);
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
              backgroundColor: Colors.blue,
              actions: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    print(userid);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage(userid)),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavouraitePage(userid)),
                    );
                  },
                ),
              ],
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: usersapplogic.products.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: usersapplogic.products.length,
                      itemBuilder: (context, index) {
                        final product = usersapplogic.products[index];
                        return Card(
                          elevation: 5.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Image.file(
                                File(product['product_url']),
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product['name'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Price: \$${product['price']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.shopping_cart),
                                    onPressed: () {
                                      // Add to cart logic
                                      usersapplogic.addToCart(userid, product['id']); // Example user ID 1
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Added to cart')),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.favorite_border),
                                    onPressed: () {
                                      // Add to favorites logic
                                      usersapplogic.addToFavorites(userid, product['id']); // Example user ID 1
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Added to favorites')),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          );
        },
      ),
    );
  }
}
