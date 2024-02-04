import 'package:flutter/material.dart';
import 'Patient.dart';

class PatientenDatenPage extends StatefulWidget{
  final Patient patient;
  final double fSize;

  PatientenDatenPage({Key? key, required this.patient, required this.fSize}) : super(key: key);

  @override
  _PatientenDatenPage createState() => _PatientenDatenPage();
}

class _PatientenDatenPage extends State<PatientenDatenPage>{

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
    appBar: AppBar(
      title: Text(
        'Verwaltung',
        style: TextStyle(fontSize: widget.fSize + 5),),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 134, 172, 190),
      foregroundColor:  Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(widget.fSize + 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Patient Daten',
              style: TextStyle(fontSize: widget.fSize + 3, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/PatientDaten.png',  
              width: 200, 
              height: 200, 
              fit: BoxFit.contain, 
            ),
            
            const SizedBox(height: 25,),
            Text(
              'Patient: ${widget.patient.name}', 
              style: TextStyle(fontSize: widget.fSize + 5),
            ), 
            Text(
              'Zustand: ${widget.patient.zustand}',
              style: TextStyle(fontSize: widget.fSize),
            ),
            Text(
              'Zimmer: ${widget.patient.zimmer}', 
              style: TextStyle(fontSize: widget.fSize), 
            ),
          ],
        )
      ),
    );
  }
}
