import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  late User? user;
  late String useremail = "";
  late String userName = "";
  String postId = Uuid().v4();

  @override
  void initState() {
    super.initState();
    // Retrieve the currently logged-in user
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(user!.uid);
      useremail = user!.email!;
      print(useremail);
      // Retrieve user details from Firestore
      getUserDetails(useremail);
    } else {
      print('User not logged in');
    }
  }

  File? _image;
  TextEditingController _contentController = TextEditingController();

  Future<void> getUserDetails(String email) async {
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
      print('User details are not retrieved successfully');
    }
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _uploadPost() async {
    if (_image == null) {
      // Handle no image selected
      return;
    }

    try {
      // Store the image in Firebase Storage
      final String userEmail = useremail;
      final String fileName = DateTime.now().toString();
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('$userEmail/$fileName.jpg');
      await storageReference.putFile(_image!);

      // Get the download URL for the uploaded image
      final String imageUrl = await storageReference.getDownloadURL();

      // Store image metadata in Firestore along with userName
      await FirebaseFirestore.instance.collection('Posts').add({
        'postId':postId,
        'userEmail': userEmail,
        'imageUrl': imageUrl,
        'content': _contentController.text,
        'userName': userName, // Include the userName
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear the form
      setState(() {
        _image = null;
        _contentController.clear();
      });

      // Show a success message or navigate to a different screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post uploaded successfully.'),
        ),
      );
    } catch (error) {
      // Handle errors
      print('Error uploading post: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            child: Text('Add Post'),
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: Container(
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _image == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_enhance,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Choose the Picture',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )
                            : Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        controller: _contentController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Enter the Problem',
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                _uploadPost();
              },
              icon: Icon(Icons.upload, color: Colors.white),
              label: Text(
                'Upload your Post',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Instructions',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '1. Select the Image which you want to post',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '2. Type the query which you want to ask?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '3. Then press the Upload Button to post the query in the Community Page',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }
}
