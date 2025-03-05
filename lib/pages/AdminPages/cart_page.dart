import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';
class CartPage extends StatelessWidget {
  late int userid;
  CartPage(this.userid);
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create:(context)=> Appdatabaselogic()..createDatabaseAndTables(userid),
        child: BlocConsumer<Appdatabaselogic,Appdatabasestate>(
        listener:(context,state){} ,
    builder:(context,state){
    Appdatabaselogic usersapplogic=BlocProvider.of(context);
    return Scaffold(

        body: BlocBuilder<Appdatabaselogic, Appdatabasestate>(
          builder: (context, state) {
            return FutureBuilder<List<Map<String, dynamic>>>(
              future: usersapplogic.getCartProducts(userid), // Example user ID 1
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return Center(child: Text("No items in the cart"));
                }

                return ListView.builder(

                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                   // usersapplogic.product_id=item['product_id'];
                  //  usersapplogic.showProductsDetails();
                    print(item);

                    return ListTile(

                      //subtitle: Text("${usersapplogic.product_name}"),

                        title: Text("Product ID: ${item['product_id']}"),
                    );
                  },
                );
              },
            );
          },
        ),
    );
  }));
}
}