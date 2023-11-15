import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plant_dec/Modules/DiseasePrediction/services/disease_provider.dart';
import 'package:plant_dec/Modules/DiseasePrediction/src/home_page/models/disease_model.dart';
import 'package:plant_dec/home/HomePage.dart';
import 'package:plant_dec/home/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(DiseaseAdapter());

  await Hive.openBox<Disease>('plant_diseases');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while checking authentication state.
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            // User is logged in, navigate to the home page or any other authenticated page.
            return ChangeNotifierProvider<DiseaseService>(
              create: (context) => DiseaseService(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Detect diseases',
                theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'SFRegular'),
                home:  HomePage(),
              ),
            );
          } else {
            // User is not logged in, show the login page.
            return ChangeNotifierProvider<DiseaseService>(
              create: (context) => DiseaseService(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Detect diseases',
                theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'SFRegular'),
                home: LoginPage(),
              ),
            );
          }
        }
      },
    );
  }
}
