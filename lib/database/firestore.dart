/*
This database store posts that users have published in the app.
Its stored in the connection called "Posts" in Firebase

Each post contains: 
- a message
- email of the user
- timestamp
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;
  // get collection of posts from the Firebase
  final CollectionReference posts = FirebaseFirestore.instance.collection(
    "Posts",
  );
  //post a message
  Future<void> addPost(String message) {
    return posts.add({
      'PostMessage': message,
      'UserEmail': user!.email,
      'TimeStamp': Timestamp.now(),
    });
  }
  // Future<void> addPost(String message, {File? imageFile}) async {
  //   String? imageUrl;

  //   if (imageFile != null) {
  //     final storageRef = FirebaseStorage.instance
  //         .ref()
  //         .child('post_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
  //     try {
  //       await storageRef.putFile(imageFile);
  //       imageUrl = await storageRef.getDownloadURL();
  //     } catch (e) {
  //       print('Upload failed: $e');
  //       imageUrl = null; // continue without image
  //     }
  //   }

  //   await posts.add({
  //     'PostMessage': message,
  //     'UserEmail': user!.email,
  //     'TimeStamp': Timestamp.now(),
  //     'ImageUrl': imageUrl,
  //   });
  // }

  //read posts from firebase
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("TimeStamp", descending: false)
        .snapshots();

    return postsStream;
  }
}
