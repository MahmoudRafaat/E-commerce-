
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages//Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';

import 'adminHome.dart';

class Updateproduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   BlocProvider(create:(context)=> Appdatabaselogic()..createDatabaseAndTable(),
        child: BlocConsumer<Appdatabaselogic,Appdatabasestate>(
        listener:(context,state){} ,
    builder:(context,state){
    Appdatabaselogic usersapplogic=BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Page",style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 247, 112, 71),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [

          Form(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Enter the code of product",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                ),
                Center(
                  child: Container(
                    height: 70,
                    width: 100,
                    child: TextFormField(
                      controller: usersapplogic.id,
                      decoration: InputDecoration(
                        labelText: "ID",
                        hintText: 'ID',
                        suffixIcon: Icon(Icons.perm_identity_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),

                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                        style:ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 247, 112, 71),
                            fixedSize: Size(150, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0))),
                        onPressed: (){
                          for(int i=0;i<usersapplogic.products.length;i++)
                            usersapplogic.showProductDetails();






                        }, child: Text("Search")

                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0,left: 8),
                  child: Text("Information",style: TextStyle(color: Color.fromARGB(255, 247, 112, 71),fontWeight: FontWeight.bold,fontSize: 20),),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: usersapplogic.name,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: "Name",
                      suffixIcon: Icon(Icons.supervised_user_circle),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: usersapplogic.code,
                    decoration: InputDecoration(
                      labelText: "Code",
                      hintText: 'Code',
                      suffixIcon: Icon(Icons.qr_code),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: usersapplogic.category,
                    decoration: InputDecoration(
                      hintText: 'Category',
                      labelText: "Category",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: Icon(Icons.category),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(

                    controller:usersapplogic.imageUrl ,
                    decoration: InputDecoration(
                        hintText: 'Image URL',
                        labelText: "Image URL",

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        suffixIcon: Icon(Icons.image)
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(

                    controller:usersapplogic.price ,
                    decoration: InputDecoration(
                        hintText: 'Price',
                        labelText: "Price",

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        suffixIcon: Icon(Icons.monetization_on_outlined)
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(

                    controller:usersapplogic.description ,
                    decoration: InputDecoration(
                        hintText: 'Description',
                        labelText: "Description",

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        suffixIcon: Icon(Icons.description)
                    ),

                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style:ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 247, 112, 71),
                  fixedSize: Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )

              ),

              onPressed: () {
                if(usersapplogic.imageUrl.text==""||usersapplogic.code.text==""||usersapplogic.name.text=="")
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return  AlertDialog(
                        title: Text('Empty Fields',style: TextStyle(color: Colors.red),),
                        content: Text(
                          "Please fill the empty fields",style: TextStyle(color: Colors.red),),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );},
                  );
                else{
                  usersapplogic.updateProduct(category: usersapplogic.category.text,code: int.parse(usersapplogic.code.text), name: usersapplogic.name.text, price: int.parse(usersapplogic.price.text), description: usersapplogic.description.text, url: usersapplogic.imageUrl.text);


                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                              'Updated', style: TextStyle(color: Colors.green)),

                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (b){
                                  return Adminhome();
                                }));


                              },
                            ),
                          ],
                        );

                      });
                }

              },
              child: Text('Update'),


            ),
          ),


        ],
      ),
    );
  }));}
}
/*
* */
