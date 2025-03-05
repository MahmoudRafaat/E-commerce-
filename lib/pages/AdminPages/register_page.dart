import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/user pages/store.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  File? imageFile; // Declare a File variable to hold the selected image
late int id;

  final ImagePicker _picker = ImagePicker(); // Initialize the image picker

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path); // Set the picked image to the imageFile variable
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Appdatabaselogic()..createDatabaseAndTable(),
      child: BlocConsumer<Appdatabaselogic, Appdatabasestate>(
        listener: (context, state) {
          // Handle state changes if needed
        },
        builder: (context, state) {
          Appdatabaselogic usersapplogic = BlocProvider.of(context);

          return Scaffold(
            body: Stack(
              children: [
                Opacity(
                  opacity: 0.9,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/images/background_image_2.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: imageFile != null
                                  ? FileImage(File(imageFile!.path))
                                  : null,
                              child: imageFile == null
                                  ? Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 60,
                                    )
                                  : null,
                            ),
                          ),
                          SizedBox(height: 20),
                          _buildTextField(
                            controller: nameController,
                            hintText: 'Name',
                            icon: Icons.person,
                          ),
                          _buildTextField(
                            controller: emailController,
                            hintText: 'Email',
                            icon: Icons.email,
                          ),
                          _buildTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            icon: Icons.lock_outline_rounded,
                            obscureText: true,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (nameController.text.isNotEmpty &&
                                  emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty &&
                                  imageFile != null) {
                                // Convert the image file path to a string URL or save it locally and store the path
                                String imagePath = imageFile!.path;

                                // Proceed with registration
                               await usersapplogic.insertUser(
                                  name: nameController.text,
                                  email: emailController.text,
                                  pass: passwordController.text,
                                  url: imagePath, // Pass the image path as the URL
                                );

                                // Navigate to the product list page after registration
                                Future.delayed(
                                  Duration(seconds: 1),
                                      () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (c){
                                      return Store(usersapplogic.user_id,nameController.text,emailController.text,imagePath);
                                    })
                                    );
                                  },
                                );
                              } else {
                                // Show "Please fill all fields" message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please fill all fields')),
                                );
                              }
                            },
                            child: Text('Register',style: TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                fixedSize: Size(250, 50),
                backgroundColor: const Color.fromARGB(255, 247, 112, 71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  
                ),
              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}