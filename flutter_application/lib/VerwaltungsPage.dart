import 'package:flutter/material.dart';
import 'PatientenDatenPage.dart';
import 'Krankenhaus.dart';
import 'Patient.dart';



class VerwaltungsPage extends StatefulWidget{
  final double fSize;
  const VerwaltungsPage({super.key, required this.fSize});


  @override
  _VerwaltungsPageState createState() => _VerwaltungsPageState();
}

class _VerwaltungsPageState extends State<VerwaltungsPage> {
  String appBarText = 'Alle Patienten';

  int _selectedIndex = 0;
  late Widget _conditionWidget;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _zimmerController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _zimmerController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    appBarText = 'Alle Patienten';
    _conditionWidget = _buildPatientenListe();
  }  

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget displaySelectedWidget(){
    _conditionWidget = _buildPatientenListe();
    switch(_selectedIndex){
      case 0 : _conditionWidget = _buildPatientenListe();
      case 1 : _conditionWidget = _buildGenesenePatienten();
      case 2 : _conditionWidget = _buildPatientenAufnahme();
      case 3 : _conditionWidget = _buildEinstellung();
      default : _conditionWidget = Text('error',style: TextStyle(fontSize: widget.fSize),);
    }
    return _conditionWidget;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text('Verwaltung',
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
          preferredSize: Size.fromHeight(widget.fSize + 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                appBarText,
                style: TextStyle(fontSize: widget.fSize + 3, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),

      body: Center(
        child: displaySelectedWidget()
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.healing),
            label: 'Patienten'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apple),
            label: 'genesene'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add), 
            label: 'Aufnehmen'
          ), 
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Einstellungen'
          )
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 247, 210, 162),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildPatientenListe(){
    Krankenhaus krankenhaus = locator<Krankenhaus>();
    
    return ListView.builder(
      itemCount: krankenhaus.getPatient().length,
      itemBuilder: (context, index){
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: EdgeInsets.symmetric(vertical: widget.fSize - 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            title: Text(
              "${krankenhaus.getPatient()[index].name} (${krankenhaus.getPatient()[index].zimmer})",
              style: TextStyle(
                fontSize: widget.fSize, 
                ),
              ), 
            subtitle: Text(
              krankenhaus.getPatient()[index].zustand, 
              style: TextStyle(
                color: krankenhaus.getPatient()[index].zustand == "gesund" ? Colors.green : Colors.red,
              ),
            ), 
            onTap: () {
               Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => PatientenDatenPage(patient: krankenhaus.getPatient()[index], fSize: widget.fSize,))
              );
            },
          )
        );        
      },
    );
  }

  void patientenEntlassen(BuildContext context, Patient p, List<Patient>patienten) {
    Krankenhaus krankenhaus = locator<Krankenhaus>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: FractionallySizedBox(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: AlertDialog(
              title: Text(
                p.name,
                style: TextStyle(fontSize: widget.fSize),
                textAlign: TextAlign.center,
                ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      krankenhaus.patientEntlassen(p);
                      patienten.remove(p);
                      krankenhaus.getZimmer().add(p.zimmer);
                      krankenhaus.getZimmer().sort();
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                        content: Text(
                          '${p.name} wurde entlassen',
                          style: TextStyle(fontSize: widget.fSize),
                          ),
                        ),
                      );
                      setState(() {
                        _conditionWidget = _buildGenesenePatienten();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:  const Color.fromARGB(255, 9, 97, 170),
                        foregroundColor: Colors.white, 
                        padding: EdgeInsets.all(widget.fSize - 10 ),
                        textStyle: TextStyle(fontSize: widget.fSize)
                    ),
                    child: const Text(
                      'Entlassen',),
                  ),
    
                  const SizedBox(height: 15.0,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 178, 20, 20), 
                        foregroundColor: Colors.white, 
                        textStyle: TextStyle(fontSize: widget.fSize),
                        padding: EdgeInsets.all(widget.fSize - 10 ),
                      ),
                    child: const Text('Abbrechen'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPatientenAufnahme(){
  Krankenhaus krankenhaus = locator<Krankenhaus>();
  int? selectedZimmer;
  void _showZimmerPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: krankenhaus.getZimmer().length,
            itemBuilder: (BuildContext context, int index) {
              final value = krankenhaus.getZimmer()[index];
              return ListTile(
                title: Text(
                  value.toString(),
                  style: TextStyle(fontSize: widget.fSize),
                ),
                onTap: () {
                  setState(() {
                    selectedZimmer = value;
                    _zimmerController.text = selectedZimmer!.toString();
                  });
                  Navigator.pop(context); 
                },
              );
            },
          ),
        );
      },
    );
  } 

 return Scaffold(
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(
            "assets/patientAufnahme.png",
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 30.0),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(fontSize: widget.fSize),
              hintText: 'Geben Sie den Namen des Patienten an',
              hintStyle: TextStyle(fontSize: widget.fSize),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding:  EdgeInsets.symmetric(vertical: widget.fSize - 5, horizontal: widget.fSize - 5),
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: _zimmerController,
            readOnly: true,
            onTap: () {
              _showZimmerPicker(context);
            },
            decoration: InputDecoration(
              labelText: 'Zimmer',
              labelStyle: TextStyle(fontSize: widget.fSize),
              hintText: 'Wählen Sie ein Zimmer aus',
              hintStyle: TextStyle(fontSize: widget.fSize),
              suffixIcon: const Icon(Icons.arrow_drop_down),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: widget.fSize - 5, horizontal: widget.fSize - 5),
            ),
          ),
          SizedBox(height: widget.fSize + 10),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 9, 97, 170),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              if (_nameController.text.isEmpty || _zimmerController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Ungültige Eingabe',
                      style: TextStyle(fontSize: widget.fSize),),
                  ),
                );
              }
              else{
                String name = _nameController.text;
                int zimmer = int.parse(_zimmerController.text);
                krankenhaus.getZimmer().remove(zimmer);
                Patient patient = Patient(name, 'ungesund', zimmer,false);
                krankenhaus.addPatient(patient);
                _showAufnahmeDialog(context, name, zimmer);
                _zimmerController.clear();
                _nameController.clear();
              }
            },
            child: Text(
              'Aufnehmen',
              style: TextStyle(fontSize: widget.fSize),
            ),
          ),

          SizedBox(height: widget.fSize + 5),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 178, 20, 20),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              _zimmerController.clear();
              _nameController.clear();
            },
            child: Text(
              'Löschen',
              style: TextStyle(fontSize: widget.fSize),
            ),
          ),
        ],
        ),
      ),
    );
  }


  Widget _buildGenesenePatienten(){

    Krankenhaus krankenhaus = locator<Krankenhaus>();
    var patienten = krankenhaus.getHealtyPatients();

    return ListView.builder(
      itemCount: patienten.length,
      itemBuilder: ((context, index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: widget.fSize - 12),
          margin: const EdgeInsets.symmetric(vertical:  4.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, 
              width: 1.0
            ), 
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            title: Text(
              '${patienten[index].name} (${patienten[index].zimmer})',
              style: TextStyle(fontSize: widget.fSize),), 
            onTap: () {
              setState(() {
                patientenEntlassen(context, patienten[index],patienten);
              });
            },
          )
        );
      }),
    );
  }

  void _showAufnahmeDialog(BuildContext context, String name, int zimmer) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Patient aufgenommen',
          style: TextStyle(fontSize: widget.fSize),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Name: $name',
              style: TextStyle(fontSize: widget.fSize),
            ),
            const SizedBox(height: 10),
            Text(
              'Zimmer: $zimmer',
              style: TextStyle(fontSize: widget.fSize),),
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
              style: TextStyle(fontSize: widget.fSize),),
          ),
        ],
      );
    },
  );
}

  Widget _buildEinstellung(){
  return Scaffold(
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(
            "assets/einstellung.png",
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 30.0),
          
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: Brandt',
                  style: TextStyle(fontSize: widget.fSize, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Vorname: Leon',
                  style: TextStyle(fontSize: widget.fSize, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Rolle: Verwaltungsmitarbeiter',
                  style: TextStyle(fontSize: widget.fSize, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 9, 97, 170),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              Krankenhaus krankenhaus = locator<Krankenhaus>();
              krankenhaus.saveData();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Daten gespeichert',
                      style: TextStyle(fontSize: widget.fSize),),
                  ),
                );
            },
            child: Text(
                  'Daten Speichern',
                  style: TextStyle(fontSize: widget.fSize),
                ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 178, 20, 20),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                const Icon(Icons.logout), 
                const SizedBox(width: 5.0),
                Text(
                  'Abmelden',
                  style: TextStyle(fontSize: widget.fSize),
                ),
              ],
          )
          ),
          SizedBox(height: widget.fSize + 3),
        ],
        ),
      ),
    );
  }
}
