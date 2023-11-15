import 'package:flutter/material.dart';
import 'package:plant_dec/Modules/community_page/Add_Post.dart';
import 'package:plant_dec/Modules/community_page/View_Solutions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityPage {
  final String username;
  final String imageUrl;
  final String caption;
  final String postId;

  CommunityPage({
    required this.username,
    required this.imageUrl,
    required this.caption,
    required this.postId
  });
}

class CommunityPageList extends StatefulWidget {
  @override
  State<CommunityPageList> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPageList> {
  final List<CommunityPage> posts = [];

  @override
  void initState() {
    super.initState();
    // Fetch data from Firestore when the widget is initialized
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Posts').get();

      final List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (final doc in documents) {
        final username = doc['userName'];
        final imageUrl = doc['imageUrl'];
        final caption = doc['content'];
        final postId = doc['postId'];

        setState(() {
          posts.add(CommunityPage(
            username: username,
            imageUrl: imageUrl,
            caption: caption,
            postId: postId
          ));
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(147, 124, 208, 131),
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Padding(
            padding: EdgeInsets.all(0),
            child: Text('Community Page'),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: const Color.fromARGB(255, 148, 237, 151),
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Search the content as you want',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return ListTile(
                        title: Text(
                          'Posted by ${post.username}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Image.network(
                              post.imageUrl,
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 8),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${post.username} :',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      post.caption,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Center(
  child: ElevatedButton.icon(
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => View_Solutions(
            username: post.username, // Pass the correct username
            imageUrl: post.imageUrl,
            postId: post.postId,
            caption: post.caption,
          ),
        ),
      );
    },
    icon: Icon(Icons.comment_outlined),
    label: Text('Click to see the solutions'),
  ),
)

                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 20, // Adjust the distance from the bottom as needed
                    left: 0,
                    right: 0,
                    child: Center(
                      child: FloatingActionButton(
                        backgroundColor: Color.fromARGB(255, 56, 218, 62),
                        onPressed: () {
                          // Add your button's onPressed action here
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddPost()));
                        },
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
