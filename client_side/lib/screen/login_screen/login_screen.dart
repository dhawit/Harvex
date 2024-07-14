import 'package:client_side/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart'; // Make sure you have the correct import

import '../home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void handleLogin() async {
      final String phone = phoneController.text;
      final String password = passwordController.text;

      // Using the userProvider for login
      await context.userProvider
          .login(LoginData(name: phone, password: password));

      // Navigate to home screen if login is successful
      if (context.userProvider.getLoginUsr()?.sId != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ));
      } else {
        // Show error or handle unsuccessful login
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }

    void handleSignUp() {
      // Using the named constructor for SignupData
      final SignupData data = SignupData.fromSignupForm(
        name: phoneController.text,
        password: passwordController.text,
      );
      context.userProvider.register(data);
    }

    void handleRecoverPassword() {
      // Implement password recovery
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'HARVEX',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(
                        255, 30, 63, 31), // Text color for HARVEX
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: const Color(
                        0xFFBDBDBD), // Background color for the text field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: const Color(
                        0xFFBDBDBD), // Background color for the text field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: handleRecoverPassword,
                    child: const Text('Forgot Password?',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    backgroundColor: const Color.fromARGB(255, 86, 188, 53),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ), // Background color for the button
                  ),
                  child: const Text('Sign in'),
                ),
                const SizedBox(height: 16),
                const Text("Dont have an account? Sign up!"),
                const SizedBox(height: 16),
                const Text("Or login with social account"),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.g_translate, color: Colors.black),
                      onPressed: () {
                        // Handle Google sign in
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.facebook, color: Colors.black),
                      onPressed: () {
                        // Handle Facebook sign in
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
