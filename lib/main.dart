import 'package:flutter/material.dart';
import 'dart:math';
 
void main() => runApp(MyAppIMC());
 
class MyAppIMC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Variables
  var heightController = TextEditingController();
  var weightController = TextEditingController();

  Color femaleIconColor = Colors.indigo;
  Color maleIconColor = Colors.grey;
  String gender = 'mujeres';
  double imc = 0.0;

  // Methods
  calculateIMC() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text);

    // Formula: kg / (m)^2
    imc = double.parse((weight / pow(height, 2)).toStringAsFixed(2));
  }

  displayIMC(BuildContext context) {
    calculateIMC();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tu IMC: $imc'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Tabla del IMC para $gender'),
                SizedBox(height: 10,),
                Text('Edad    IMC ideal'),
                Text('19-24   19-24'),
                Text('25-34   20-25'),
                Text('35-44   21-26'),
                Text('45-54   22-27'),
                Text('55-64   23-28'),
                Text('65+      24-29'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Aceptar',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcular IMC'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weightController.clear();
                heightController.clear();
                femaleIconColor = Colors.indigo;
                maleIconColor = Colors.grey;
                gender = 'mujeres';
              });


            },
            icon: Icon(
              Icons.delete_forever,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ingrese sus datos para calcular el IMC',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  onPressed: () {
                    print('Female');
                    setState(() {
                      femaleIconColor = Colors.indigo;
                      maleIconColor = Colors.grey;
                      gender = 'mujeres';
                    });
                  },
                  icon: Icon(
                    Icons.female,
                    color: femaleIconColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  onPressed: (){
                    print('Male');
                    setState(() {
                      femaleIconColor = Colors.grey;
                      maleIconColor = Colors.indigo;
                      gender = 'hombres';
                    });
                  },
                  icon: Icon(
                    Icons.male,
                    color: maleIconColor,
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            leading: Icon(
              Icons.square_foot,
            ),
            title: TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ingresar altura (Metros)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10,),
          ListTile(
            leading: Icon(
              Icons.monitor_weight,
            ),
            title: TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ingresar peso (KG)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                child: Text(
                  'Calcular',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => displayIMC(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}