import 'package:flutter/material.dart';
import 'package:paynvio/navigation.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 120),
            _uppersection(),
            const SizedBox(height: 20),
            _formfields(),
          ],
        ),
      ),
    );
  }

  Widget _uppersection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Login",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A2B61),
          ),
        ),
        const Text(
          "Login to your account",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF1A2B61),
          ),
        ),
      ],
    );
  }

  Widget _formfields() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Email",
            hintText: "Enter your email",
            floatingLabelStyle: const TextStyle(color: Color(0xFF1A2B61)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF1A2B61), width: 2),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
            floatingLabelStyle: const TextStyle(color: Color(0xFF1A2B61)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF1A2B61), width: 2),
            ),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 3),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF1A2B61),
            ),
            child: const Text("Forgot Password ?"),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavigationScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A2B61),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text("Login"),
          ),
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            Expanded(
              child: Divider(color: const Color(0xFF1A2B61), thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Or",
                style: TextStyle(
                  color: const Color(0xFF1A2B61),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Divider(color: const Color(0xFF1A2B61), thickness: 1),
            ),
          ],
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: Image.asset('assets/google_icon.png', height: 24),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF1A2B61),
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            label: const Text("Continue with Google"),
          ),
        ),

        const SizedBox(height: 25),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupScreen()),
            );
          },
          style: TextButton.styleFrom(foregroundColor: const Color(0xFF1A2B61)),
          child: const Text("Don't have an account?, Sign Up"),
        ),
      ],
    );
  }
}
