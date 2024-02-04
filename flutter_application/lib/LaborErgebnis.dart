import 'package:flutter/material.dart';
import 'Patient.dart';

class LaborErgebnis extends StatefulWidget{
  final Patient patient;
  final double fSize;
  final String rolle;
  
  LaborErgebnis({Key? key, required this.patient, required this.fSize, required this.rolle}) : super(key: key);

  @override
  _LaborErgebnis createState() => _LaborErgebnis();
}

class _LaborErgebnis extends State<LaborErgebnis>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      title: Text(
        widget.rolle,
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
      bottom:  PreferredSize(
        preferredSize: const Size.fromHeight(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Laborergebnisse: ${widget.patient.name} (${widget.patient.zimmer})',
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
              'Blutwerte', 
              style: TextStyle(fontSize: widget.fSize + 2, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10,),
            _buildBlutwertListe(),
            const SizedBox(height: 20,), 
            Text(
              'MRT-Bilder',
              style: TextStyle(fontSize: widget.fSize + 2, fontWeight: FontWeight.bold),
            ), 
            const SizedBox(height: 10,),
            _buildMrt(),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
    
  }

  Widget _buildBlutwertListe() {
  var blutwerte = widget.patient.blutwerte;
  return SizedBox(
    height: 200, 
    child: ListView.builder(
      itemCount: blutwerte.length,
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
            title: Text(
              'Datum:  ${blutwerte[index].datum}\nUhrzeit:  ${blutwerte[index].uhrzeit}\nSystole(oberer Wert):  ${blutwerte[index].systole}\nDiastole(unterer Wert):  ${blutwerte[index].diastole}\nPuls: ${blutwerte[index].puls}',
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
  Widget _buildMrt(){
    var mrtBilder = widget.patient.mrt;
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: mrtBilder.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Image.asset(
                mrtBilder[index], 
                width: 200, 
                height: 200,
                fit: BoxFit.contain
              ),
            )
          );
        },
      )
    );
  }
}
