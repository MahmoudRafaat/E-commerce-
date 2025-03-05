import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/user pages/Widget_offerbox.dart';
import 'package:untitled3/project2/pages/user pages/products.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';

class Home extends StatelessWidget {
  final int userId;
  const Home({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => Appdatabaselogic()..createDatabaseAndTable(),
        child: BlocConsumer<Appdatabaselogic, Appdatabasestate>(
            listener: (context, state) {},
            builder: (context, state) {
              Appdatabaselogic usersapplogic = BlocProvider.of(context);
              return Scaffold(
                  body: Container(
                      padding: EdgeInsets.all(10),
                      child: ListView(children: [
                        Offerbox(
                            offerText:
                                "Find your perfect match electronic product",
                            offerPercentage: "Shop Now"),
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide()),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return Products(product:usersapplogic.laptops,userId: userId,);
                                  },
                                ));
                              },
                              child: Text(
                                "Laptop",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orange[700],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide()),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {

                                    return Products(product:usersapplogic.phones,userId: userId,);
                                  },
                                ));
                              },
                              child: Text(
                                "Mobile",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orange[700],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide()),
                              onPressed: () {


                                Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {

              return Products(product:usersapplogic.tvs,userId: userId,);
              },
              ));
              },
                              child: Text(
                                "Smart TV",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orange[700],
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Best Sale",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                            itemCount: usersapplogic.products.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 5.0,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Image.file(
                                          File(usersapplogic.products[index]['product_url']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          usersapplogic.products[index]['name'],
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
                                          'Price: \$ ${usersapplogic.products[index]['price']}}',
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
                                                  usersapplogic.products[index]
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
                                                  usersapplogic.products[index]
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
                              );
                            })
                      ])));
            }));
  }
}
