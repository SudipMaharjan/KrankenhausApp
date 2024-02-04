import 'package:flutter/material.dart';
import 'arztPage.dart';
import 'verwaltungsPage.dart';
import 'laborPage.dart';
import 'Krankenhaus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  Krankenhaus get krankenhaus => locator<Krankenhaus>();
   late String sfontSize;

   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

   @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      krankenhaus.saveData(); // Save data before closing the app
    }
  }
  String? dropdownValue = 'Arzt';


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    appBar: AppBar(
        elevation: 0.0, 
        backgroundColor: const Color.fromARGB(255, 251, 252, 252), 
        title: Text(
          'AS Krankenhaus',
          style: TextStyle(
            fontSize: krankenhaus.fontSize + 6, 
            fontWeight: FontWeight.bold, 
            color: Colors.black,
          ),
        ),
      centerTitle: true,
      actions: <Widget>[
        Padding(padding: const EdgeInsets.all(8.0),
        child:
          DropdownButton<String>(
            underline: const SizedBox(),
            icon: const Icon(
              Icons.zoom_in,
              color: Colors.black,
            ),
            onChanged: (String? newValue) {
              setState(() {
                sfontSize = newValue!;
                switch(sfontSize){
                  case 'Klein' : krankenhaus.fontSize = 12.0;
                  case 'Mittel' : krankenhaus.fontSize = 16.0;
                  case 'Groß' : krankenhaus.fontSize = 20.0;
                }
              });
            },
            items: <String>['Klein', 'Mittel', 'Groß']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: krankenhaus.fontSize),),
              );
            }).toList(),
          ),
          
        ),
        ],
      
    ),
    body: 
        SingleChildScrollView(
          child:Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/krankenhaus.png',  
                  width: 200, 
                  height: 200, 
                  fit: BoxFit.contain, 
                ),
                
                SizedBox(height: krankenhaus.fontSize), 
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width * 0.8, 
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!; 
                      });
                    },
                    items: ['Arzt', 'Verwaltung', 'Labor'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                          child: Text(
                            value,
                            textAlign: TextAlign.center, 
                            style: TextStyle(
                              fontSize: krankenhaus.fontSize,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    style:  TextStyle(
                      fontSize: krankenhaus.fontSize,
                      color: Colors.black,
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    elevation: 2,
                    dropdownColor: Colors.white,
                    underline: Container(
                      height: 2,
                      color: const Color.fromARGB(255, 183, 207, 228),
                    ),
                  ),
                ),
            
                SizedBox(height: krankenhaus.fontSize * 1.25), 
                
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Benutzername',
                          labelStyle: TextStyle(
                            fontSize: krankenhaus.fontSize
                          ),
                          border:const OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: krankenhaus.fontSize * 1.25), 
            
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Passwort',
                          labelStyle: TextStyle(
                            fontSize: krankenhaus.fontSize
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: krankenhaus.fontSize * 1.25), 
                        
                      ElevatedButton(
                          onPressed: () {
                            if (dropdownValue == 'Arzt') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  ArztPage( fSize: krankenhaus.fontSize,)),
                              );
                            }
                
                            if (dropdownValue == 'Verwaltung') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => VerwaltungsPage(fSize: krankenhaus.fontSize,)),
                              );
                            }
                
                            if (dropdownValue == 'Labor') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LaborPage(fSize: krankenhaus.fontSize,)),
                              );
                            }                  
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  const Color.fromARGB(255, 9, 97, 170),
                            foregroundColor: Colors.white, 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0), 
                            ),
                          ),
                          child:  Text(
                            'Anmelden',
                            style: TextStyle(
                              fontSize: krankenhaus.fontSize, // Text size
                            ),
                          ),
                      )
                    ],
                  ),
                ),
              ],
            ),
        )
  );
}

}
