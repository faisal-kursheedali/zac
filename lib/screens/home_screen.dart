import 'package:color_hex/color_hex.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zac/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.red,
            image: DecorationImage(
                image: AssetImage("assets/images/zac_app_bg.png"),
                fit: BoxFit.fitHeight)),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Empore your voice illuminate your mind",
              style: TextStyle(
                  color: HexColor("F7FAFC"),
                  fontSize: 56,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: HexColor("171923"),
                  backgroundColor: HexColor("FFFFD7"),
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder()),
              child: const Text("Login"),
            )
          ],
        )),
      ),
    );
  }
}
