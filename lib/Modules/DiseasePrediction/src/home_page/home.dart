import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_dec/Modules/DiseasePrediction/constants/constants.dart';
import 'package:plant_dec/Modules/DiseasePrediction/services/classify.dart';
import 'package:plant_dec/Modules/DiseasePrediction/services/disease_provider.dart';
import 'package:plant_dec/Modules/DiseasePrediction/src/home_page/components/greeting.dart';
import 'package:plant_dec/Modules/DiseasePrediction/src/home_page/components/instructions.dart';
import 'package:plant_dec/Modules/DiseasePrediction/src/home_page/components/titlesection.dart';
import 'package:plant_dec/Modules/DiseasePrediction/src/home_page/models/disease_model.dart';
import 'package:plant_dec/Modules/DiseasePrediction/src/suggestions_page/suggestions.dart';
import 'package:provider/provider.dart';

class DiseasePredicition extends StatefulWidget {
  const DiseasePredicition({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<DiseasePredicition> createState() => _DiseasePredicitionState();
}

class _DiseasePredicitionState extends State<DiseasePredicition> {
  @override
  Widget build(BuildContext context) {
    // Get disease from provider
    final _diseaseService = Provider.of<DiseaseService>(context);

    // Data
    Size size = MediaQuery.of(context).size;
    final Classifier classifier = Classifier();
    late Disease _disease;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SpeedDial(
        icon: Icons.camera_alt,
        spacing: 10,
        children: [
          SpeedDialChild(
            child: const FaIcon(
              FontAwesomeIcons.file,
              color: kWhite,
            ),
            label: "Choose image",
            backgroundColor: kMain,
            onTap: () async {
              late double _confidence;
              await classifier.getDisease(ImageSource.gallery).then((value) {
                _disease = Disease(
                    name: value?[0]["label"],
                    imagePath: classifier.imageFile.path);

                _confidence = value?[0]['confidence'];
              });
              // Check confidence
              if (_confidence > 0.8) {
                // Set disease for Disease Service
                _diseaseService.setDiseaseValue(_disease);

                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Suggestions()));
              } else {
                // Display unsure message
              }
            },
          ),
          SpeedDialChild(
            child: const FaIcon(
              FontAwesomeIcons.camera,
              color: kWhite,
            ),
            label: "Take photo",
            backgroundColor: kMain,
            onTap: () async {
              late double _confidence;

              await classifier.getDisease(ImageSource.camera).then((value) {
                _disease = Disease(
                    name: value![0]["label"],
                    imagePath: classifier.imageFile.path);

                _confidence = value[0]['confidence'];
              });

              // Check confidence
              if (_confidence > 0.8) {
                // Set disease for Disease Service
                _diseaseService.setDiseaseValue(_disease);

                Navigator.restorablePushNamed(
                  context,
                  Suggestions.routeName,
                );
              } else {
                // Display unsure message
              }
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.greenAccent,
        child: CustomScrollView(
          slivers: [
            GreetingSection(size.height * 0.2),
            TitleSection('Instructions', size.height * 0.066),
            InstructionsSection(size),
          ],
        ),
      ),
    );
  }
}
