import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:zac/data/model/Posts.dart';
import 'package:zac/presentation/screens/update_post_screen.dart';
import 'package:zac/provider/post_provider.dart';
import 'package:zac/provider/user_provider.dart';

class PostScreen extends StatefulWidget {
  // final String head, desc, date, authorName, authorId;
  final String postId;
  // final int likeCount;
  const PostScreen(
      {super.key,
      // required this.head,
      // required this.desc,
      // required this.date,
      // required this.authorName,
      // required this.likeCount,
      // required this.authorId,
      required this.postId});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late DateTime dateTime;
  @override
  void initState() {
    super.initState();
    // dateTime = DateTime.parse(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    final pp = Provider.of<PostProvider>(context, listen: true).posts;
    Post pt;
    pt = pp!.post.firstWhere((e) => e.id == widget.postId);
    dateTime = DateTime.parse(pt.createdAt);
    final ud = Provider.of<UserProvider>(context, listen: true).userDate;
    final userId = ud?.data.id;
    // final userId = ud != null ? ud.data.id : null;
    // final userId = '66e3cd2d2706e1a93f0f08f8';
    return Stack(
      children: [
        Scaffold(
          body: Container(
              color: HexColor("FFFFD7"),
              child: SafeArea(
                  child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: HexColor("171923")))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pt.title,
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: HexColor("171923"),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${dateTime.day}-${dateTime.month}-${dateTime.year} • ${pt.authorName}",
                                  style: TextStyle(
                                      color: HexColor("171923"), fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Provider.of<PostProvider>(context,
                                                listen: false)
                                            .likePost(
                                                userId: userId!, postId: pt.id);
                                      },
                                      icon: Icon(Icons.thumb_up),
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      pt.likes.length.toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: HexColor("171923")),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    userId != null && userId == pt.author
                                        ? ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdatePostScreen(
                                                              postId:
                                                                  widget.postId,
                                                              head: pt.title,
                                                              desc:
                                                                  pt.content)));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  HexColor("171923"),
                                              // shape: RoundedRectangleBorder()
                                            ),
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(
                                                  color: HexColor("F7FAFC")),
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            pt.content,
                            style: TextStyle(color: HexColor("171923")),
                          )
                        ],
                      )))),
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
