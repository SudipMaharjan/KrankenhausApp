import 'package:flutter/material.dart';
import 'Patient.dart';
import 'patientenAkte.dart';
import 'LaborErgebnis.dart';

class BehandlungPage extends StatefulWidget{
  final Patient patient;
  final double fSize;

  const BehandlungPage({Key? key, required this.patient, required this.fSize}) : super(key: key);

  @override
  _BehandlungPage createState() => _BehandlungPage();
}

class _BehandlungPage extends State<BehandlungPage>{
  TextEditingController _diagnoseController = TextEditingController();
  TextEditingController _massnahmenController = TextEditingController();

  @override
  void dispose(){
    _diagnoseController.dispose();
    _massnahmenController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
    appBar: AppBar(
      title: Text(
        'Arzt',
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
        preferredSize: const Size.fromHeight(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Visite',
              style: TextStyle(fontSize: widget.fSize + 5, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),

      body: SingleChildScrollView(
        child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [           
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
          
                const SizedBox(height: 15,),
          
                Padding(
                  padding: EdgeInsets.all(widget.fSize),
                  child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline, 
                    controller: _diagnoseController,
                    decoration: InputDecoration(
                      labelText: 'Diagnosen und Beobachtungen',
                      labelStyle: TextStyle(fontSize: widget.fSize),
                      hintText: 'Diagnosen und Beobachtungen hier eintragen', 
                      hintStyle: TextStyle(fontSize: widget.fSize),
                      border: const OutlineInputBorder(), 
                      contentPadding: EdgeInsets.symmetric(vertical: widget.fSize, horizontal: widget.fSize),
                    ),
                  ),
                ),
          
                Padding(
                  padding:EdgeInsets.only(bottom: widget.fSize, left: widget.fSize, right: widget.fSize),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  const Color.fromARGB(255, 9, 97, 170),
                    foregroundColor: Colors.white, 
                    textStyle: TextStyle(fontSize: widget.fSize),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), 
                    ),
                  ),                  
                  onPressed: () {
                    String userInput = _diagnoseController.text;
                    if(userInput.isEmpty){
                       ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:  Text(
                            'Diagnose ungültig',
                            style: TextStyle(fontSize: widget.fSize),
                          ),
                        ),
                      );
                      return;
                    }
                    userInput = userInput.toUpperCase();
                    if (!widget.patient.hasDiagnose(userInput)) {
                      widget.patient.diagnose_hinzufuegen(userInput);
                      _diagnoseController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                          content:  Text(
                            'Diagnose hinzugefügt',
                            style: TextStyle(fontSize: widget.fSize),
                          ),
                        ),
                      );
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:  Text(
                            'Diagnose schon vorhanden',
                            style: TextStyle(fontSize: widget.fSize),),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Diagnose Hinzufügen',
                    style: TextStyle(fontSize: widget.fSize),
                  ),
                ),
                  ],
                ),
                ),
          
                Padding(
                  padding: EdgeInsets.all(widget.fSize),
                  child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline, 
                    controller: _massnahmenController,
                    decoration: InputDecoration(
                      labelText: 'Therapeutische Massnahmen', 
                      labelStyle: TextStyle(fontSize: widget.fSize),
                      hintText: 'Therapeutische Massnahmen', 
                      border: const OutlineInputBorder(), 
                      contentPadding: EdgeInsets.symmetric(vertical: widget.fSize, horizontal: widget.fSize),
                    ),
                  ),
                ),
          
                Padding(
                  padding:EdgeInsets.only(bottom: widget.fSize, left: widget.fSize, right: widget.fSize),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor:  const Color.fromARGB(255, 9, 97, 170),
                    foregroundColor: Colors.white, 
                    textStyle: TextStyle(fontSize: widget.fSize),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), 
                    ),
                  ),        

                    onPressed: () {
                    String userInput = _massnahmenController.text;
                    if(userInput.isEmpty){
                       ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:  Text(
                            'Massnahmen ungültig',
                            style: TextStyle(fontSize: widget.fSize),
                          ),
                        ),
                      );
                      return;
                    }

                    if(userInput == "MRT"){
                      widget.patient.setHasMRI(true);
                    }

                    if(userInput == "Blutuntersuchung"){
                      widget.patient.setHasBloodTest(true);
                    }
                      

                    userInput = userInput.toUpperCase();

                    if (!widget.patient.hasMassnahme(userInput)) {
                      widget.patient.massnahmenAnordnen(userInput);
                      _massnahmenController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:  Text(
                            'Massnahmen hinzugefügt',
                            style: TextStyle(fontSize: widget.fSize),
                          ),
                        ),
                      );
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:  Text(
                            'Massnahme schon vorhanden',
                            style: TextStyle(fontSize: widget.fSize),
                          ),

                        ),
                      );
                    }
                    },
                    child: Text(
                    'Massnahmen Hinzufügen',
                    style: TextStyle(fontSize: widget.fSize),
                  ),
                  ),
                    ],
          
                  ),
                  ),

                const SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.all(widget.fSize),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                            MaterialPageRoute(builder: ((context) => LaborErgebnis(patient: widget.patient, fSize: widget.fSize,rolle: 'Arzt'))),
                          );
                        },
                        child: Text(
                          'Laborergebnisse ansehen',
                          style: TextStyle(fontSize: widget.fSize),
                        ),
                      ),
          
                      const SizedBox(height: 15,),
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
                            MaterialPageRoute(builder: ((context) => PatientenAkte(patient: widget.patient, fSize: widget.fSize))),
                          );
                        },
                        child: Text(
                          'Diagnosen und Maßnahmen ansehen',
                          style: TextStyle(fontSize: widget.fSize),
                        ),
                      ),
          
                      const SizedBox(height: 15,),
                      _buildConditionButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }

  Widget _buildConditionButton(){
    if(widget.patient.zustand != "gesund"){
            return ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 44, 118, 87)), 
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), 
                  ),
                ),
              ),
              onPressed: () {
                widget.patient.zustand = 'gesund';
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Patient ist genesen',
                        style: TextStyle(fontSize: widget.fSize),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.patient.name} ist nun gesund',
                            style: TextStyle(fontSize: widget.fSize),
                          )
                        ],
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 6, 86, 151)), 
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0), 
                              ),
                              
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(fontSize: widget.fSize),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Patient als gesund markieren',
                style: TextStyle(fontSize: widget.fSize),
              ),
          );
          } 
          else {
            return const SizedBox();
          }
  }
}
