import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';


class DeleteDatabase extends StatelessWidget {
  const DeleteDatabase({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => Appdatabaselogic()..createDatabaseAndTable(),
        child: BlocConsumer<Appdatabaselogic, Appdatabasestate>(
            listener: (context, state) {},
            builder: (context, state) {
              Appdatabaselogic usersapplogic = BlocProvider.of(context);
              return Scaffold(
                body: Center(
                  child: MaterialButton(
                    color: Colors.yellow,
                    onPressed: () {
                      usersapplogic.delteDatabase();
                    },child: Text("delete",style: TextStyle(fontSize: 30,color: Colors.red),),
                  ),
                ),
              );
            }));
  }
}
