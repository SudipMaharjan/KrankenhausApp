
class Blutwert{
  String _datum;
  String _uhrzeit;
  int _systole;
  int _diastole;
  int _puls;
  
  Blutwert(this._datum, this._uhrzeit, this._systole, this._diastole, this._puls);

  String get datum => _datum;
  String get uhrzeit => _uhrzeit;
  int get systole => _systole;
  int get diastole => _diastole;
  int get puls => _puls;

  // Convert Blutwert object to JSON Map
  Map<String, dynamic> toJson() {
    return {
      'datum': _datum,
      'uhrzeit': _uhrzeit,
      'systole': _systole,
      'diastole': _diastole,
      'puls': _puls,
    };
  }

  // Create Blutwert object from JSON Map
  factory Blutwert.fromJson(Map<String, dynamic> json) {
    return Blutwert(
      json['datum'],
      json['uhrzeit'],
      json['systole'],
      json['diastole'],
      json['puls'],
    );
  }
}
