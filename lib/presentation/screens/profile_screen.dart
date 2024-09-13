import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:zac/data/sp.dart';
import 'package:zac/presentation/screens/home_screen.dart';
import 'package:zac/presentation/widgets/post_list_item.dart';
import 'package:zac/provider/post_provider.dart';
import 'package:zac/provider/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PostProvider>(context, listen: false).getAllPost(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pp = Provider.of<PostProvider>(context, listen: true).posts;
    final userId = context.read<UserProvider>().userDate?.data.id;
    var data = [];
    if (pp != null) {
      for (var i in pp.post) {
        if (i.author == userId) data.add(i);
      }
    }
    final user = context.read<UserProvider>().userDate?.data;
    return Stack(
      children: [
        Scaffold(
          body: Container(
            color: HexColor("FFFFD7"),
            width: double.infinity,
            child: SafeArea(
                child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title:
                                          const Text("Do you want to log out"),
                                      actions: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "No",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            SP.removeUserIdFromSP();
                                            Provider.of<UserProvider>(context,
                                                    listen: false)
                                                .logoutUser();
                                            // if (context.mounted) {
                                            // if (del) {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomeScreen()),
                                                (r) => false);
                                            // }
                                            // }
                                          },
                                          child: const Text(
                                            "Yes",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )
                                      ],
                                    ));
                          },
                          icon: const Icon(Icons.logout)),
                    ],
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: HexColor("F7FAFC"),
                    child: const Icon(
                      Icons.account_circle,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 10),
                  user != null
                      ? Text("${user.name} • ${user.email}")
                      : Container(),
                  const SizedBox(height: 20),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return PostListItem(
                            // head: data[i].title,
                            // desc: data[i].content,
                            // likeCount: data[i].likes.length,
                            // authorName: data[i].authorName,
                            // date: data[i].createdAt,
                            // authorId: data[i].author,
                            postId: data[i].id,
                          );
                        }),
                  )
                  // Row(children: [Text("name"), Text("Email")],)
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
