import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:image_picker/image_picker.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';
import 'package:untitled3/project2/pages/AdminPages/adminHome.dart';

class Addproduct extends StatefulWidget {
  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  File? imageFile;
  bool check_image=true;// Declare a File variable to hold the selected image


  final ImagePicker _picker = ImagePicker(); // Initialize the image picker

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        check_image=false;
        imageFile = File(pickedFile.path); // Set the picked image to the imageFile variable
      });
    }
  }
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
                "Add Product",
                style: TextStyle(color: Colors.white),
              ),
        backgroundColor: Color.fromARGB(255, 247, 112, 71),
            ),
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  child: Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: imageFile != null
                                  ? FileImage(imageFile!)
                                  : null,
                              child: imageFile == null
                                  ? Icon(
                                Icons.camera_alt,
                                color: Color.fromARGB(255, 247, 112, 71),
                                size: 60,
                              )
                                  : null,
                            ),
                            ),
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
                        // Image picker widget
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: usersapplogic.price,
                            decoration: InputDecoration(
                              hintText: 'Price',
                              labelText: "Price",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: Icon(Icons.monetization_on_outlined),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: usersapplogic.description,
                            decoration: InputDecoration(
                              hintText: 'Description',
                              labelText: "Description",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: Icon(Icons.description),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 247, 112, 71),
                      fixedSize: Size(300, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: () {
                      if (usersapplogic.code.text.isEmpty ||
                          check_image ||
                          usersapplogic.name.text.isEmpty ||
                          usersapplogic.description.text.isEmpty ||
                          usersapplogic.price.text.isEmpty||
                          usersapplogic.category.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Empty Fields',
                                style: TextStyle(color: Colors.red),
                              ),
                              content: Text(
                                "Please fill the empty fields",
                                style: TextStyle(color: Colors.red),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        String imagePath = imageFile!.path;

                        usersapplogic.addProduct(
                          code: int.parse(usersapplogic.code.text),
                          name: usersapplogic.name.text,
                          price: int.parse(usersapplogic.price.text),
                          description: usersapplogic.description.text,
                          url: imagePath,
                          category: usersapplogic.category.text
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Added ${usersapplogic.name.text}',
                                style: TextStyle(color: Colors.green),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (b) {
                                          return Adminhome();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text('Add Product'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
