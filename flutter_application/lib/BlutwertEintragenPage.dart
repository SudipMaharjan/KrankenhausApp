import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Patient.dart';
import 'package:intl/intl.dart';
import 'blutwert.dart';

class BlutWertEintragenPage extends StatefulWidget{
  final Patient patient;
  final double fSize;

  BlutWertEintragenPage({Key ? key, required this.patient, required this.fSize}) : super(key: key);

  @override
  _BlutWertEintragenPage createState() => _BlutWertEintragenPage();
}

class _BlutWertEintragenPage extends State<BlutWertEintragenPage>{
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  final TextEditingController _systoleController = TextEditingController();
  final TextEditingController _diastoleController = TextEditingController();
  final TextEditingController _pulsController = TextEditingController();

  @override
  void dispose(){
    _systoleController.dispose();
    _diastoleController.dispose();
    _pulsController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context, 
      initialDate: selectedDate, 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2101)
    );
    if(pickedDate != null && pickedDate != selectedDate){
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context, 
      initialTime: selectedTime
    );
    if(pickedTime != null && pickedTime != selectedTime){
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Labor',
          style: TextStyle(fontSize: widget.fSize + 5),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 134, 172, 190),
        foregroundColor:  Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        bottom: PreferredSize(
          preferredSize:  const Size.fromHeight(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Blutwerte eintragen: ${widget.patient.name}(${widget.patient.zimmer})',
                style: TextStyle(fontSize: widget.fSize + 3, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
               Text(
                'Bitte füllen Sie alle Felder vollständig aus!', 
                style: TextStyle(fontSize: widget.fSize),
              ), 
              const SizedBox(height: 10,),
              Text(
                'Datum auswählen: $selectedDate',
                style: TextStyle(fontSize: widget.fSize),
              ), 
              const SizedBox(height: 15,), 
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>( const Color.fromARGB(255, 9, 97, 170)), 
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), 
                    ),
                  ),
                ),
                onPressed: () => _selectDate(context),
                child: Text(
                  'Datum auswählen',
                  style: TextStyle(fontSize: widget.fSize),),
              ), 
        
              const SizedBox(height: 20,), 
              Text(
                'Uhrzeit auswählen: $selectedTime',
                style: TextStyle(fontSize: widget.fSize),
              ),
              const SizedBox(height: 15,), 
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 9, 97, 170)), 
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), 
                    ),
                  ),
                ),
                onPressed: () => _selectTime(context),
                child: Text(
                  'Uhrzeit auswählen',
                  style: TextStyle(fontSize: widget.fSize),
                ),
              ),
        
              const SizedBox(height: 20,), 
              Padding(
                padding: const EdgeInsets.all(10.0), 
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: _systoleController, 
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly // Accepts only digits
                  ],
                  decoration: InputDecoration(
                    labelText: 'Systole eintragen',
                    labelStyle: TextStyle(fontSize: widget.fSize), 
                    hintText: 'Systole (oberen Wert) hier eintragen',
                    hintStyle: TextStyle(fontSize: widget.fSize),
                    border: const OutlineInputBorder(), 
                    contentPadding: EdgeInsets.symmetric(vertical: widget.fSize, horizontal: widget.fSize),  
                  ),
                )
              ),
        
              const SizedBox(height: 10,),
               Padding(
                padding: const EdgeInsets.all(10.0), 
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: _diastoleController, 
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly // Accepts only digits
                  ],
                  decoration: InputDecoration(
                    labelText: 'Diastole eintragen', 
                    labelStyle: TextStyle(fontSize: widget.fSize),
                    hintText: 'Systole (unteren Wert) hier eintragen',
                    hintStyle: TextStyle(fontSize: widget.fSize),
                    border: const OutlineInputBorder(), 
                    contentPadding: EdgeInsets.symmetric(vertical: widget.fSize, horizontal: widget.fSize),  
                  ),
                )
              ),
              
              const SizedBox(height: 10,),
               Padding(
                padding: const EdgeInsets.all(10.0), 
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: _pulsController, 
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly // Accepts only digits
                  ],
                  decoration: InputDecoration(
                    labelText: 'Puls eintragen', 
                    labelStyle: TextStyle(fontSize: widget.fSize),
                    hintText: 'Puls hier eintragen',
                    hintStyle: TextStyle(fontSize: widget.fSize),
                    border: const OutlineInputBorder(), 
                    contentPadding: EdgeInsets.symmetric(vertical: widget.fSize, horizontal: widget.fSize),  
                  ),
                )
              ),
              const SizedBox(height: 20,), 
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 9, 97, 170)), 
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), 
                    ),
                  ),
                ),

                onPressed: () {
                  if (_systoleController.text.isEmpty ||_diastoleController.text.isEmpty ||_pulsController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Bitte füllen Sie alle Felder aus.',
                        style: TextStyle(fontSize: widget.fSize),
                      ),
                      ),
                    );
                    return;
                  }
                  String datum = DateFormat('dd.MM.yyyy').format(selectedDate);
                  String uhrzeit = '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
                  int systole = int.parse(_systoleController.text);
                  int diastole = int.parse(_diastoleController.text);
                  int puls = int.parse(_pulsController.text); 

                    if (systole < 80 || systole > 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Systole ungültig',
                            style: TextStyle(fontSize: widget.fSize),),
                        ),
                      );
                      return;
                    }

                    if (diastole < 30 || diastole > 100) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Diastole ungültig',
                            style: TextStyle(fontSize: widget.fSize),),
                        ),
                      );
                      return;
                    }

                    if (puls < 30 || puls > 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Puls ungültig',
                            style: TextStyle(fontSize: widget.fSize),),
                        ),
                      );
                      return;
                    }

                    if (systole <= diastole) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Systole soll höher als Diastole',
                            style: TextStyle(fontSize: widget.fSize),
                          ),
                        ),
                      );
                      return;
                    } 

                  Blutwert blutwert = Blutwert(datum, uhrzeit, systole, diastole, puls);
                  widget.patient.blutwert_eintragen(blutwert);
                  widget.patient.setHasBloodTest(false);
        
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:  Text(
                        'Blutwerte hinzugefügt',
                        style: TextStyle(fontSize: widget.fSize),
                      ),
                    ),
                  );
                  _systoleController.clear();
                  _diastoleController.clear();
                  _pulsController.clear();
                },
                child: Text(
                  'Blutwerte Hinzufügen',
                  style: TextStyle(fontSize: widget.fSize),
                ),
            ),
            ],
          )
        ),
      )
    );
  }
}
