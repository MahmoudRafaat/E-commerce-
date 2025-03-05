import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/user pages/product_details.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';

class Cart extends StatelessWidget {
  late int userid;
  Cart(this.userid);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => Appdatabaselogic()..createDatabaseAndTables(userid),
        child: BlocConsumer<Appdatabaselogic, Appdatabasestate>(
            listener: (context, state) {},
            builder: (context, state) {
              Appdatabaselogic usersapplogic = BlocProvider.of(context);
              double totalPrice = 0;
              for (var product in usersapplogic.cartProducts) {
                totalPrice += product['price'];
              }
              return Scaffold(
                body: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Products in Cart',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: usersapplogic.cartProducts.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return ProductDetails(usersapplogic.cartProducts[index]);
                                  },
                                ));
                              },
                              child: Card(
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Image.file(
                                          File(usersapplogic.cartProducts[index]['product_url']),
                                          fit: BoxFit.cover,
                                          height: 200,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              usersapplogic.cartProducts[index]['name'],
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Price: \$ ${usersapplogic.cartProducts[index]['price']}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                int productId = (usersapplogic.cartProducts[index]['id']);
                                                usersapplogic.deleteProductFromCart(userid, productId);
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
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Price: \$ $totalPrice',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {

                             usersapplogic.placeOrder(userid,totalPrice);



                            },
                            child: Text('Place Order'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}