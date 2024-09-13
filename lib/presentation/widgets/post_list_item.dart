import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:zac/data/model/Posts.dart';
import 'package:zac/presentation/screens/post_screen.dart';
import 'package:zac/provider/post_provider.dart';

class PostListItem extends StatelessWidget {
  // final String head, desc, date, authorName, authorId;
  final String postId;
  // final int likeCount;
  const PostListItem(
      {super.key,
      // required this.head,
      // required this.desc,
      // required this.likeCount,
      // required this.date,
      // required this.authorName,
      // required this.authorId,
      required this.postId});

  @override
  Widget build(BuildContext context) {
    final pp = Provider.of<PostProvider>(context, listen: true).posts;
    Post pt;
    pt = pp!.post.firstWhere((e) => e.id == postId);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostScreen(
                      // head: head,
                      // desc: desc,
                      // likeCount: likeCount,
                      // authorName: authorName,
                      // date: date,
                      // authorId: authorId,
                      postId: postId,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: HexColor("171923"),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pt.title,
              style: TextStyle(
                  fontSize: 26,
                  color: HexColor("171923"),
                  fontWeight: FontWeight.w600),
            ),
            Text(
              pt.content,
              style: TextStyle(fontSize: 16, color: HexColor("171923")),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.thumb_up,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  pt.likes.length.toString(),
                  style: TextStyle(fontSize: 18, color: HexColor("171923")),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
