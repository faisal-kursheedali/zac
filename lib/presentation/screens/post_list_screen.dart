import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:zac/presentation/screens/create_post.dart';
import 'package:zac/presentation/widgets/post_list_item.dart';
import 'package:zac/provider/post_provider.dart';
import 'package:zac/provider/user_provider.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PostProvider>(context, listen: false).getAllPost(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pp = Provider.of<PostProvider>(context, listen: true).posts;
    var data = [];
    var sortData = [];
    if (pp != null) {
      data = pp.post;
      sortData = data;
      sortData.sort((a, b) => a.likes.length.compareTo(b.likes.length));
      sortData = sortData.reversed.toList();
    }
    return Stack(
      children: [
        Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreatePost()));
            },
            clipBehavior: Clip.hardEdge,
            backgroundColor: HexColor("171923"),
            shape: const CircleBorder(),
            child: Icon(
              Icons.add,
              color: HexColor("F7FAFC"),
            ),
          ),
          body: Container(
            color: HexColor("FFFFD7"),
            child: SafeArea(
                child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     CircleAvatar(
                  //       backgroundImage: AssetImage(""),
                  //     ),
                  //   ],
                  // ),
                  const Text(
                    "Write. Share. Inspire.",
                    style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Where the world transcend boundaries Navigating the Blogging Seas.",
                    style: TextStyle(fontSize: 18, color: HexColor("171923")),
                  ),
                  TabBar(controller: _tabController, tabs: const [
                    Tab(
                      child: Text("Popular"),
                    ),
                    Tab(
                      child: Text("All"),
                    ),
                  ]),
                  Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, i) => PostListItem(
                                // head: sortData[i].title,
                                // desc: sortData[i].content,
                                // likeCount: sortData[i].likes.length,
                                // authorName: sortData[i].authorName,
                                // date: sortData[i].createdAt,
                                // authorId: sortData[i].author,
                                postId: sortData[i].id,
                              )),
                      ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, i) => PostListItem(
                                // head: data[i].title,
                                // desc: data[i].content,
                                // likeCount: data[i].likes.length,
                                // authorName: data[i].authorName,
                                // date: data[i].createdAt,
                                // authorId: data[i].author,
                                postId: data[i].id,
                              ))
                    ]),
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
