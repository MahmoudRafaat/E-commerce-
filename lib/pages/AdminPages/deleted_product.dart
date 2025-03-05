import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';

class DeleteAllProducts extends StatelessWidget {
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
              backgroundColor: Color.fromARGB(255, 247, 112, 71),
              title: Text('Delete All Products'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Are you sure you want to delete all Products?',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      usersapplogic.deleteAllProducts();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('All Products deleted successfully')),
                      );
                      Navigator.pop(context); // Go back to the previous page after deletion
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      fixedSize: Size(250, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: Text(
                      'Delete All Products',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
