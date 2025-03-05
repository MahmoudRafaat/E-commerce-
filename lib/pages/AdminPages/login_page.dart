import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/project2/pages/user pages/store.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseLogic.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';
import 'package:untitled3/project2/pages/AdminPages/adminHome.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              )),
            ),
          ),
          AnimatedLoginButton(),
        ],
      ),
    );
  }
}

class AnimatedLoginButton extends StatefulWidget {
  @override
  _AnimatedLoginButtonState createState() => _AnimatedLoginButtonState();
}

class _AnimatedLoginButtonState extends State<AnimatedLoginButton> {
  Icon ic = Icon(Icons.remove_red_eye);
  bool check = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Appdatabaselogic()..createDatabaseAndTable(),
      
      child:  BlocConsumer<Appdatabaselogic, Appdatabasestate>(
        listener: (context, state) {
          // Handle state changes if needed
        }, builder: (context, state) {
                    Appdatabaselogic usersapplogic = BlocProvider.of(context);
 
        return Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center content vertically
        children: [
          Flexible(
            flex: 50,
            fit: FlexFit.tight,
            child: Container(
              child: Image.asset('lib/assets/images/tick.png'),
            ),
          ),
          Flexible(
            flex: 20,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                controller: email,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 20,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                obscureText: true,
                cursorColor: Colors.white,
                controller: password,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.white,
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Spacer(
            flex: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async{
                  if (email.text == "" || password.text == "")
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
                  else {
                    bool check_email = false;
                    bool check_password = false;
                    if ("Admin@gmail.com" == email.text) {
                      check_email = true;
                      if ("123" == password.text) {
                        check_password = true;
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Welcome Admin Page',
                                    style: TextStyle(color: Colors.green)),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (b) {
                                        return Adminhome();
                                      }));
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    }
                    else{
                       check_email = false;
       check_password = false;
      
      // Validate email and password from the database
      List<Map<String, dynamic>> users = await usersapplogic.getUsers(); // Fetch users from database
      for (var user in users) {
        if (user['email'] == email.text) {
          check_email = true;
          if (user['password'] == password.text) {
            check_password = true;
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Store(user['id'],user['name'],user['email'],user['url']), // Redirect to the product list
            ));
            break;
          }
        }
      }

                    }
                    if (check_email == false)
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Invaild Email',
                                  style: TextStyle(color: Colors.red)),
                              content: Text("your email is wrong",
                                  style: TextStyle(color: Colors.red)),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    if (check_email == true && check_password == false)
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Invaild password',
                                  style: TextStyle(color: Colors.red)),
                              content: Text(
                                "your password is wrong",
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
                          });
                  }

                  setState(() {});
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(150, 50),
                  backgroundColor: const Color.fromARGB(255, 247, 112, 71),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          TextButton(
            child: Text(
              "Don't have an account? Sign Up",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
          ),
        ],
      );
         },
    ));
  }
}




// Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Adminlogin()),
//                 );



                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RegisterPage()),
                // )