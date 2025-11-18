import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/post_button.dart';
import '../components/primary_drawer.dart';
import '../components/primary_list_tile.dart';
import '../components/primary_textfield.dart';
import '../database/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreDatabase database = FirestoreDatabase();
  final TextEditingController newPostController = TextEditingController();
  final String? currentUserEmail =
      FirebaseAuth.instance.currentUser?.email ?? "";
  final ScrollController _scrollController = ScrollController();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      database.addPost(newPostController.text.trim());
      newPostController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true, // important!
        appBar: AppBar(
          centerTitle: true,
          title: const Text("F E E D"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: PrimaryDrawer(),
        body: Column(
          children: [
            // Posts list
            Flexible(
              child: StreamBuilder(
                stream: database.getPostsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final posts = snapshot.data?.docs.reversed.toList() ?? [];

                  if (posts.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("No posts ... Post Something ..."),
                      ),
                    );
                  }

                  // Auto-scroll only if at the bottom
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      if (_scrollController.offset >=
                          _scrollController.position.maxScrollExtent - 100) {
                        _scrollController.animateTo(
                          _scrollController.position.minScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    }
                  });

                  return ListView.builder(
                    controller: _scrollController,
                    reverse: true, // newest at bottom
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      String message = post['PostMessage'];
                      String userEmail = post['UserEmail'];
                      bool isMe = currentUserEmail == userEmail;
                      DateTime dateTime = (post['TimeStamp'] as Timestamp)
                          .toDate();
                      String formattedDate = DateFormat(
                        'yyyy-MM-dd – hh:mm a',
                      ).format(dateTime);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: PrimaryListTile(
                          isMe: isMe,
                          isHome: true,
                          time: formattedDate,
                          title: message,
                          subTitle: userEmail,
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // Input field
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 8,
                top: 8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryTextfield(
                      hintText: "What's on your mind ...",
                      obscureText: false,
                      controller: newPostController,
                    ),
                  ),
                  PostButton(onTap: postMessage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
