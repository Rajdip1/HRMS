import 'package:HRMS/authentication%20screens/sign_up_screen.dart';
import 'package:HRMS/employee_management/employee_home_screen.dart';
import 'package:HRMS/screens/dashboard_screen.dart';
import 'package:HRMS/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  String email = '';
  String password = '';
  String rollSelect = 'Employee';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  signIn() async {
    String email = emailController.text;
    String password = passwordController.text;
    
    await AuthServiceMethods().logIn(email, password, (String role){
      navigationProfile(role);
    });
  }

  //function for role based navigation
  navigationProfile(String role) {
    if(role=='HR') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    }
    else if(role=='Employee') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EmployeeHomeScreen()));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email Input
              const Text("Email", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
          
              // Password Input
              const Text("Password", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // role select
              Center(
                child: DropdownButton<String>(
                  value: rollSelect,
                  items: ['Employee','HR']
                      .map((role) => DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  )).toList(),
                  onChanged: (value) => setState(() {
                    rollSelect = value!;
                  }),
                ),
              ),
              SizedBox(height: 15,),
          
              // Login Button
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent[400], // Match screenshot color
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      setState(() {
                        email = emailController.text;
                        password = passwordController.text;
                      });
                      signIn();
                    }
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
          
              const SizedBox(height: 15),
          
              // Forgot Password & Sign Up Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
