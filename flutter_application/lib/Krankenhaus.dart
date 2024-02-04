import 'dart:convert';

import 'Patient.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Krankenhaus {
  double _fontSize; //fontSize
  List<Patient> _patienten;
  List<int> _zimmer;

  Krankenhaus(this._fontSize,this._patienten,this._zimmer);

  double get fontSize => _fontSize; //fontSize
  
  List<Patient>getPatient(){
    _patienten.sort(((a, b) => a.zimmer.compareTo(b.zimmer)));
    return _patienten;
  }

  List<int> getZimmer(){
    return _zimmer;
  }
  set fontSize( double value){
    _fontSize = value;
  }

  void addZimmer(){
    for (int i = 100; i <= 1000; i++) {
    _zimmer.add(i);
  }
  }

  void zimmerBesetzen(){
    _patienten.forEach((p) {
      _zimmer.removeWhere((zimmerNr) => zimmerNr == p.zimmer);
    });
  }

  void addPatient(Patient p){
      _patienten.add(p);
  }

  void patientEntlassen(Patient p){
    _patienten.removeWhere((pat) => pat == p);
  }

  List<Patient> getHealtyPatients(){
    List<Patient> patienten = [];
    _patienten.forEach((p) {
      if(p.zustand == "gesund"){
          patienten.add(p);        
      }
    });
    return patienten;
  }

  
  // Convert Krankenhaus object to JSON Map
  Map<String, dynamic> toJson() {
    return {
      'fontSize': _fontSize, //fontSize
      'patienten': _patienten.map((patient) => patient.toJson()).toList(),
      'zimmer': _zimmer,
    };
  }

  // Create Krankenhaus object from JSON Map
  factory Krankenhaus.fromJson(Map<String, dynamic> json) {
    final krankenhaus = Krankenhaus(
      json['fontSize'], //fontSize
      List<Patient>.from(json['patienten'].map((patient) => Patient.fromJson(patient))),
      List<int>.from(json['zimmer']),
    );
    return krankenhaus;
  }

  // Save Krankenhaus data to shared preferences
  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String krankenhausJson = jsonEncode(toJson());
    prefs.setString('krankenhausData', krankenhausJson);
  }

  // Load Krankenhaus data from shared preferences
  static Future<Krankenhaus> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? krankenhausJson = prefs.getString('krankenhausData');

    if (krankenhausJson == null) {
      List<int> z = [];
      for (int i = 100; i <= 1000; i++) {
        z.add(i);
      }
      return Krankenhaus(16.0, [], z);
    }

    return Krankenhaus.fromJson(jsonDecode(krankenhausJson));
  }

   Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('krankenhausData');
  }

}

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  Krankenhaus krankenhaus = await Krankenhaus.loadData();
  locator.registerSingleton(krankenhaus);
}
