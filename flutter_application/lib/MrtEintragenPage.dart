import 'package:flutter/material.dart';
import 'Patient.dart';

class MrtEintragenPage extends StatefulWidget{
  final Patient patient;
  final double fSize;

  MrtEintragenPage({Key ? key, required this.patient, required this.fSize}) : super(key: key);

  @override
  _MrtEintragenPage createState() => _MrtEintragenPage();
}

class _MrtEintragenPage extends State<MrtEintragenPage>{
  String selectedImage = 'path';

  @override
  void dispose(){
    super.dispose();
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
                'Mrt eintragen: ${widget.patient.name}(${widget.patient.zimmer})',
                style: TextStyle(fontSize: widget.fSize + 5, color: Colors.white),
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
            children: [
              const SizedBox(height:15), 
              Text(
                'Klicken Sie ein Bild zum Auswählen', 
                style: TextStyle(fontSize: widget.fSize),
              ),
              const SizedBox(height:10), 
              _buildSelectableImage('mrt_meniskus', 'assets/mrt_meniskus.jpg'),
              _buildSelectableImage('mrt_nieren', 'assets/mrt_nieren.jpg'),
              _buildSelectableImage('mrt_wirbelsaeule', 'assets/mrt_wirbelsaeule.jpg'),
              _buildSelectableImage('mrt_wirbelsäule1', 'assets/mrt_wirbelsäule1.jpg'),
            ],
          )
        ),
      )
    );
  }
  Widget _buildSelectableImage(String label, String imagePath) {
    return GestureDetector(
      onTap: () {
        if (!widget.patient.hasMRT(imagePath)) {
          setState(() {
            selectedImage = imagePath;
            widget.patient.setHasMRI(false);
          });
          
          widget.patient.mrtbild_hinzufuegen(selectedImage);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:  Text(
                'MRT-Bild hinzugefügt',
                style: TextStyle(fontSize: widget.fSize),),
            ),
          );
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:  Text(
                'Dieses MRT-Bild ist schon hinzugefügt',
                style: TextStyle(fontSize: widget.fSize),),
            ),
          );
        }
      },
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 100,
            width: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: widget.fSize),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
