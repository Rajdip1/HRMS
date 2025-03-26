import 'package:HRMS/authentication%20screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  String email = '';
  String password = '';
  String? selectedRole;
  final List<String> roles = ['HR', 'Employee'];
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? roleError; // Variable to store role selection error message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0, -1),
            child: Image.network(
              'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 180, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 5),
                                child: Container(
                                  width: 300,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE0E0E0),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedRole,
                                      hint: Text(
                                        'Select Role',
                                        style: GoogleFonts.openSans(
                                          color: Color(0x7F455A64),
                                        ),
                                      ),
                                      isExpanded: true,
                                      items: roles.map((String role) {
                                        return DropdownMenuItem<String>(
                                          value: role,
                                          child: Text(
                                            role,
                                            style: GoogleFonts.openSans(
                                              color: Color(0xFF455A64),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedRole = newValue;
                                          roleError = null; // Clear error when user selects a role
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              if (roleError != null) // Show error message if role is not selected
                                Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 15),
                                  child: Text(
                                    roleError!,
                                    style: TextStyle(color: Colors.red, fontSize: 14),
                                  ),
                                ),
                              SizedBox(height: 5,),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      roleError = selectedRole == null ? 'Please select a role' : null;
                                    });

                                    if (_formKey.currentState!.validate() && selectedRole != null) {
                                      email = emailController.text;
                                      password = passwordController.text;

                                      // Handle sign-in logic here
                                    }
                                    AuthServiceMethods().register(email, password,selectedRole!);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(300, 50),
                                    backgroundColor: Colors.black,
                                    textStyle: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignInScreen()));
                                },
                                child: Text(
                                  'Already have an account',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Playfair Display',
                                    color: Color(0xFF1F1F1F),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
