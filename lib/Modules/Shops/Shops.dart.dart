import 'package:flutter/material.dart';
import 'package:plant_dec/Modules/Shops/Map.dart';

class Shops extends StatefulWidget {
  const Shops({Key? key}) : super(key: key);

  @override
  State<Shops> createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.green.shade100, Colors.greenAccent.shade100],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shops",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Nearby Your Location",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 21, 128, 0),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image of the shop
                                Image.asset(
                                  'lib/images/shop1.jpg', // Replace with your shop image asset
                                  width: 400.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 20),

                                Row(
                                  children: [
                                    Icon(Icons.shop, size: 30, color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Shop Name : Agri Shops',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Icon(Icons.shop_outlined, size: 30, color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible( // Use Flexible to allow text to wrap
                                      child: Text(
                                        'Shop Address : 123, Anna Street, Madurai ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Icon(Icons.person, size: 30, color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Shop Owner Name : Sanjay',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Icon(Icons.phone, size: 30, color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Contact No : 7841256398',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    IconButton(onPressed: (){
                                      Navigator.of(context).
                                      push(MaterialPageRoute(builder: (context) => MapScreen(
                                        startLat: 9.456222604160631, 
                                        startLong:77.796131793483 ,
                                        endLat:9.486752776020156,   
                                        endLong:77.81125890154013 ,
                                      )));

                                    }, 
                                    icon: Icon(Icons.location_on ,color:Colors.green,size: 30,)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'View In Map',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                // Add spacing between image and text
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 21, 128, 0),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image of the shop
                                Image.asset(
                                  'lib/images/shop2.jpg', // Replace with your shop image asset
                                  width: 400.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 20),

                                Row(
                                  children: [
                                    Icon(Icons.shop, size: 30, color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Shop Name : Agri Shops',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Icon(Icons.shop_outlined, size: 30, color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible( // Use Flexible to allow text to wrap
                                      child: Text(
                                        'Shop Address : 123, Anna Street, Madurai ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Icon(Icons.person, size: 30, color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Shop Owner Name : Sanjay',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Icon(Icons.phone, size: 30, color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Contact No : 7841256398',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    IconButton(onPressed: (){
                                      Navigator.of(context).
                                      push(MaterialPageRoute(builder: (context) => 
                                      MapScreen(
                                        startLat: 9.456222604160631, 
                                        startLong:77.796131793483 ,
                                        endLat:9.460414716102896,
                                        endLong: 77.7996613112072 ,
                                      )));

                                    }, 
                                    icon: Icon(Icons.location_on ,color:Colors.green,size: 30,)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'View In Map',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                // Add spacing between image and text
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 21, 128, 0),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image of the shop
                                Image.asset(
                                  'lib/images/shop3.jpg', // Replace with your shop image asset
                                  width: 400.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 20),

                                Row(
                                  children: [
                                    Icon(Icons.shop, size: 30, color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Shop Name : Agri Shops',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Icon(Icons.shop_outlined, size: 30, color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible( // Use Flexible to allow text to wrap
                                      child: Text(
                                        'Shop Address : 123, Anna Street, Madurai ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Icon(Icons.person, size: 30, color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Shop Owner Name : Sanjay',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Icon(Icons.phone, size: 30, color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Contact No : 7841256398',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    IconButton(onPressed: (){
                                      Navigator.of(context).
                                      push(MaterialPageRoute(builder: (context) => 
                                      MapScreen(
                                        startLat: 9.456222604160631, 
                                        startLong:77.796131793483 ,
                                        endLat:9.452645637006604, 
                                        endLong: 77.79115952348748,
                                      )));

                                    }, 
                                    icon: Icon(Icons.location_on ,color:Colors.green,size: 30,)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'View In Map',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                // Add spacing between image and text
                              ],
                            ),
                          ),
                        ),
                      ],
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
}
