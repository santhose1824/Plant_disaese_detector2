import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:plant_dec/Modules/DiseasePrediction/src/home_page/home.dart';
import 'package:plant_dec/Modules/Shops/Shops.dart.dart';
import 'package:plant_dec/Modules/community_page/community_page.dart';
import 'package:plant_dec/home/ProfilePage.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/suggestions';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User? user;
  late String userName = "";

  // List of names and image paths for each card
  final List<String> cardNames = [
    'Disease Prediction',
    'Community Page',
    'Shops',
  ];

  final List<String> cardImages = [
    // Replace with your image paths
    'lib/images/disease_predicition_image.png',
    'lib/images/community_page_image.jpg',
    'lib/images/shops.jpg',
  ];
  @override
  void initState() {
    super.initState();
    // Retrieve the currently logged-in user
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(user!.uid);
      getUserDetails(user!.email.toString());
      // Retrieve user details from Firestore
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
        });

        print(userName);

        print('User details are retrieved successfully');
      }
    } catch (e) {
      print("Error fetching user details: $e");
      print('User details are not retrieved successfully');
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfilePage()));
                    },
                    child: CircleAvatar(
                      child: Text(userName.isNotEmpty ? userName[0] : '',
                          style: TextStyle(color: Colors.white)),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.black,
                      radius: 20,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: 3, // Number of cards
                  shrinkWrap: true, // Important to avoid unbounded height
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the respective card page when tapped
                        if (index == 0) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DiseasePredicition(),
                            ),
                          );
                         
                        } else if (index == 1) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CommunityPageList(),
                            ),
                          );
                        } else if (index == 2) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Shops(),
                            ),
                          );
                          
                        } 
                      },
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                cardImages[index], // Use the image path
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              cardNames[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
