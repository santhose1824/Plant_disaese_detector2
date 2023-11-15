import 'package:flutter/material.dart';
import 'package:plant_dec/Modules/DiseasePrediction/src/home_page/models/disease_model.dart';


class DiseaseService with ChangeNotifier {
  late Disease _disease;

  Disease get disease => _disease;

  void setDiseaseValue(Disease disease) {
    _disease = disease;
    notifyListeners();
  }
}
