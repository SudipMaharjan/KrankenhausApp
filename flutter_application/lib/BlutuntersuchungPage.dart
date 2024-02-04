import 'package:flutter/material.dart';
import 'MrtEintragenPage.dart';
import 'Patient.dart';
import 'LaborErgebnis.dart';
import 'blutWertEintragenPage.dart';


class BlutuntersuchungPage extends StatefulWidget{
  final Patient patient;
  final double fSize;

  BlutuntersuchungPage({Key? key, required this.patient, required this.fSize}) : super(key: key);
  @override
  _BlutuntersuchungPage createState() => _BlutuntersuchungPage();
}

class _BlutuntersuchungPage extends State<BlutuntersuchungPage>{
  @override

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Labor',
          style: TextStyle(fontSize: widget.fSize + 5),),
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
                'Labor Ergebnisse',
                style: TextStyle(fontSize: widget.fSize + 5, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),

      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/laborErgebnis.png',  
              width: 200, 
              height: 200, 
              fit: BoxFit.contain, 
            ),
            
            const SizedBox(height: 10,),
            Text(
              'Patient: ${widget.patient.name}', 
              style: TextStyle(fontSize: widget.fSize),
            ), 
            Text(
              'Zustand: ${widget.patient.zustand}',
              style: TextStyle(fontSize: widget.fSize),
            ),
            Text(
              'Zimmer: ${widget.patient.zimmer}', 
              style: TextStyle(fontSize: widget.fSize), 
            ),
            const SizedBox(height: 50,),

            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 178, 20, 20)), 
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), 
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => LaborErgebnis(patient: widget.patient, fSize: widget.fSize, rolle: 'Labor',))
                        );
                      },
                      child: Text(
                        'Laborergebnis ansehen',
                        style: TextStyle(fontSize: widget.fSize),
                      ),
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
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => BlutWertEintragenPage(patient: widget.patient, fSize: widget.fSize,))
                        );
                      },
                      child: Text(
                        'Blutwerte hinzufügen',
                        style: TextStyle(fontSize: widget.fSize),
                      ),
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
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => MrtEintragenPage(patient: widget.patient, fSize: widget.fSize,))
                        );
                        //MRT ergebnis hinzufügen function
                      },
                      child: Text(
                        'MRT ergebnis hinzufügen',
                        style: TextStyle(fontSize: widget.fSize),
                      ),
                    ),

                    const SizedBox(height: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
