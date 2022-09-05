import 'package:blog/Components/shared.dart';
import 'package:blog/Screens/post_page.dart';
import 'package:blog/Services/curd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../Models/post_model.dart';
import '../Services/auth_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final posttext = TextEditingController();
final _formKey = GlobalKey<FormState>();
Curdservices curd = Curdservices();
//read all the posts in the database
Stream<List<Post>> readPosts() {
  return FirebaseFirestore.instance.collection('test').snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Post.fromJson(doc.data())).toList());
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    //substring the username from the email
    int index1 = 0;
    for (int i = 0; i < user!.email!.length; i++) {
      if ('@' == user.email![i]) {
        index1 = i;

        break;
      }
    }
    //get the user currnet name
    String currentuser = user.email!.substring(0, index1);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome $currentuser',
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        try {
                          context.read<authServices>().signout();
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: e.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Logout',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<List<Post>>(
                  stream: readPosts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text("No new posts try Posting something"),
                        );
                      }
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostPage(
                                          index, snapshot.data![index].id)),
                                );
                              },
                              //Hold to delete the post
                              onLongPress: () {
                                if (currentuser ==
                                    snapshot.data![index].username) {
                                  curd.deletePost(snapshot.data![index].id);
                                } else
                                  print('Wrong user');
                              },
                              child: post(
                                  snapshot.data![index].username,
                                  snapshot.data![index].text,
                                  snapshot.data![index].date,
                                  snapshot.data![index].firstLetter,
                                  snapshot.data![index].comments.length,
                                  context),
                            );
                          }));
                    }
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  }),
              // post(
              //     'Ahmed Osman',
              //     'My First Post Yayy!! My First Post Yayy!!My First Post Yayy!!My First Post Yayy!!',
              //     '1/1/2022',
              //     'A',
              //     context),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            label: Row(
              children: [
                Text(
                  'add Post',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(Icons.add)
              ],
            ),
            onPressed: () {
              _showDialog(context);
            }),
      ),
    );
  }
}

void _showDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final user = FirebaseAuth.instance.currentUser;

      return Form(
        key: _formKey,
        child: AlertDialog(
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(color: Color(0xff18759A))),
          title: Container(
            color: Colors.black,
            child: Row(
              children: [
                const Icon(Icons.add, size: 22, color: Colors.white),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "New Post",
                  style: GoogleFonts.comfortaa(
                    fontSize: 18,
                    color: const Color(0xff18759A),
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dotted,
                  ),
                ),
              ],
            ),
          ),
          content: Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textfield('Post', 'What is on your mind', false,
                        TextInputType.text, Icons.add, posttext),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: const Color(0xff18759A), // background
                    onPrimary: Colors.white // foreground
                    ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    int index = 0;
                    for (int i = 0; i < user!.email!.length; i++) {
                      if ('@' == user.email![i]) {
                        index = i;
                        break;
                      }
                    }
                    var now = DateTime.now();
                    var formatter = DateFormat('yyyy-MM-dd');
                    String formattedDate = formatter.format(now);
                    await curd.addPost(
                        user.email!.substring(0, 1),
                        user.email!.substring(0, index),
                        posttext.text.trim(),
                        formattedDate, []);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "add Post",
                        style: GoogleFonts.comfortaa(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
