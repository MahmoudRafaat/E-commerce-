import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';
import 'package:untitled3/project2/pages/user pages//color.dart';

class ProductDetails extends StatelessWidget {
Map product={};
ProductDetails(this.product);
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
                    "Product Details",
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
                      Text(
                       product['name'],
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black)),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.file(
                                File(product['product_url']),
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${product['price']} USD",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Overview",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                              product['description'],
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
