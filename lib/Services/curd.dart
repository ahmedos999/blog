import 'package:blog/Models/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/post_model.dart';

class Curdservices {
  addPost(String firstLetter, String username, String text, String date,
      List<Comment> Comments) async {
    final docEvents = FirebaseFirestore.instance.collection('test').doc();
    final event = Post(
        id: docEvents.id,
        firstLetter: firstLetter,
        username: username,
        text: text,
        date: date,
        comments: Comments);
    final json = event.toJson();
    await docEvents.set(json);
  }

  // Stream<List<Eventmodel>>readEvents()=>FirebaseFirestore.instance.collection('test').snapshots().map(
  //   (snapshot) => snapshot.docs.map((doc) => Eventmodel.fromJson(doc.data())).toList());

  deletePost(id) async {
    await FirebaseFirestore.instance.collection('test').doc(id).delete();
  }

  addcomments(id, Comment comment) async {
    await FirebaseFirestore.instance.collection('test').doc(id).update({
      "Comments": FieldValue.arrayUnion([comment.toJson()])
    });
  }

  deletecomment(id, Comment comment) async {
    await FirebaseFirestore.instance.collection('test').doc(id).update({
      "Comments": FieldValue.arrayRemove([comment.toJson()])
    });
  }
}
