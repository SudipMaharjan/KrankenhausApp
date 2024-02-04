import 'package:flutter/material.dart';
import 'Patient.dart';

class PatientenAkte extends StatefulWidget{
  final Patient patient;
  final double fSize;
  PatientenAkte({Key? key, required this.patient, required this.fSize}) : super(key: key);

  @override
  _PatientenAkte createState() => _PatientenAkte();
}

class _PatientenAkte extends State<PatientenAkte>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Arzt',
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
          preferredSize:  Size.fromHeight(widget.fSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Patientenakte: ${widget.patient.name} (${widget.patient.zimmer})',
                style: TextStyle(fontSize: widget.fSize + 5, color: Colors.white),
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
              Text(
                'Diagnosen und Beobachtungen', 
                style: TextStyle(fontSize: widget.fSize, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 20,), 
              _buildDiagnosen(),
              const SizedBox(height: 40,),
              Text(
                'Therapeutische Maßnahmen',
                style: TextStyle(fontSize: widget.fSize, fontWeight: FontWeight.bold),
              ), 
              const SizedBox(height: 20,), 
              _buildMassnahmen()
            ],
          ),
        )
    );
  }

  Widget _buildDiagnosen(){
  var diagnosen = widget.patient.diagnosen;
  return SizedBox(
    height: 200, 
    child: ListView.builder(
      itemCount: diagnosen.length,
      itemBuilder: ((context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: EdgeInsets.all(widget.fSize - 12),
          constraints: const BoxConstraints(minHeight: 50.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            title: Text(
              diagnosen[index],
              style: TextStyle(fontSize: widget.fSize),
            ), 
            onTap: () {
              
            },
          )
        );
      }),
    ),
  );
  }


  Widget _buildMassnahmen(){
    var massnahmen = widget.patient.massnahme;
    return SizedBox(
    height: 200, 
    child: ListView.builder(
      itemCount: massnahmen.length,
      itemBuilder: ((context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          constraints: const BoxConstraints(minHeight: 50.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            title: Text(massnahmen[index],
            style: TextStyle(fontSize: widget.fSize),
          ), 
            onTap: () {
              
            },
          )
        );
      }),
    ),
  );
  }
}
