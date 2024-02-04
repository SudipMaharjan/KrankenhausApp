import 'blutwert.dart';

class Patient{
  String _name;
  String _zustand;
  int _zimmer;
  bool _isVisited;
  bool _hasMRI = false;
  bool _hasBloodTest = false;

  final List<String> _diagnosen = [];
  final List<String> _massnahmen = [];
  final List<Blutwert> _blutwerte = [];
  final List<String> _mrt = [];


  Patient(this._name, this._zustand, this._zimmer, this._isVisited);


  set zustand(String z){ _zustand = z; }
  set name(String n){ _name = n; }
  set zimmer(int z){ _zimmer = z; }
  set isVisited(bool i){_isVisited = i;}

  void setHasMRI(bool m){ _hasMRI =  m; }
  void setHasBloodTest(bool b){ _hasBloodTest = b; }
  
  String get zustand => _zustand;
  String get name => _name;
  int get zimmer => _zimmer;
  bool get isVisited => _isVisited;
  bool get hasMRI => _hasMRI;
  bool get hasBloodTest => _hasBloodTest;

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'zustand': _zustand,
      'zimmer': _zimmer,
      'diagnosen': _diagnosen,
      'massnahmen': _massnahmen,
      'blutwerte': _blutwerte.map((blutwert) => blutwert.toJson()).toList(),
      'mrt': _mrt,
      'isVisited': _isVisited,
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
  return Patient(
    json['name'],
    json['zustand'],
    json['zimmer'],
    json ['isVisited'],
  )
    .._diagnosen.addAll(List<String>.from(json['diagnosen'] ?? []))
    .._massnahmen.addAll(List<String>.from(json['massnahmen'] ?? []))
    .._blutwerte.addAll(List<Blutwert>.from((json['blutwerte'] ?? []).map((blutwert) => Blutwert.fromJson(blutwert))))
    .._mrt.addAll(List<String>.from(json['mrt'] ?? []));
}

  void diagnose_hinzufuegen(String d) async {
    _diagnosen.add(d);
  }

  bool hasMRT(String imagePath){
    return _mrt.any((mrtImage) => mrtImage == imagePath);
  }

  bool hasDiagnose(String d){
    return _diagnosen.any((diagnose) => diagnose == d);
  }

  int compareTo(Patient p){
    return zimmer.compareTo(p.zimmer);
  }
  
  bool hasMassnahme(String m){
    return _massnahmen.any((massnahme) => massnahme == m);
  }

  void massnahme_hinzufuegen(String m){
    _massnahmen.add(m);
  }

  void mrtbild_hinzufuegen(String m){
    _mrt.add(m);
  }
  void massnahmenAnordnen(String n){
    _massnahmen.add(n);
  }

  List<String> get diagnosen => _diagnosen;
  List<String> get massnahme => _massnahmen;
  List<Blutwert> get blutwerte => _blutwerte;
  List<String> get mrt => _mrt;

  void blutwert_eintragen(Blutwert blutwert){
    blutwerte.add(blutwert);
  }

}
