import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:zac/presentation/screens/login_screen.dart';
import 'package:zac/provider/post_provider.dart';
import 'package:zac/provider/user_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // if (Provider.of<UserProvider>(context, listen: true).userDate != null) {
    //   // Navigator.pushReplacement(context,
    //   //     MaterialPageRoute(builder: (context) => const PostListScreen()));
    //   Navigator.pop(context);
    // }
    return Stack(
      children: [
        Scaffold(
          body: Container(
            decoration: BoxDecoration(color: HexColor("FFFFD7")),
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    // backgroundImage: AssetImage(""),
                    backgroundColor: HexColor("F7FAFC"),
                    radius: 40,
                    child: const Icon(
                      Icons.account_circle,
                      size: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      prefixIcon: Icon(
                        Icons.account_circle,
                      ),
                      // border: InputBorder.none,
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: HexColor("171923"),
                      ),
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          nameController.text.isNotEmpty &&
                          emailController.text.contains("@") &&
                          emailController.text.contains(".")) {
                        final val = await Provider.of<UserProvider>(context,
                                listen: false)
                            .signupUser(context,
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text);
                        if (val) {
                          Navigator.pop(context);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Enter the credentials properly")));
                      }

                      // context.watch<UserProvider>().signupUser(
                      //     name: nameController.text,
                      //     email: emailController.text,
                      //     password: passwordController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("171923"),
                        // backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 52),
                        shape: const RoundedRectangleBorder()),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Use existing account - "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
          ),
        ),
        if (Provider.of<UserProvider>(context).isLoading ||
            Provider.of<PostProvider>(context).isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (Provider.of<UserProvider>(context).isLoading ||
            Provider.of<PostProvider>(context).isLoading)
          Center(
            child: CircularProgressIndicator(
              color: HexColor("FFFFD7"),
            ),
          )
      ],
    );
  }
}
