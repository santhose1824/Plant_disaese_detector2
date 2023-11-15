import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_dec/home/LoginPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? user; // Variable to store the logged-in user
  late String userName = "";
  late String userEmail = "";
  late String userMobile = "";
  late String userAddress = "";

  @override
  void initState() {
    super.initState();
    // Retrieve the currently logged-in user
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(user!.uid);
      // Retrieve user details from Firestore
      getUserDetails(user!.email.toString());
    } else {
      print('not get user detials');
    }
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
        userEmail = userDetails['email'];
        userMobile = userDetails['mobile'];
        userAddress = userDetails['address'];
      });

      print(userName);
      print(userEmail);
      print(userMobile);
      print(userAddress);
      print('User details are retrieved successfully');
    }
  } catch (e) {
    print("Error fetching user details: $e");
    print('User details are not retrieved successfully');
  }
}


  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage()));
      print("User logged out successfully");
    } catch (e) {
      print("Error logging out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/bgr.jpg'),
              fit: BoxFit.cover, // Adjust this as needed
            ),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.black,
              radius: 50,
              child: Text(
                userName.isNotEmpty
                    ? userName[0]
                    : '', // Display the first letter of the user's name
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  buildInfoContainer("Name :", "$userName"),
                  SizedBox(
                    height: 20,
                  ),
                  buildInfoContainer("Email :", userEmail),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildInfoContainer("Mobile :", userMobile),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildInfoContainer("Address :", userAddress),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  signOut();
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoContainer(String label, String text) {
    return Container(
      height: 50,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
