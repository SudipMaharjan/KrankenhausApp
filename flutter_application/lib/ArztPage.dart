import 'package:flutter/material.dart';
import 'Krankenhaus.dart';
import 'behandlungPage.dart';

class ArztPage extends StatefulWidget {
  final double fSize;
  const ArztPage({super.key, required this.fSize});

  @override
  _ArztPageState createState() => _ArztPageState();
}

class _ArztPageState extends State<ArztPage> {
  String nachricht = 'Willkommen auf der Arztseite!';
  int _selectedIndex = 0;
  Krankenhaus krankenhaus = locator<Krankenhaus>();
  late int totalTiles;
  int clickedTilesCount = 0;  

  @override
  void initState(){
    super.initState();
    totalTiles = krankenhaus.getPatient().length;
    krankenhaus.getPatient().forEach((patient) {
      if(patient.isVisited){
        ++clickedTilesCount;
      }
    });
  }  

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTileClicked(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BehandlungPage(patient: krankenhaus.getPatient()[index], fSize: widget.fSize),
      ),
    );

    setState(() {
        if (!krankenhaus.getPatient()[index].isVisited) {
          krankenhaus.getPatient()[index].isVisited = true;
          clickedTilesCount ++;
        }
      
      if(clickedTilesCount == totalTiles){
        krankenhaus.getPatient().forEach((patient) {
          patient.isVisited = false;
        });
        clickedTilesCount = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Arzt',
          style:TextStyle(fontSize: widget.fSize + 5)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize:  const Size.fromHeight(20),
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
        child: _selectedIndex == 0 ? _buildPatientenListe() : _buildEinstellung()
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.healing), 
            label: 'Meine Patienten'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), 
            label: 'Einstellungen',
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
            subtitle: Text(
              krankenhaus.getPatient()[index].zustand, 
              style: TextStyle(
                color: krankenhaus.getPatient()[index].zustand == "gesund" ? Colors.green : Colors.red,
              ),
            ),
            onTap: () {
              _onTileClicked(index);
            },
            trailing: krankenhaus.getPatient()[index].isVisited ? const Icon(Icons.check_circle,color: Colors.green,) : null,
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
                  'Name: Mustermann',
                  style: TextStyle(fontSize: widget.fSize, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Vorname: Max',
                  style: TextStyle(fontSize: widget.fSize, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Rolle: Arzt',
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
          const SizedBox(height: 20.0),
        ],
        ),
      ),
    );
  }
}
