import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fertilizerapp/components/Colorpallet.dart';
import 'package:fertilizerapp/components/Gtext.dart';
import 'package:fertilizerapp/navbar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _keepMeLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkKeepMeLoggedIn();
  }

  Future<void> _checkKeepMeLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool keepLoggedIn = prefs.getBool('keepLoggedIn') ?? false;
    setState(() {
      _keepMeLoggedIn = keepLoggedIn;
    });

    if (_keepMeLoggedIn) {
      _signInWithStoredCredentials();
    }
  }

  // Function to validate email format
  bool _isValidEmail(String email) {
    return EmailValidator.validate(email);
  }

  void _signInWithStoredCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');

    if (storedEmail != null && storedPassword != null) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: storedEmail,
          password: storedPassword,
        );

        context.go('/home'); // Navigate to home on successful sign-in
      } catch (e) {
        print('Error signing in with stored credentials: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Fertilizer Outlet'),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration:
            BoxDecoration(color: ColorPalette.forest_Green.withOpacity(0.2)),
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.15,
                  ),
                  Center(
                    child: Gtext(
                      text: 'Fertilizer Outlet Login',
                      tsize: 25,
                      tcolor: Colors.black,
                      fweight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20,),
                  // Email TextField
                  _buildEmailField(screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  // Password TextField
                  _buildPasswordField(screenWidth),
                  SizedBox(height: screenHeight * 0.03),
                  // Keep me logged in
                  _buildKeepMeLoggedInCheckbox(),
                  SizedBox(height: screenHeight * 0.05),
                  // Sign In Button
                  _buildSignInButton(),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(double screenWidth) {
    return Container(
      width: screenWidth,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black)),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        controller: _usernameController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email_outlined),
          prefixIconColor: ColorPalette.appBar_color,
          hintText: 'Email',
          hintStyle: TextStyle(color: ColorPalette.appBar_color),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          if (!_isValidEmail(value)) {
            return 'Invalid email format';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(double screenWidth) {
    return Container(
      width: screenWidth,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        controller: _passwordController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline),
          prefixIconColor: ColorPalette.appBar_color,
          hintText: 'Password',
          hintStyle: TextStyle(color: ColorPalette.appBar_color),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildKeepMeLoggedInCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _keepMeLoggedIn,
              onChanged: (value) {
                setState(() {
                  _keepMeLoggedIn = value ?? false;
                  _saveKeepMeLoggedIn();
                });
              },
              activeColor: ColorPalette.Jungle_Green,
            ),
            SizedBox(width: 5),
            Gtext(
              text: 'Keep me logged in',
              tsize: 15,
              tcolor: Colors.black,
              fweight: FontWeight.w500,
            ),
          ],
        ),
      ],
    );
  }

  // Save the Keep Me Logged In state to SharedPreferences
  Future<void> _saveKeepMeLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('keepLoggedIn', _keepMeLoggedIn);
    if (_keepMeLoggedIn) {
      // Save the email and password for automatic login
      await prefs.setString('email', _usernameController.text);
      await prefs.setString('password', _passwordController.text);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
    }
  }

  Widget _buildSignInButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorPalette.Jungle_Green,
      ),
      child: MaterialButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            _signInWithEmailAndPassword();
          }
        },
        child: Center(
          child: Gtext(
            text: 'Sign In',
            tsize: 20,
            tcolor: Colors.black,
            fweight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _usernameController.text,
          password: _passwordController.text,
        );

        // If login is successful, navigate to the Home page
        context.go('/home');

        // Clear input fields and save credentials if needed
        if (_keepMeLoggedIn) {
          await _saveKeepMeLoggedIn();
        } else {
          // Clear stored credentials if not keeping logged in
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('email');
          await prefs.remove('password');
        }
        _usernameController.clear();
        _passwordController.clear();
      } on FirebaseAuthException catch (e) {
        // Handle sign-in errors
        String errorMessage = e.message ?? 'An error occurred';
        if (e.code == 'user-not-found') {
          _showErrorDialog('Invalid Email', 'Please enter a valid email.');
        } else if (e.code == 'wrong-password') {
          _showErrorDialog('Invalid Password', 'Please enter a valid password.');
        } else {
          _showErrorDialog('Error', errorMessage);
        }
      }
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
