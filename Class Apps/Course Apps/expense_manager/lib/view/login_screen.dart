import "package:expense_manager/view/home_screen.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "signUp_page.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(42),
        child: Column(
          children: [
            SizedBox(
              child: Image.asset("assets/images/flash screen.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                "Login to your Account",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 49,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(boxShadow: []),
              child: TextField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 49,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(boxShadow: []),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
              },
              child: Container(
                  height: 49,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(14, 161, 125, 1),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(
                    "Sign In",
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ));
                  },
                  child: Text("Sign Up",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue)),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
