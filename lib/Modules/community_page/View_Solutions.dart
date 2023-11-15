import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class View_Solutions extends StatefulWidget {
  final String username;
  final String imageUrl;
  final String postId;
  final String caption;

  View_Solutions({
    required this.username,
    required this.imageUrl,
    required this.postId,
    required this.caption,
    Key? key,
  }) : super(key: key);

  @override
  State<View_Solutions> createState() => _View_SolutionsState();
}

class _View_SolutionsState extends State<View_Solutions> {
  late User? user;
  late String userName = "";
  TextEditingController solutionController = TextEditingController();
  List<String> solutions = [];
  List<String> nameList = []; // Add a list to store user names

  @override
  void dispose() {
    solutionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Retrieve the currently logged-in user
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Retrieve user details from Firestore
      getUserDetails(user!.email.toString());
    }
    // Retrieve comments when the widget initializes
    retrieveComments();
  }

  void getUserDetails(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: email) // Use the user's email as a filter
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming email is unique, there should be only one matching document
        DocumentSnapshot userDetails = querySnapshot.docs.first;

        setState(() {
          userName = userDetails['name'];
        });

        print(userName);
        print('User details are retrieved successfully');
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  Future<void> addSolutions(String solution) async {
    try {
      await FirebaseFirestore.instance.collection('Comments').add({
        'postId': widget.postId,
        'name': userName,
        'solution': solution,
      });
      print('User details added to Firestore');
    } catch (e) {
      print('Error adding user details to Firestore: $e');
    }
  }

  void retrieveComments() {
    FirebaseFirestore.instance
        .collection('Comments')
        .where('postId', isEqualTo: widget.postId)
        .snapshots()
        .listen((querySnapshot) {
      setState(() {
        // Clear the existing lists
        solutions.clear();
        nameList.clear();
        // Populate the lists with the retrieved data
        for (var doc in querySnapshot.docs) {
          nameList.add(doc['name']);
          solutions.add(doc['solution']);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(148, 35, 201, 49),
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
            child: Text('Solutions'),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: 1, // Change this to 1
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              'Posted by ${widget.username}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Image.network(
                                  widget.imageUrl,
                                  height: 300,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      '${widget.username} :',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.caption,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                // Add a divider to separate caption and solutions
                                Divider(
                                  color: Colors.white,
                                  thickness: 1,
                                ),
                                // ListView for displaying solutions
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: solutions.length,
                                  itemBuilder: (context, solutionIndex) {
                                    return ListTile(
                                      title: Text(
                                        '${nameList[solutionIndex]}: ${solutions[solutionIndex]}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          // Add a divider to separate posts
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                        ],
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
                          // Show the AlertDialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Give your solution'),
                                content: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    controller: solutionController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter the solution',
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Close the AlertDialog
                                      Navigator.of(context).pop();
                                      addSolutions(solutionController.text);

                                      solutionController.clear();
                                    },
                                    child: Text('Submit'),
                                  ),
                                ],
                              );
                            },
                          );
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
