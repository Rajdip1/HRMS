import 'package:HRMS/authentication screens/sign_up_screen.dart';
import 'package:HRMS/employee_management/employee_home_screen.dart';
import 'package:HRMS/screens/dashboard_screen.dart';
import 'package:HRMS/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = '';
  String password = '';
  String? selectedRole;
  String? roleError; // To store the role selection error message

  final List<String> roles = ['HR', 'Employee'];
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Function to handle sign-in logic
  signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    await AuthServiceMethods().logIn(email, password, (String role) {
      navigationProfile(role);
    });
  }

  // Function for role-based navigation
  navigationProfile(String role) {
    if (role == 'HR') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    } else if (role == 'Employee') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EmployeeHomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context); // Listen for theme changes

    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark ? Colors.black : Colors.white,
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
                    decoration: BoxDecoration(
                      color: themeProvider.themeMode == ThemeMode.dark ? Colors.black : Colors.white,
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
                                padding:
                                EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                padding:
                                EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                    color: themeProvider.themeMode == ThemeMode.dark ? Colors.grey[800] : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedRole,
                                      hint: Text(
                                        'Select Role',
                                        style: GoogleFonts.openSans(
                                          color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black,
                                        ),
                                      ),
                                      isExpanded: true,
                                      items: roles.map((String role) {
                                        return DropdownMenuItem<String>(
                                          value: role,
                                          child: Text(
                                            role,
                                            style: GoogleFonts.openSans(
                                              color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black,
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
                              if (roleError != null) // Show error if role is not selected
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
                                      roleError = selectedRole == null
                                          ? 'Please select a role'
                                          : null;
                                    });

                                    if (_formKey.currentState!.validate() &&
                                        selectedRole != null) {
                                      signIn(); // Call sign-in function
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(300, 50),
                                    backgroundColor: themeProvider.themeMode == ThemeMode.dark ? Colors.grey[800] : Colors.white, // Adapts to theme,
                                    textStyle: GoogleFonts.openSans(
                                      color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black, // Adapts to theme
                                      fontSize: 16,
                                    ),
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black,),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()));
                                },
                                child: Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Playfair Display',
                                    color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black,
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
