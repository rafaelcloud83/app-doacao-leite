import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'DOA LEITE',
            style: GoogleFonts.oleoScript(
              textStyle: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Image.asset("imagens/LeiteLogo150.png"),
        ]),
      ),
    );
  }
}
