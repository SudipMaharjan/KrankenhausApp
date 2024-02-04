import 'package:flutter/material.dart';
import 'BlutuntersuchungPage.dart';
import 'Krankenhaus.dart';

class LaborPage extends StatefulWidget{
  final double fSize;
  const LaborPage({super.key, required this.fSize});

  @override
  _LaborPageState createState() => _LaborPageState();
}

class _LaborPageState extends State<LaborPage> {
  String nachricht = 'Willkommen auf der Laborseite!';
  int _selectedIndex = 0;
  late Widget _conditionWidget;

  void initState(){
    super.initState();
    _conditionWidget = _buildPatientenListe();
  }  

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
      if(index == 0){
        _conditionWidget = _buildPatientenListe();
      }
      else if(index == 1){
        _conditionWidget = _buildEinstellung();
      }
      else{
        _conditionWidget = const Text("Keine Aktion");
      }
    });
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
        bottom: PreferredSize(
          preferredSize:  const Size.fromHeight(20.0),
          child: _selectedIndex == 0 ? Text("Alle Patienten", style: TextStyle(fontSize: widget.fSize + 5, color: Colors.white),) 
          : Text("Einstellungen", style: TextStyle(fontSize: widget.fSize + 5,color: Colors.white)),
        ),
        backgroundColor:  const Color.fromARGB(255, 134, 172, 190),
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          )
        ),
      ),

      body: Center(
        child: _conditionWidget
      ), 
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.healing),
            label: 'Patienten'
          ), 
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), 
            label: 'Einstellungen'
          )
        ],
        backgroundColor: Colors.blueGrey,
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
          padding: EdgeInsets.all(widget.fSize - 12),
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
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  krankenhaus.getPatient()[index].zustand, 
                  style: TextStyle(
                    color: krankenhaus.getPatient()[index].zustand == "gesund" ? Colors.green : Colors.red,
                  ),
                ),
                if(krankenhaus.getPatient()[index].hasMRI)
                  const Text(
                   "benötigt MRT", 
                   style: TextStyle(
                    color: Colors.blue, 
                   ), 
                  ),
                if(krankenhaus.getPatient()[index].hasBloodTest)
                  const Text(
                    "benötigt Blutuntersuchung",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  )
              ],
            ), 
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => BlutuntersuchungPage(patient: krankenhaus.getPatient()[index], fSize: widget.fSize,))
              );
            },
          )
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: Hoffmann',
                    style: TextStyle(fontSize: widget.fSize , fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Vorname: Theo',
                    style: TextStyle(fontSize: widget.fSize , fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Rolle: Labormitarbeiter',
                    style: TextStyle(fontSize: widget.fSize , fontWeight: FontWeight.bold),
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
            const SizedBox(height: 20.0),
          ],
          ),
        ),
      );
  }
}
