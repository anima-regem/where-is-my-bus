import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/homepage');
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Image(
              width: 200,
              height: 200,
              image: AssetImage('lib/assets/logo.png'),
            ),
          ),
          Text(
            "where is my college bus?",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xfff08c00),
              textStyle: const TextStyle(letterSpacing: 1),
            ),
          ),
        ],
      ),
    );
  }
}
