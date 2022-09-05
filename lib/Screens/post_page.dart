import 'package:blog/Components/shared.dart';
import 'package:blog/Screens/home.dart';
import 'package:blog/Services/curd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/comment_model.dart';
import '../Models/post_model.dart';

class PostPage extends StatefulWidget {
  int index;
  String id;
  PostPage(this.index, this.id, {super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  // Future<Post?> readSinglePost() async {
  //   final doc = FirebaseFirestore.instance.collection('test').doc(widget.id);
  //   final snashot = await doc.get();

  //   if (snashot.exists) {
  //     return Post.fromJson(snashot.data()!);
  //   }
  // }
  Stream<List<Post>> readPosts() {
    return FirebaseFirestore.instance.collection('test').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Post.fromJson(doc.data())).toList());
  }
  // Stream<Post> readPosts() {
  //    final doc = FirebaseFirestore.instance
  //       .collection('test')
  //       .doc(widget.id)
  //       .snapshots();

  //       Post.fromJson(doc.);
  // }

  Curdservices curd = Curdservices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: (() {}),
        child: Scaffold(
          body: StreamBuilder<List<Post?>>(
              stream: readPosts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: const Color(0xffF0E5CF),
                              child: Text(
                                snapshot.data![widget.index]!.firstLetter,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff4B6587),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            title: Text(
                              snapshot.data![widget.index]!.username,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff0099c9),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(snapshot.data![widget.index]!.text,
                                style: GoogleFonts.poppins(
                                    fontSize: 22, fontWeight: FontWeight.w400)),
                            trailing: Text(snapshot.data![widget.index]!.date,
                                style: GoogleFonts.poppins(
                                    fontSize: 12, fontWeight: FontWeight.w400)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                              height: 2,
                              thickness: 3,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            // height: _animation.value,
                            height: MediaQuery.of(context).size.height * 0.65,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  snapshot.data![widget.index]!.comments.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  //Hold to delete the comment
                                  onLongPress: () {
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    int index1 = 0;
                                    for (int i = 0;
                                        i < user!.email!.length;
                                        i++) {
                                      if ('@' == user.email![i]) {
                                        index1 = i;

                                        break;
                                      }
                                    }
                                    String currentuser =
                                        user.email!.substring(0, index1);
                                    if (currentuser ==
                                        snapshot
                                            .data![widget.index]!.username) {
                                      curd.deletecomment(
                                          widget.id,
                                          snapshot.data![widget.index]!
                                              .comments[index]);
                                    }
                                  },
                                  child: comment(
                                      snapshot.data![widget.index]!
                                          .comments[index].op,
                                      snapshot.data![widget.index]!
                                          .comments[index].op
                                          .substring(0, 1),
                                      snapshot.data![widget.index]!
                                          .comments[index].text,
                                      context),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
                }
                return const Center(
                  child: Text('oops this poster no longer exist'),
                );
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showModal(context, widget.id);
            },
            child: const Icon(Icons.comment),
          ),
        ),
      ),
    );
  }
}

void _showModal(BuildContext context, String id) {
  final controller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  int index1 = 0;
  for (int i = 0; i < user!.email!.length; i++) {
    if ('@' == user.email![i]) {
      index1 = i;

      break;
    }
  }
  String currentuser = user.email!.substring(0, index1);
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          height: 100,
          child: Column(children: [
            TextField(
              controller: controller,
              obscureText: false,
              keyboardType: TextInputType.text,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black45,
                ),
                hintText: 'Write comment here',
                focusColor: Colors.grey,
                suffixIcon: GestureDetector(
                    onTap: (() {
                      if (controller.text.trim().isNotEmpty) {
                        Comment newcomment =
                            Comment(op: currentuser, text: controller.text);
                        curd.addcomments(id, newcomment);
                      }
                    }),
                    child:
                        const Icon(Icons.send, size: 30, color: Colors.blue)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white54,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff93DEFF)),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ]),
        ),
      );
    },
  );
}
