import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:zac/data/sp.dart';
import 'package:zac/presentation/screens/profile_screen.dart';
import 'package:zac/presentation/screens/login_screen.dart';
import 'package:zac/presentation/screens/post_list_screen.dart';
import 'package:zac/provider/post_provider.dart';
import 'package:zac/provider/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String? userId;

  void getUserID() async {
    userId = await SP.getUserIdFromSP();
    if (userId != null) {
      if (context.mounted) {
        Provider.of<UserProvider>(context, listen: false)
            .getUserData(context, userId: userId!);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUserID();
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserProvider>().userDate?.data.id;
    return Stack(
      children: [
        Scaffold(
          body: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                // color: Colors.red,
                image: DecorationImage(
                    image: AssetImage("assets/images/zac_app_bg.png"),
                    fit: BoxFit.fitHeight)),
            child: SafeArea(
                child: Column(
              children: [
                userId != null
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfileScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              // backgroundImage: AssetImage(""),
                              backgroundColor: HexColor("FFFFD7"),
                              radius: 30,
                              child: const Icon(
                                (Icons.account_circle),
                                size: 40,
                                // size: double.infinity,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Expanded(
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
                          if (userId != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PostListScreen()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: HexColor("171923"),
                            backgroundColor: HexColor("FFFFD7"),
                            minimumSize: const Size(double.infinity, 52),
                            shape: const RoundedRectangleBorder()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userId != null ? "Next" : "Login",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const Icon(
                              Icons.navigate_next_rounded,
                              size: 28,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ],
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
