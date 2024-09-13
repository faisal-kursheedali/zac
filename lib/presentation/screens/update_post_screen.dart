import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:zac/provider/post_provider.dart';
import 'package:zac/provider/user_provider.dart';

class UpdatePostScreen extends StatefulWidget {
  final String postId, head, desc;
  const UpdatePostScreen(
      {super.key,
      required this.postId,
      required this.head,
      required this.desc});

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentControler = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.head;
    contentControler.text = widget.desc;
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserProvider>().userDate?.data.id;
    return Stack(
      children: [
        Scaffold(
          body: Container(
              width: double.infinity,
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
                              bottom: BorderSide(color: HexColor("171923")))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Update Post",
                            style: TextStyle(
                                color: HexColor("171923"),
                                fontSize: 44,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("post id: ${widget.postId}"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            child: TextField(
                              controller: titleController,
                              decoration:
                                  const InputDecoration(hintText: 'Title'),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              expands: true,

                              // <-- SEE HERE
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 90,
                            child: TextField(
                              controller: contentControler,
                              decoration: const InputDecoration(
                                hintText: 'Content',
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              expands: true, // <-- SEE HERE
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (userId != null &&
                                        (titleController.text != widget.head ||
                                            contentControler.text !=
                                                widget.desc)) {
                                      final val = await Provider.of<
                                                  PostProvider>(context,
                                              listen: false)
                                          .updatePost(context,
                                              postId: widget.postId,
                                              userId: userId,
                                              title: titleController.text,
                                              content: contentControler.text);
                                      if (val) {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content:
                                                      Text("Post Updated")));
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Post not Updated")));
                                        }
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Make some changes")));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: HexColor("171923"),
                                      foregroundColor: Colors.white,
                                      minimumSize:
                                          const Size(double.infinity, 52),
                                      shape: const RoundedRectangleBorder()),
                                  child: const Text("Update Post"),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
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
