import 'package:flutter/material.dart';
import 'package:hrms/dashBoards/admin.dart';
import 'package:hrms/dashBoards/employee.dart';
import 'package:hrms/dashBoards/hr.dart';
import 'package:hrms/screens/forgot_password.dart';
import 'package:hrms/screens/sign_up.dart';
import 'package:hrms/services/auth_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../constants/text_field_decoration.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String email = '';
  String password = '';
  String rollSelect = 'Employee';

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  
  final AuthService authService = AuthService();

  //login function
  logIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    String? result = await authService.logIn(email, password, (String role) {
      navigationProfile(role);
    });
  }

  //function for role based navigation
  navigationProfile(String role) {
    if(role=='Admin') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Admin()));
    }
    else if(role=='HR') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Hr()));
    }
    else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Employee()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                margin: EdgeInsets.only(right: 160),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back !',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Text(
                      'Login and manage your task',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Email', prefixIcon: Icon(Icons.email)),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.remove_red_eye_outlined)),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, color: Colors.red),
                          ),
                        ),
                        SizedBox(
                          width: 130,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20,),

                    DropdownButton<String>(
                      value: rollSelect,
                      items: ['Employee','HR','Admin']
                          .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      )).toList(),
                      onChanged: (value) => setState(() {
                        rollSelect = value!;
                      }),
                    ),

                    SizedBox(height: 20,),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          setState(() {
                            email = emailController.text;
                            password = passwordController.text;
                          });
                          logIn();
                        }
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'or Sign Up with',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 22.0),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/google.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(
                  width: 20,
                ),
                Image.asset(
                  'assets/apple.png',
                  width: 45,
                  height: 45,
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.call_rounded,
                  size: 45,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
