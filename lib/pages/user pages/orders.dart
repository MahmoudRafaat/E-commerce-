import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';

class Orders extends StatelessWidget {
late int userId;
Orders(this.userId);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => Appdatabaselogic()..createDatabaseAndTables(userId),
        child: BlocConsumer<Appdatabaselogic, Appdatabasestate>(
            listener: (context, state) {},
            builder: (context, state) {
              Appdatabaselogic usersapplogic = BlocProvider.of(context);
    return Scaffold(
    body: ListView.builder(
    itemCount: usersapplogic.orders.length,
    itemBuilder: (context, index) {
    final order = usersapplogic.orders[index];
    return ExpansionTile(
    title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Order ID: ${order['id']}',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    ),
    ),
    SizedBox(height: 4),
    Text(
    'Total Price: \$${order['total_price']}',
    style: TextStyle(
    fontSize: 14,
    ),
    ),
    ],
    ),
    );
    })
    );
            }));
  }
}
